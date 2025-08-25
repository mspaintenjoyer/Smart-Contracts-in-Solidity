# Smart-Contracts-in-Solidity
This repository contains a collection of simple to intermediate-level Solidity smart contracts. 
## Contracts

### 1. SimpleToken.sol

This contract is a simplified version of an ERC20 token. It showcases how to manage a total supply and track balances for different addresses using a `mapping`.

**Key Concepts:**
- `mapping`: A way to store key-value pairs, in this case, addresses mapped to their token balances.
- `uint256`: The standard integer type in Solidity for large numbers.
- `_totalSupply`: A state variable to track the total number of tokens.
- `transfer` function: A function that moves tokens from one address to another.

### 2. BasicEscrow.sol

This contract acts as a neutral third party to hold funds until a condition is met. It's a classic example of using the `payable` keyword and managing a simple state machine.

**Key Concepts:**
- `payable`: A special keyword that allows a function to receive Ether.
- `require`: A statement used to enforce conditions, reverting the transaction if the condition is not met.
- `msg.sender`: A global variable representing the address that called the function.
- `releaseFunds`: A function to send the held Ether to the designated beneficiary.

### 3. TimeLockVesting.sol

This contract demonstrates how to handle a vesting schedule, where funds are released over time. It's a great example of using `block.timestamp` and a more complex `require` statement to control access to funds.

**Key Concepts:**
- `block.timestamp`: A global variable that returns the current block's timestamp, which can be used to manage time-based logic.
- `struct`: A custom data type that groups multiple variables together.
- `modifier`: A keyword used to change the behavior of functions in a declarative way (e.g., `onlyOwner`).
- `withdrawFunds`: A function that allows the beneficiary to withdraw a portion of the vested funds.

## How to Use

To deploy and interact with these contracts, you will need a Solidity development environment. I use Remix IDE.
