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
echo "github workspace:" $GITHUB_WORKSPACE
echo "head sha:" $HEAD_SHA
echo "base sha:" $BASE_SHA

cd $GITHUB_WORKSPACE/tmp

echo "contents of tmp directory"
find .


echo "contents of workspace path"
find $workspace_path

bazel run //:bazel-diff -- -h

# TODO: 
# - Invoke the /uploadAffectedTargets API