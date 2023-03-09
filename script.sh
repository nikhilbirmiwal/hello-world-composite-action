#!/usr/bin/env bash

workspace_path=${GITHUB_ACTION_PATH} # may not always be the case?

java -jar bazel-diff.jar generate-hashes --workspacePath=$workspace_path 