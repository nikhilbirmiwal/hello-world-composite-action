bazel_path=$(which bazel)
workspace_path=$GITHUB_ACTION_PATH/WORKSPACE # should not be assumed
curr_sha=$(git rev-parse HEAD)

echo $bazel_path
echo $workspace_path
echo $curr_sha

echo "Running command"

cd tools/ # should be a known tmp directory. maybe trunk-prefixed?
bazel run :bazel-diff -- --verison # should we even be cloning the repo into the directory?
