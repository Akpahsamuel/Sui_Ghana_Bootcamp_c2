

module functionexample::vectors{
    // Import the debug module to print values during execution
    use std::debug;

    /// Creates and initializes a vector of u64 integers
    /// 
    /// # Returns
    /// * A vector containing the values [1, 2, 3, 4, 5]
    ///
    /// # Example
    /// ```
    /// let my_vector = create_vector();
    /// // my_vector now contains [1, 2, 3, 4, 5]
    /// ```
    public fun create_vector(): vector<u64> {
        // Create an empty vector (not used but shown as an example of vector::empty)
        let _empty_vector = vector::empty<u64>();

        // Create a vector with initial values using the vector literal syntax
        let initial_vector = vector[1, 2, 3, 4, 5];

        // Return the initialized vector
        return initial_vector
    }

    /// Adds multiple elements to the end of a vector
    /// 
    /// # Parameters
    /// * `vec`: A mutable reference to a vector of u64 integers
    ///
    /// # Side Effects
    /// * Modifies the input vector by adding elements 6 through 10
    ///
    /// # Example
    /// ```
    /// let mut v = vector[1, 2, 3];
    /// add_elements(&mut v);
    /// // v now contains [1, 2, 3, 6, 7, 8, 9, 10]
    /// ```
    public fun add_elements(vec: &mut vector<u64>){
        // Add elements to the end of the vector using push_back
        vector::push_back(vec, 6);
        vector::push_back(vec, 7);
        vector::push_back(vec, 8);
        vector::push_back(vec, 9);
        vector::push_back(vec, 10);
    }


    /// Demonstrates how to read elements from a vector
    /// 
    /// # Parameters
    /// * `vec`: An immutable reference to a vector of u64 integers
    ///
    /// # Side Effects
    /// * Prints the values at indices 0, 1, and 5 to the debug console
    ///
    /// # Note
    /// * This function assumes that the vector has at least 6 elements
    /// * vector::borrow returns a reference to the element, not the element itself
    ///
    /// # Example
    /// ```
    /// let v = vector[10, 20, 30, 40, 50, 60];
    /// read_elements(&v); // Prints: 10, 20, 60
    /// ```
    public fun read_elements(vec: &vector<u64>) {
        // Get references to elements at specific indices using vector::borrow
        let first_element = vector::borrow(vec, 0);  // Reference to element at index 0
        let second_element = vector::borrow(vec, 1); // Reference to element at index 1
        let third_element = vector::borrow(vec, 5);  // Reference to element at index 5

        // Print the values (dereferenced automatically by debug::print)
        debug::print(first_element);
        debug::print(second_element);
        debug::print(third_element);
    }


    /// Updates elements in a vector at specific indices
    /// 
    /// # Parameters
    /// * `vec`: A mutable reference to a vector of u64 integers
    /// * `_index`: Unused parameter (could be used to specify which index to update)
    /// * `_value`: Unused parameter (could be used to specify the new value)
    ///
    /// # Side Effects
    /// * Modifies the vector by setting elements at indices 0, 1, and 2 to new values
    ///
    /// # Note
    /// * This function ignores the _index and _value parameters and uses hardcoded values
    /// * vector::borrow_mut returns a mutable reference that needs to be dereferenced with * for assignment
    ///
    /// # Example
    /// ```
    /// let mut v = vector[1, 2, 3, 4, 5];
    /// update_elements(&mut v, 0, 0); // Ignores parameters and sets [0]=100, [1]=200, [2]=300
    /// // v now contains [100, 200, 300, 4, 5]
    /// ```
    public fun update_elements(vec: &mut vector<u64>, _index: u64, _value: u64) {
        // Update elements at specific indices using vector::borrow_mut
        // The * operator is used to dereference the mutable reference for assignment
        *vector::borrow_mut(vec, 0) = 100; // Set element at index 0 to 100
        *vector::borrow_mut(vec, 1) = 200; // Set element at index 1 to 200
        *vector::borrow_mut(vec, 2) = 300; // Set element at index 2 to 300
    }

