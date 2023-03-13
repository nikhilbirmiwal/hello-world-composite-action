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
head_sha=$(git rev-parse HEAD)
fetch --depth=2 origin "${head_sha}"
upstream=$(git rev-parse HEAD^1)
git_commit=$(git rev-parse HEAD^2)
upstream_out=./${upstream}
git_commit_out=./${git_commit}

echo "Upstream Sha: " $upstream
echo "Git Commit Sha: " $git_commit

# Generate hashes for the HEAD and BASE shas.
git checkout --quiet "${git_commit}"
java -jar bazel-diff.jar generate-hashes --workspacePath="${workspace_path}" "${git_commit_out}"

git checkout --quiet "${upstream}"
java -jar bazel-diff.jar generate-hashes --workspacePath="${workspace_path}" "${upstream_out}"

# Upload affected targets.
java -jar bazel-diff.jar get-impacted-targets --startingHashes="${upstream_out}" --finalHashes="${git_commit_out}"
# TODO: Invoke the /uploadAffectedTargets API
