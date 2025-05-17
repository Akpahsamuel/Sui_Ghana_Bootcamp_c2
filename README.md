# Sui_Ghana_Bootcamp_c2
# Lion.sui

## Sui Ghana Bootcamp - Function Examples Project

This repository contains projects and exercises developed during the Sui Ghana Bootcamp - an intensive training program focused on blockchain development using the Sui Move programming language.

### About

This collection showcases various modules and smart contracts built on the Sui blockchain platform, demonstrating fundamental and advanced concepts of Move programming. The project includes examples of functions, structs, and testing methodologies in the Move language.

### Project Structure

```
├── sources/
│   ├── functionexample.move   # Examples of different function types and testing
│   └── funtion.move           # Examples of struct definitions and object creation
├── tests/
│   └── functionexample_tests.move  # External test cases
└── build/                     # Compiled bytecode and dependencies
```

### Modules Overview

#### 1. Function Examples (`functionexample.move`)

This module demonstrates various patterns for defining and using functions in Move:

- Basic functions without parameters or return values
- Functions with parameters and return values
- Functions with multiple return values using tuples
- Private helper functions
- Functions with conditional logic and early returns
- Error handling with assertions and aborts
- Test functions with different testing patterns

#### 2. Struct Examples (`funtion.move`)

This module showcases different struct types and their creation functions:

- **Person**: Basic struct with personal information (name, age, height, weight, complexity)
- **Student**: Struct with the `key` ability for storage, containing academic information
- **Results**: Struct with `store` and `copy` abilities for academic performance data
- **Point**: Struct representing a 2D coordinate with the `key` ability

Each struct includes associated constructor functions that demonstrate proper object creation patterns.

### Learning Outcomes

- Move programming fundamentals
- Sui blockchain architecture
- Smart contract development and testing
- Object-capability model
- Function patterns and best practices
- Struct definition and usage
- Error handling techniques
- Module design patterns

### Technologies

- Sui Move language
- Sui CLI
- Move Package Manager

### Usage

To build the project:
```bash
sui move build
```

To run tests:
```bash
sui move test
```

### Date

Last updated: May 17, 2025
