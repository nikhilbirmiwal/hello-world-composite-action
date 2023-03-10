#!/usr/bin/env bash

# Assumption: a WORKSPACE file exists at the root of the caller's repo
# TODO: Should be overridable
workspace_path=$(pwd)

find .

# hashes:
HEAD_OUT=./$HEAD_SHA
BASE_OUT=./$BASE_SHA

# Fetch the latest commits from Git
git fetch 

git checkout "$HEAD_SHA"
java -jar bazel-diff.jar generate-hashes --bazelCommandOptions=--bazelrc=./.bazelc  --verbose --workspacePath=$workspace_path $HEAD_OUT 

git checkout "$BASE_SHA"
java -jar bazel-diff.jar generate-hashes --workspacePath="$workspace_path" "$BASE_OUT"

java -jar bazel-diff.jar get-impacted-targets --startingHashes="$BASE_OUT" --finalHashes="$HEAD_OUT"

# TODO: 
# - Invoke the /uploadAffectedTargets API