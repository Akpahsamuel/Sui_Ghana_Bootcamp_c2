// This is a Move module - a collection of related functions and data structures
// The module name is prefixed with the package name: functionexample::functionexample
module functionexample::functionexample{
    // Import the debug module from the standard library to enable printing values
    use std::debug;

    // 1. Basic function example with no parameters and no return value
    // 'public' means this function can be called from other modules
    // Functions without a return type implicitly return an empty tuple '()'
    public fun basic_function() {
        // Function logic goes here
        // For example, you can print a message to the console
        // Note: In Move, functions should have some effect or return something useful
    }

    // 2. Function with parameters and return value that uses a private helper function
    // This function takes two unsigned 64-bit integers and returns another u64
    public fun add(a: u64, b: u64): u64 {
        // We're calling the private_helper function with the parameters
        // In Move, the last expression becomes the return value if there's no explicit return statement
        private_helper(a, b)
        // The value returned by private_helper becomes the return value of this function
    }

    // 3. Function with multiple parameters and multiple return values
    // Move supports returning multiple values using tuples
    public fun calculator(a: u64, b: u64): (u64, u64, u64, u64) {
        // Return a tuple containing four values
        assert!(b != 0, 0x01);
        // This assert checks if b is not zero before performing division
        (
            a + b, // sum
            a - b, // difference
            a * b, // product
            a / b  // quotient - note: this will abort if b is zero
            )
        }

    // 4. Private function (not accessible outside the module)
    // Functions without the 'public' keyword are private by default
    // Private functions can only be called by other functions in the same module
    fun private_helper(value1: u64, value2: u64): u64 {
        // Function logic goes here
        // Here we're adding two values and returning the result
        // 'return' keyword is optional - the last expression is automatically returned
        return value1 + value2
    }

    // 5. Function with early return
    // This function demonstrates the use of conditional statements and early returns
    // It takes two unsigned 64-bit integers and returns the smaller of the two
    public fun find_minimum(a: u64, b: u64): u64 {
        if (a < b) {
            return a
        } else {
            return b
        } 
    }

    // 6. Function making use of named return values
    // This function demonstrates the use of named return values and aborts
    // It takes an abort code, two unsigned 64-bit integers, and returns their quotient and remainder
    public fun divmod(abort_code: u64, a: u64, b: u64): (u64, u64) {
        if (b == 0) {
            abort abort_code
        };
       
        let quotient = a / b;
        let remainder = a % b;
        (quotient, remainder)
    }

    // Function making use of asserts
    // This function demonstrates the use of assertions to enforce conditions
    // It takes two unsigned 64-bit integers and returns their quotient and remainder
    public fun divmod_making_use_of_asserts( a: u64, b: u64): (u64, u64) {
        assert!(b != 0, 0x01);
        let quotient = a / b;
        let remainder = a % b;
        (quotient, remainder)
    }

    // Entry functions
    // Entry functions are the main functions that can be invoked by transactions
    // They are typically used to modify the blockchain state

    // Test functions
    // Test functions are used to verify the correctness of the module's logic
    
    // SIMPLE TEST EXAMPLE
    // The #[test] attribute marks this as a test function that will run during test execution
    // This is the simplest form of test - it just calls a function without checking any results
    #[test]
    public fun test_basic_function() {
        // Call the basic function with no parameters
        // This test simply verifies that the function runs without aborting
        // It doesn't check any return values since basic_function() doesn't return anything
        basic_function();
        
        // This kind of simple test is useful for functions that:
        // 1. Have no return values
        // 2. Only produce side effects (like writing to storage, which we'd test differently)
        // 3. Just need to be verified not to abort/crash under normal conditions
    }

    // EXPECTED FAILURE TEST EXAMPLE
    // The #[expected_failure] attribute indicates that this test is expected to fail
    // This pattern is useful for testing that your functions properly validate inputs
    // or enforce constraints by aborting with appropriate error codes
    #[test]
    #[expected_failure]
    public fun test_add() {
        // Call the add function and store the result
        let result = add(5, 10);
        
        // This assertion is deliberately incorrect - add(5, 10) should return 15, not 50
        // The test is marked as #[expected_failure] because we want to verify that
        // the assertion will fail, confirming our error handling works correctly
        assert!(result == 50, 0x01);
        
        // debug::print is used to output values during test execution
        // Useful for debugging when tests fail
        // The & symbol creates a reference to the value, which is required by debug::print
        debug::print(&result);
        
        // NOTE: This print statement won't execute because the assertion will abort first
        // This demonstrates the "short-circuit" behavior of assertions
    }

    // COMPREHENSIVE TEST EXAMPLE
    // This test verifies multiple return values from a function
    // It demonstrates how to properly test functions that return tuples
    #[test]
    public fun test_calculator() {
        // Call the calculator function with test inputs and destructure the returned tuple
        // Destructuring assigns each element of the tuple to a separate variable
        let (sum, difference, product, quotient) = calculator(20, 5);

        // MULTIPLE ASSERTIONS
        // This pattern tests each return value separately with a distinct error code
        // Using separate asserts helps identify exactly which calculation failed
        
        // Check that 20 + 5 = 25
        assert!(sum == 25, 0x01);
        
        // Check that 20 - 5 = 15
        assert!(difference == 15, 0x02);
        
        // Check that 20 * 5 = 100
        assert!(product == 100, 0x03);
        
        // Check that 20 / 5 = 4
        assert!(quotient == 4, 0x04);
        
        // TESTING STRATEGY:
        // 1. Each assert has a unique error code (0x01, 0x02, etc.)
        // 2. If any assertion fails, the test aborts with that specific code
        // 3. This makes it easy to identify which calculation has a problem
    }

    // TEST WITH DEBUG OUTPUT
    // This test demonstrates how to use debug::print to inspect values during testing
    #[test]
    public fun divmod_test() {
        // Call the divmod function with an error code and test inputs
        // 0x01 is the error code that would be used if division by zero occurs
        // 20 divided by 3 gives quotient 6 with remainder 2
        let (quotient, remainder) = divmod(0x01, 20, 3);

        // VALIDATING RESULTS
        // These assertions verify the correctness of the calculation
        // Integer division of 20/3 should give quotient 6
        assert!(quotient == 6, 0x01);
        
        // The remainder of 20/3 should be 2
        assert!(remainder == 2, 0x02);

        // DEBUGGING OUTPUT
        // These statements print the actual results to help with debugging
        // They execute only if all assertions pass
        debug::print(&quotient);  // Should print 6
        debug::print(&remainder); // Should print 2
        
        // This pattern is useful during development to see the actual values
        // For production tests, assertions are usually sufficient without debug prints
    }
}


