#!/usr/bin/env bash

# default: a WORKSPACE file exists at the root of the caller's repo
# TODO: overridable
workspace_path=$(pwd)

# hashes:
curr_hash=$(git rev-parse HEAD)
curr_json_out=./$curr_hash

echo $curr_hash . "->" $curr_json_out
java -jar bazel-diff.jar generate-hashes --workspacePath=$workspace_path $curr_json_out

cat $curr_json_out