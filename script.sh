echo "Action Path"
echo $GITHUB_PATH

echo "pwd"
pwd

echo "curr-sha"
curr_sha=$(git rev-parse HEAD)
echo $curr_sha

find .

bazel run ./tools/:bazel-diff -- bazel-diff -h