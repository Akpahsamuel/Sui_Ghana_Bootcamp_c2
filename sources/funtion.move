module functionexample::structsexample{
    // use sui::object::{Self, UID};
    // use sui::tx_context::{Self, TxContext};

       use std::string::{Self, String};

// Constants representing names - these are byte arrays that can be converted to strings
// const StudentA: vector<u8> = b"samuel kofi";
// const StudentB: vector<u8> = b"samuel kofi";
// const StudentC: vector<u8> = b"samuel kofi";
const PersonA: vector<u8> = b"samuel Atta";
const PersonB: vector<u8> = b"samuel Atta";

/// Student struct representing a student entity in the system
/// This struct has the 'key' ability, allowing it to be stored in global storage
/// @field id - Unique identifier for this object in Sui storage
/// @field name - Student's full name
/// @field age - Student's age in years
/// @field grade - Student's current grade level
/// @field student_id - Unique identifier for the student within the school system
/// @field results - Associated academic results for this student
public struct Student has key {
    id: UID,
    name: String,
    age: u8,
    grade: u8,
    student_id: u64,
    results:Results,
}

/// Results struct for storing academic performance data
/// This struct has 'store' and 'copy' abilities allowing it to be stored inside other objects
/// and copied (pass by value)
/// @field student_id - Identifier linking these results to a specific student
/// @field subject - The academic subject for this result record
/// @field score - Numerical score achieved by the student
public struct Results has store, copy {
    student_id: u64,
    subject: String,
    score: u8
}

/// Person struct for storing basic personal information
/// This is a basic struct without any abilities, limiting where it can be used
/// @field name - Person's full name
/// @field age - Person's age in years
/// @field height - Person's height measurement
/// @field weight - Person's weight measurement
/// @field complexity - Description of the person's complexity/personality
public struct Person{
    name: String,
    age: u8,
    height: u8,
    weight: u8,
    complexity: String,
}

/// Point struct representing a 2D coordinate in a coordinate system
/// This struct has the 'key' ability, allowing it to be stored in global storage
/// @field id - Unique identifier for this object in Sui storage
/// @field x - The x-coordinate value
/// @field y - The y-coordinate value
public struct Point has key {
    id: UID,
    x: u64,
    y: u64
}

/// Creates a new Person object
/// This function constructs a Person struct with personal information
/// @param name - The person's full name
/// @param age - The person's age in years
/// @param height - The person's height measurement
/// @param weight - The person's weight measurement
/// @param complexity - Description of the person's complexity/personality
/// @return Person - A new Person object
public fun create_person(name: String, age: u8, height: u8, weight: u8, complexity: String): Person {
    Person {
        name,
        age,
        height,
        weight,
        complexity,
    } 
}

/// Creates a new Student object
/// This function constructs a Student struct which stores student information
/// @param name - The student's full name
/// @param age - The student's age in years
/// @param grade - The student's current grade level
/// @param student_id - Unique identifier for the student within the school system
/// @param results - Associated academic results for this student
/// @param ctx - Transaction context needed to generate a unique ID
/// @return Student - A new Student object with the key ability
public fun create_student(name: String, age: u8, grade: u8, student_id: u64, results: Results, ctx: &mut TxContext): Student {
    Student {
        id: object::new(ctx),
        name,
        age,
        grade,
        student_id,
        results
    }
}

/// Creates a new Results object
/// This function constructs a Results struct which stores academic performance data
/// @param student_id - Unique identifier for the student, used to link results to a specific student
/// @param subject - The academic subject for which this result is recorded
/// @param score - The numerical score achieved by the student (0-100)
/// @return Results - A new Results object with copy and store abilities
public fun create_results(student_id: u64, subject: String, score: u8): Results {
    Results {
        student_id,
        subject,
        score
    }
}

/// Creates a new Point object with a unique ID
/// This function constructs a Point struct that represents a 2D coordinate
/// The returned object has the 'key' ability making it storable in global storage
/// @param x - The x-coordinate value
/// @param y - The y-coordinate value
/// @param ctx - Transaction context needed to generate a unique ID
/// @return Point - A new Point object with the key ability
public fun create_point(x: u64, y: u64, ctx: &mut TxContext): Point {
    Point {
        id: object::new(ctx),
        x,
        y
    }
}

}













