// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract BasicEscrow {
    // The address of the person who created the contract.
    address public immutable depositor;
    
    // The address that will receive the funds once the condition is met.
    address public immutable beneficiary;

    // A boolean to track if the funds have been released.
    bool public fundsReleased;

    constructor(address _beneficiary) {
        depositor = msg.sender;
        beneficiary = _beneficiary;
        fundsReleased = false;
    }


    function deposit() public payable {
        // Enforce that only the original depositor can deposit funds and that no funds have been released yet.
        require(msg.sender == depositor, "Only the depositor can deposit funds");
        require(!fundsReleased, "Funds have already been released");
    }

    function releaseFunds() public {
        // Check that the caller is the depositor.
        require(msg.sender == depositor, "Only the depositor can release funds");

        // Check that the funds have not already been released.
        require(!fundsReleased, "Funds have already been released");

        // Get the contract's balance to send to the beneficiary.
        uint256 balance = address(this).balance;

        // Check if there are any funds to release.
        require(balance > 0, "No funds to release");

        // Mark the funds as released.
        fundsReleased = true;

        // Send the entire balance to the beneficiary.
        // `call` is the recommended way to send Ether and handles potential failures gracefully.
        (bool success, ) = beneficiary.call{value: balance}("");
        require(success, "Failed to send Ether");
    }
}
