echo "pwd"
pwd

find .

bazel_path=$(which bazel)
workspace_path=//...

echo $bazel_path
echo $workspace_path
echo $curr_sha

./tools/bazel-diff-example.sh $bazel_path $workspace_path $curr_sha $curr_sha