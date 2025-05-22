#[allow(duplicate_alias)]

/// Module for managing student records in a decentralized system
/// This module provides functionality to register students, manage their grades,
/// and perform various operations on student data
module functionexample::student {
    use std::string::{Self, String};
    use sui::dynamic_object_field as dof;
    use sui::event;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    // Error codes
    /// Error code when attempting to access a student that doesn't exist
    const EStudentNotFound: u64 = 0;
    /// Error code when a non-owner tries to perform an owner-only operation
    const ENotOwner: u64 = 1;

    /// Student struct to store individual student information
    /// Contains a unique identifier, name, and a vector of grades
    public struct Student has key, store {
        id: UID,
        name: String,
        grades: vector<u8>
    }

    /// Registry to store and manage all students in the system
    /// Only the owner can perform certain administrative operations
    public struct StudentRegistry has key {
        id: UID,
        owner: address,
        student_count: u64
    }

    // Events
    /// Event emitted when a new student is registered in the system
    public struct StudentRegistered has copy, drop {
        student_id: address,
        name: String
    }

    /// Event emitted when a grade is added to a student's record
    public struct GradeAdded has copy, drop {
        student_id: address,
        grade: u8
    }

    /// Initialize the student registry
    /// This function is called once when the module is published
    /// Creates and shares the StudentRegistry object
    fun init(ctx: &mut TxContext) {
        let registry = StudentRegistry {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            student_count: 0
        };
        
        // Make the registry accessible to everyone
        transfer::share_object(registry);
    }

    /// Register a new student in the system
    /// 
    /// # Arguments
    /// * `registry` - Mutable reference to the student registry
    /// * `name` - Byte vector representing the student's name
    /// * `ctx` - Transaction context
    public entry fun register_student(
        registry: &mut StudentRegistry,
        name: vector<u8>,
        ctx: &mut TxContext
    ) {
        // Convert byte vector to String
        let student_name = string::utf8(name);
        
        // Create a new student object
        let student = Student {
            id: object::new(ctx),
            name: student_name,
            grades: vector::empty<u8>()
        };
        
        // Get the ID as an address for events and dynamic field
        let student_id = object::uid_to_address(&student.id);
        
        // Add student to registry using dynamic object fields
        dof::add(&mut registry.id, student_id, student);
        
        // Increment student count
        registry.student_count = registry.student_count + 1;
        
        // Emit registration event
        event::emit(StudentRegistered {
            student_id,
            name: student_name
        });
    }

    /// Add a grade to a student's record
    /// Only the registry owner can add grades
    /// 
    /// # Arguments
    /// * `registry` - Mutable reference to the student registry
    /// * `student_id` - Address of the student
    /// * `grade` - Grade to be added (as u8)
    /// * `ctx` - Transaction context
    public entry fun add_grade(
        registry: &mut StudentRegistry,
        student_id: address,
        grade: u8,
        ctx: &mut TxContext
    ) {
        // Check if caller is registry owner
        assert!(registry.owner == tx_context::sender(ctx), ENotOwner);
        
        // Check if student exists and get a mutable reference
        assert!(dof::exists_(&registry.id, student_id), EStudentNotFound);
        
        let student = dof::borrow_mut<address, Student>(&mut registry.id, student_id);
        
        // Add grade to student's grade vector
        vector::push_back(&mut student.grades, grade);
        
        // Emit grade added event
        event::emit(GradeAdded {
            student_id,
            grade
        });
    }
    
    /// View a student's information (name and grades)
    /// This is a read-only function that returns copies of the data
    /// 
    /// # Arguments
    /// * `registry` - Reference to the student registry
    /// * `student_id` - Address of the student
    /// 
    /// # Returns
    /// * Tuple containing the student's name and grades
    public fun view_student_info(
        registry: &StudentRegistry,
        student_id: address
    ): (String, vector<u8>) {
        // Check if student exists
        assert!(dof::exists_(&registry.id, student_id), EStudentNotFound);
        
        let student = dof::borrow<address, Student>(&registry.id, student_id);
        
        // Return a copy of student's name and grades
        (student.name, *&student.grades)
    }
    
    /// Update a student's name
    /// Only the registry owner can update student names
    /// 
    /// # Arguments
    /// * `registry` - Mutable reference to the student registry
    /// * `student_id` - Address of the student
    /// * `new_name` - Byte vector representing the new name
    /// * `ctx` - Transaction context
    public entry fun update_student_name(
        registry: &mut StudentRegistry,
        student_id: address,
        new_name: vector<u8>,
        ctx: &mut TxContext
    ) {
        // Check if caller is registry owner
        assert!(registry.owner == tx_context::sender(ctx), ENotOwner);
        
        // Check if student exists
        assert!(dof::exists_(&registry.id, student_id), EStudentNotFound);
        
        let student = dof::borrow_mut<address, Student>(&mut registry.id, student_id);
        
        // Update name
        student.name = string::utf8(new_name);
    }
    
    /// Get the total number of students in the registry
    /// 
    /// # Arguments
    /// * `registry` - Reference to the student registry
    /// 
    /// # Returns
    /// * Total count of students as u64
    public fun get_student_count(registry: &StudentRegistry): u64 {
        registry.student_count
    }
    
    /// Calculate the average grade of a student
    /// Returns 0 if the student has no grades
    /// 
    /// # Arguments
    /// * `registry` - Reference to the student registry
    /// * `student_id` - Address of the student
    /// 
    /// # Returns
    /// * Average grade as u8
    public fun calculate_average(
        registry: &StudentRegistry,
        student_id: address
    ): u8 {
        // Check if student exists
        assert!(dof::exists_(&registry.id, student_id), EStudentNotFound);
        
        let student = dof::borrow<address, Student>(&registry.id, student_id);
        let grades = &student.grades;
        
        // If no grades, return 0
        if (vector::is_empty(grades)) {
            return 0
        };
        
        let mut sum: u64 = 0;
        let mut i = 0;
        let len = vector::length(grades);
        
        while (i < len) {
            sum = sum + (*vector::borrow(grades, i) as u64);
            i = i + 1;
        };
        
        // Calculate and return average as u8
        ((sum / len) as u8)
    }
}