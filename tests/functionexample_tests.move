/*
#[test_only]
module functionexample::functionexample_tests;
// uncomment this line to import the module
// use functionexample::functionexample;

const ENotImplemented: u64 = 0;

#[test]
fun test_functionexample() {
    // pass
}

#[test, expected_failure(abort_code = ::functionexample::functionexample_tests::ENotImplemented)]
fun test_functionexample_fail() {
    abort ENotImplemented
}
*/


sui client call \
    --package 0xd5cee45462dc239aaabb624c745f5c8301bc37e889299f0bc17a7bf24b2d3c3e \
    --module student \
    --function view_student_info \
    --args 0x07cc2557dd2a556855a3842cf50455c9d0a4948f052a8c7456457824082e2aa3 0xb00b8332af6623bc15363865bc070111dcf578a6f4819ad445c555c93bf364e5\
    --gas-budget 100000000
