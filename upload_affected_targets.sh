#!/usr/bin/env bash

set -euo pipefail

fetch() {
  git -c protocol.version=2 fetch -q \
    --no-tags \
    --no-recurse-submodules \
    "$@"
}

# Install the bazel-diff JAR. Avoid cloning the repo, as there will be conflicting WORKSPACES.
curl -Lo bazel-diff.jar https://github.com/Tinder/bazel-diff/releases/latest/download/bazel-diff_deploy.jar

# Assumption: a WORKSPACE file exists at the root of the caller's repo
# TODO: Should be overridable
workspace_path=$(pwd)

# Hashes:
HEAD_SHA=$(git rev-parse HEAD)
fetch --depth=2 origin "${HEAD_SHA}"
BASE_SHA=$(git rev-parse HEAD^1)
THIRD_SHA=$(git rev-parse HEAD^2)
HEAD_OUT=./${HEAD_SHA}
BASE_OUT=./${BASE_SHA}

echo "Head Sha: " $HEAD_SHA
echo "Base Sha: " $BASE_SHA
echo "Third Sha: " $THIRD_SHA

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
