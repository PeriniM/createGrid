#!/usr/bin/env python3
"""
Simple Python script to add two numbers together.
"""

def add_numbers(num1, num2):
    """
    Add two numbers together and return the result.
    
    Args:
        num1 (float): First number
        num2 (float): Second number
    
    Returns:
        float: Sum of the two numbers
    """
    return num1 + num2

def get_number_input(prompt):
    """
    Get a number from user input with error handling.
    
    Args:
        prompt (str): Prompt message to display to user
    
    Returns:
        float: The number entered by the user
    """
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("Please enter a valid number.")

def main():
    """
    Main function that demonstrates the usage of add_numbers function.
    Prompts user for two numbers, adds them, and displays the result.
    """
    print("Welcome to the Number Addition Calculator!")
    print("-" * 40)
    
    # Get input from user
    first_number = get_number_input("Enter the first number: ")
    second_number = get_number_input("Enter the second number: ")
    
    # Perform addition
    result = add_numbers(first_number, second_number)
    
    # Display result
    print(f"\nResult: {first_number} + {second_number} = {result}")

if __name__ == "__main__":
    main()
