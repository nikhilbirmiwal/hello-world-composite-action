#!/usr/bin/env bash

echo "pwd"
pwd

echo "contents"
find .

bazel_path=$(which bazel)

java -jar bazel-diff.jar generate-hashes --bazelPath=$bazel_path --workspacePath=$GITHUB_ACTION_PATH