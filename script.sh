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
echo "head sha:" $HEAD_SHA
echo "base sha:" $BASE_SHA

# Move the directory so workspaces don't conflict.
mv tmp ../tmp
cd ../tmp

bazel run //:bazel-diff -- generate-hashes --workspacePath=$workspace_path

# TODO: 
# - Invoke the /uploadAffectedTargets API