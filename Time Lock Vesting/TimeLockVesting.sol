// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract TimeLockVesting {
    // Custom data type to hold vesting information.
    struct Vesting {
        uint256 amount;
        uint256 releaseTime;
        bool claimed;
    }

    // A mapping from a beneficiary address to their Vesting data.
    mapping(address => Vesting) public vestingSchedules;

    // The address of the owner of this contract.
    address public immutable owner;

    // A modifier to restrict a function to be callable only by the contract owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _; // This special syntax tells Solidity where to insert the code of the function.
    }


    constructor() {
        owner = msg.sender;
    }


    function setupVesting(address beneficiary, uint256 amount, uint256 lockupPeriod) public payable onlyOwner {
        // Check if a vesting schedule for this beneficiary already exists.
        require(vestingSchedules[beneficiary].amount == 0, "Vesting schedule already exists");
        
        // Ensure the sent amount matches the specified amount.
        require(msg.value == amount, "Sent amount does not match vesting amount");

        // Store the vesting data in the mapping.
        vestingSchedules[beneficiary] = Vesting({
            amount: amount,
            releaseTime: block.timestamp + lockupPeriod, // Calculate the time when funds become available.
            claimed: false
        });
    }

    function withdrawFunds() public {
        Vesting storage vesting = vestingSchedules[msg.sender];

        // Check if a vesting schedule exists for this address.
        require(vesting.amount > 0, "No vesting schedule found");
        
        // Check if the lock-up period has passed.
        require(block.timestamp >= vesting.releaseTime, "Funds are not yet available");

        // Check if the funds have not already been claimed.
        require(!vesting.claimed, "Funds have already been claimed");

        // Mark the funds as claimed.
        vesting.claimed = true;

        // Send the vested amount to the beneficiary.
        (bool success, ) = msg.sender.call{value: vesting.amount}("");
        require(success, "Failed to send Ether");
    }
}
