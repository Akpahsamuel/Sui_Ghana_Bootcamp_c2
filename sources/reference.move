

/// Module that demonstrates reference usage in Move
///
/// This module shows different ways to use references in Move, including:
/// - Immutable references (read-only access)
/// - Mutable references (read-write access)
/// - Working with multiple references
module functionexample::reference{
    // Import the object module to create unique identifiers
    use sui::object::{Self, UID};
    // Import the transaction context module
    use sui::tx_context::TxContext;

    /// A counter object that can be stored on-chain
    /// 
    /// # Fields
    /// * `id`: Unique identifier for the object
    /// * `value`: The current count value
    public struct Counter1 has key {
        id: UID,       // Unique identifier for this object
        value: u64,    // The counter's current value
    }

    /// A second counter object type for demonstration purposes
    /// 
    /// # Fields
    /// * `id`: Unique identifier for the object
    /// * `value`: The current count value
    public struct Counter2 has key {
        id: UID,       // Unique identifier for this object
        value: u64,    // The counter's current value
    }



    /// Demonstrates how to use an immutable reference to read a value
    /// 
    /// # Parameters
    /// * `counter`: An immutable reference to a Counter1 object
    ///
    /// # Returns
    /// * `u64`: The current value of the counter
    ///
    /// # Note
    /// * This function only reads the value without modifying it
    /// * Immutable references allow read-only access to the object
    ///
    /// # Example
    /// ```
    /// let counter = /* some Counter1 object */;
    /// let value = borrow_immutable_ref(&counter); // Gets the current value
    /// ```
    public fun borrow_immutable_ref(counter: &Counter1): u64 {
        // Access the value field through an immutable reference
        // No need to dereference in Move when accessing struct fields
        counter.value
    }

    /// Creates a new Counter1 object with an initial value of 0
    /// 
    /// # Parameters
    /// * `ctx`: A mutable reference to the transaction context
    ///
    /// # Returns
    /// * `Counter1`: A new Counter1 object with value initialized to 0
    ///
    /// # Note
    /// * This function creates a new object with a unique ID
    /// * The object is returned by value, not by reference
    ///
    /// # Example
    /// ```
    /// let counter = create_counter(ctx);
    /// // counter now has a unique ID and value = 0
    /// ```
    public fun create_counter(ctx: &mut TxContext): Counter1 {
        // Create a new Counter1 object
        Counter1 {
            // Generate a new unique ID for this object
            id: object::new(ctx),
            // Initialize the counter value to 0
            value: 0,
        }
    }



    /// Increments a counter's value by 1 using a mutable reference
    /// 
    /// # Parameters
    /// * `counter`: A mutable reference to a Counter1 object
    ///
    /// # Side Effects
    /// * Modifies the counter by incrementing its value by 1
    ///
    /// # Note
    /// * This function demonstrates how to modify an object through a mutable reference
    /// * Mutable references allow both reading and writing to the object
    ///
    /// # Example
    /// ```
    /// let mut counter = /* some Counter1 object */;
    /// counter_increment(&mut counter);
    /// // counter.value is now increased by 1
    /// ```
    public fun counter_increment(counter: &mut Counter1) {
        // Access and modify the value field through a mutable reference
        // First read the current value, add 1, then write back the new value
        counter.value = counter.value + 1;
    }


    /// Demonstrates working with multiple references simultaneously
    /// 
    /// # Parameters
    /// * `counter1`: An immutable reference to a Counter1 object
    /// * `counter2`: An immutable reference to a Counter2 object
    ///
    /// # Returns
    /// * `u64`: The sum of both counter values
    ///
    /// # Note
    /// * This function shows how to work with multiple references at once
    /// * Both references are immutable (read-only)
    /// * Move allows multiple immutable references to exist simultaneously
    ///
    /// # Example
    /// ```
    /// let counter1 = /* some Counter1 object */;
    /// let counter2 = /* some Counter2 object */;
    /// let sum = borrow_multiple_references(&counter1, &counter2);
    /// // sum now contains counter1.value + counter2.value
    /// ```
    public fun borrow_multiple_references(counter1: &Counter1, counter2: &Counter2): u64 {
        // Read values from both counters through immutable references
        let counter_sum = counter1.value + counter2.value;
        
        // Return the sum of both counter values
        counter_sum
    }













}