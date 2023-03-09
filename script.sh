bazel_path=$(which bazel)
workspace_path=$GITHUB_ACTION_PATH/WORKSPACE # should not be assumed
curr_sha=$(git rev-parse HEAD)

echo $bazel_path
echo $workspace_path
echo $curr_sha

echo "Running command"

cd tools/ || exit
chmod a+x bazel-diff-example.sh

./bazel-diff-example.sh "$bazel_path" "$workspace_path" "$curr_sha" "$curr_sha"
