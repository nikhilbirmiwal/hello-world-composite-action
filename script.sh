#!/usr/bin/env bash

workspace_path=$(pwd)

# hashes:
curr_hash=$(git rev-parse HEAD)
curr_json_out=./$curr_hash

echo $curr_hash . "->" $curr_json_out

# assumptions made:
#   - java is installed (should be fine)
#   - install_bazel_diff was already invoked, and this script is being executed in the same location
#   - the WORKSPACE file exists at the root of the repo.
java -jar bazel-diff.jar generate-hashes --workspacePath=$workspace_path $curr_json_out

cat $curr_json_out