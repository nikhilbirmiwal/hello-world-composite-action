find .

bazel_path=$(which bazel)
workspace_path=//...
curr_sha=$(git rev-parse HEAD)

echo $bazel_path
echo $workspace_path
echo $curr_sha

echo "Running command"

./tools/bazel-diff-example.sh $bazel_path $workspace_path $curr_sha $curr_sha