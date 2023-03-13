echo "Timing a full bazel query"
time bazel query --output streamed_proto --order_output=no --keep_going "kind('source file', //...:all-targets)"