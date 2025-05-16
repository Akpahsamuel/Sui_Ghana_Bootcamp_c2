


module functionexample::functionexample{
    use std::debug;

   // 1. // basic function example with no parameters and no return value
    public fun basic_function() {
        // Function logic goes here
        // For example, you can print a message to the console
    }

    // 2. // function with parameters and return value making use of private function

    public fun add(a: u64, b: u64): u64 {
        // Function logic goes here
        private_helper(a, b)
        // For example, you can return the sum of a and b
    
    }

// 3. // function with multiple parameters and return value
    public fun calculator(a: u64, b: u64): (u64, u64, u64, u64) {
        (
            a + b, // sum
            a - b, // difference
            a * b, // product
            a / b  // quotient
            )

         }

 // 4. //  private function (not accessible outside the module) 


    fun private_helper(value1: u64, value2: u64): u64 {
        // Function logic goes here
        // For example, you can return the value multiplied by 2
        return value1 + value2
    }
// 5. // functions with early return

    public fun find_minimum(a: u64, b: u64): u64 {
        if (a < b) {
            return a
        } else {
            return b
        } 
        
    }

    // 6. // function making use of named return values

    public fun divmod(abort_code: u64, a: u64, b: u64): (u64, u64) {
        if (b == 0) {
            abort abort_code
        };
       
        let quotient = a / b;
        let remainder = a % b;
        (quotient, remainder)
    }


    public fun divmod_making_use_of_asserts( a: u64, b: u64): (u64, u64) {
        assert!(b != 0, 0x01);
        let quotient = a / b;
        let remainder = a % b;
        (quotient, remainder)
    }






//entry functions
// init funtions










#[test]
    public fun test_basic_function() {
        // Call the basic function
        basic_function();
    }

    #[test]
    #[expected_failure]
    public fun test_add() {
        // Call the add function and store the result
        let result = add(5, 10);
        assert!(result == 50, 0x01);
        debug::print(&result);
    }

    #[test]
    public fun test_calculator() {
        // Call the calculator function and store the results
        let (sum, difference, product, quotient) = calculator(20, 5);

        // Check the results
        assert!(sum == 25, 0x01);
        assert!(difference == 15, 0x02);
        assert!(product == 100, 0x03);
        assert!(quotient == 4, 0x04);
    }

    #[test]
    public fun divmod_test() {
        // Call the divmod function and store the results
        let (quotient, remainder) = divmod(0x01, 20, 3);

        // Check the results
         assert!(quotient == 6, 0x01);
         assert!(remainder == 2, 0x02);

        debug::print(&quotient);
        debug::print(&remainder);
    }
 



}


