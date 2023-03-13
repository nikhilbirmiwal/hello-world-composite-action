#!/usr/bin/env bash

set -euo pipefail

if [[ -z ${HEAD_SHA} ]]; then
	exit 2
fi

if [[ -z ${BASE_SHA} ]]; then
	exit 2
fi

# Install the bazel-diff JAR. Avoid cloning the repo, as there will be conflicting WORKSPACES.
curl -Lo bazel-diff.jar https://github.com/Tinder/bazel-diff/releases/latest/download/bazel-diff_deploy.jar

# Assumption: a WORKSPACE file exists at the root of the caller's repo
# TODO: Should be overridable
workspace_path=$(pwd)
bazel_path=$(which bazel)

# If we are missing Bazel, install it via Bazelisk.
if [[ -z ${bazel_path} ]]; then
	curl -LO "https://github.com/bazelbuild/bazelisk/releases/download/v1.1.0/bazelisk-linux-amd64"
	mkdir -p "${GITHUB_WORKSPACE}/bin/"
	mv bazelisk-linux-amd64 "${GITHUB_WORKSPACE}/bin/bazel"
	chmod +x "${GITHUB_WORKSPACE}/bin/bazel"
fi

# Hashes:
HEAD_OUT=./${HEAD_SHA}
BASE_OUT=./${BASE_SHA}

# TODO: Avoid fetching _everything_ from this repo.
git fetch --quiet

# Generate hashes for the HEAD and BASE shas.
git checkout --quiet "${BASE_SHA}"
java -jar bazel-diff.jar generate-hashes --workspacePath="${workspace_path}" "${BASE_OUT}"

git checkout --quiet "${HEAD_SHA}"
java -jar bazel-diff.jar generate-hashes --workspacePath="${workspace_path}" "${HEAD_OUT}"

# Upload affected targets.
java -jar bazel-diff.jar get-impacted-targets --startingHashes="${BASE_OUT}" --finalHashes="${HEAD_OUT}"
# TODO: Invoke the /uploadAffectedTargets API
