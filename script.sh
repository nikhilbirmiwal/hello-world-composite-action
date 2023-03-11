#!/usr/bin/env bash

# Assumption: a WORKSPACE file exists at the root of the caller's repo
# TODO: Should be overridable
workspace_path=$(pwd)

# Assumption: a user's bazelrc file exists at the root of the caller's repo, next to the WORKSPACE
# TODO: Should be overridable
BAZEL_RC_PATH=.bazelrc 

# hashes:
HEAD_OUT=./$HEAD_SHA
BASE_OUT=./$BASE_SHA

# Debug Logs
echo $HEAD_SHA
echo $BASE_SHA
echo $BAZEL_RC_PATH

cat .bazelrc

# TODO: This shouldn't be hardcoded to tools.
bazel run //tools:bazel-diff generate-hashes --workspacePath=$workspace_path $HEAD_OUT 

cat $HEAD_OUT

# TODO: 
# - Invoke the /uploadAffectedTargets API