echo "Action Path"
echo $GITHUB_PATH

pwd

curr_sha=$(git rev-parse HEAD)
echo $curr_sha

bazel run //tools:bazel-diff