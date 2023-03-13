echo "Timing a full bazel query: source files"
time bazel query --output streamed_proto --order_output=no --keep_going "kind('source file', //...:all-targets)"

echo "Timing a full bazel query: external + all_targets"
time bazel query --output streamed_proto --order_output=no --keep_going "//external:all-targets' + '//...:all-targets'"
