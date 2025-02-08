// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arithmetic {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function subtract(uint a, uint b) public pure returns (uint) {
        require(a >= b, "Subtraction would result in a negative number");
        return a - b;
    }

    function multiply(uint a, uint b) public pure returns (uint) {
        //complete this
        return a * b;
    }

    function divide(uint a, uint b) public pure returns (uint) {
        require(b != 0, "Division by zero is not allowed");
        return a / b;
    }
}

/*
// Problem Statements
# Arithmetic Operations Smart Contract

Implement a Solidity smart contract named `Arithmetic` that performs basic arithmetic operations. The contract should include the following functions:

1. `add(uint256 a, uint256 b)`: Returns the sum of two unsigned integers.
2. `subtract(uint256 a, uint256 b)`: Returns the difference between two unsigned integers.
3. `multiply(uint256 a, uint256 b)`: Returns the product of two unsigned integers.
4. `divide(uint256 a, uint256 b)`: Returns the quotient of two unsigned integers.

## Requirements:

- All functions should accept and return `uint256` values.
- Implement proper error handling:
  - The `subtract` function should revert if the result would be negative.
  - The `divide` function should revert if the divisor is zero.
- Ensure that all operations are safe and do not result in overflow or underflow.

## Example:

```solidity
Arithmetic arithmetic = new Arithmetic();
arithmetic.add(5, 3) // returns 8
arithmetic.subtract(10, 7) // returns 3
arithmetic.multiply(4, 6) // returns 24
arithmetic.divide(20, 5) // returns 4
```

## Note:

This problem tests your understanding of Solidity syntax, basic arithmetic operations, and error handling in smart contracts. Pay attention to potential edge cases and ensure your implementation is secure and efficient.
*/