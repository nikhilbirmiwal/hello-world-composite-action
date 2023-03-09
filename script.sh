#!/usr/bin/env bash

# default: a WORKSPACE file exists at the root of the caller's repo
# TODO: overridable
workspace_path=$(pwd)

# hashes:
HEAD_OUT=./$HEAD_SHA
BASE_OUT=./$BASE_SHA

echo $HEAD_SHA . "->" $HEAD_OUT
echo $BASE_SHA . "->" $BASE_OUT

java -jar bazel-diff.jar generate-hashes --workspacePath=$workspace_path $HEAD_OUT

cat $HEAD_OUT