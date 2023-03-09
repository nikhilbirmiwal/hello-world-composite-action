#!/usr/bin/env bash

# assumptions made:
#   - java is installed (should be fine)
#   - install_bazel_diff was already invoked, and this script is being executed in the same location
#   - the WORKSPACE file exists at the root of the repo.
java -jar bazel-diff.jar generate-hashes --workspacePath=$(pwd)