    /// Removes the last element from a vector
    /// 
    /// # Parameters
    /// * `vec`: A mutable reference to a vector of u64 integers
    ///
    /// # Side Effects
    /// * Removes the last element from the vector
    ///
    /// # Note
    /// * This function will panic if the vector is empty
    /// * vector::pop_back removes and returns the last element, but this function discards the return value
    ///
    /// # Example
    /// ```
    /// let mut v = vector[1, 2, 3, 4, 5];
    /// delete_elements(&mut v);
    /// // v now contains [1, 2, 3, 4]
    /// ```
    public fun delete_elements(vec: &mut vector<u64>) {
        // Remove the last element from the vector using pop_back
        // The return value (the removed element) is discarded
        vector::pop_back(vec);
    }


    /// Gets the number of elements in a vector
    /// 
    /// # Parameters
    /// * `vec`: An immutable reference to a vector of u64 integers
    ///
    /// # Note
    /// * This function calculates the length but doesn't return or use it
    /// * To make this function useful, it should return the length value
    ///
    /// # Example
    /// ```
    /// let v = vector[1, 2, 3, 4, 5];
    /// elements_length(&v); // Calculates length (5) but doesn't return it
    /// ```
    public fun elements_length(vec: &vector<u64>) {
        // Get the number of elements in the vector
        // The result is calculated but not returned or used
        vector::length(vec);
    }


    /// Checks if a vector contains a specific value and prints the result
    /// 
    /// # Parameters
    /// * `vec`: An immutable reference to a vector of u64 integers
    /// * `value`: The value to search for in the vector
    ///
    /// # Side Effects
    /// * Prints a boolean indicating whether the value was found to the debug console
    ///
    /// # Note
    /// * This function uses the standard library's vector::contains function
    /// * The value parameter is passed by reference to vector::contains
    ///
    /// # Example
    /// ```
    /// let v = vector[1, 2, 3, 4, 5];
    /// contains_element(&v, 3); // Prints: true
    /// contains_element(&v, 6); // Prints: false
    /// ```
    public fun contains_element(vec: &vector<u64>, value: u64) {
        // Check if the vector contains the specified value
        // Note that vector::contains expects a reference to the value
        let contains = vector::contains(vec, &value);

        // Print the result (true if found, false if not found)
        debug::print(&contains);
    }



    /// Custom implementation to check if a vector contains a specific element
    /// 
    /// # Parameters
    /// * `vec`: An immutable reference to a vector of u64 integers
    /// * `element`: The value to search for in the vector
    ///
    /// # Returns
    /// * `bool`: true if the element is found, false otherwise
    ///
    /// # Note
    /// * This is a custom implementation that manually iterates through the vector
    /// * It demonstrates how vector::contains might be implemented internally
    /// * Unlike vector::contains, this takes the element by value, not by reference
    ///
    /// # Example
    /// ```
    /// let v = vector[1, 2, 3, 4, 5];
    /// let found = contains(&v, 3); // Returns true
    /// let not_found = contains(&v, 6); // Returns false
    /// ```
    public fun contains(vec: &vector<u64>, element: u64): bool {
        let mut i = 0;
        let len = vector::length(vec);
        
        // Iterate through each element in the vector
        while (i < len) {
            // Compare the current element with the target element
            // Note the dereference (*) to get the value from the reference
            if (*vector::borrow(vec, i) == element) {
                return true  // Element found, return immediately
            };
            i = i + 1;
        };
        
        // Element not found after checking all elements
        false
    }




    /// Calculates the sum of all elements in a vector
    /// 
    /// # Parameters
    /// * `vec`: An immutable reference to a vector of u64 integers
    ///
    /// # Returns
    /// * `u64`: The sum of all elements in the vector
    ///
    /// # Note
    /// * This function demonstrates how to iterate through a vector and accumulate a result
    /// * It uses vector::borrow to access each element and dereferences the returned reference
    ///
    /// # Example
    /// ```
    /// let v = vector[1, 2, 3, 4, 5];
    /// let total = sum_vector(&v); // Returns 15 (1+2+3+4+5)
    /// ```
    public fun sum_vector(vec: &vector<u64>): u64 {
        let mut sum = 0;  // Initialize sum to zero
        let mut i = 0;    // Initialize index counter
        let len = vector::length(vec);  // Get the vector length once
        
        // Iterate through each element in the vector
        while (i < len) {
            // Add the current element to the running sum
            // Note the dereference (*) to get the value from the reference
            sum = sum + *vector::borrow(vec, i);
            i = i + 1;
        };

        // Return the final sum
        sum
    }


}