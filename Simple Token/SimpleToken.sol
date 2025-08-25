// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SimpleToken {
    // State variables
    string public name = "MySimpleToken";
    string public symbol = "MST";
    uint256 public decimals = 18;
    uint256 private _totalSupply;

    // A mapping from an address to its token balance.
    // This is like a key-value store where keys are addresses and values are balances.
    mapping(address => uint256) private _balances;

    // A simple event to log token transfers.
    event Transfer(address indexed from, address indexed to, uint256 amount);


    constructor(uint256 initialSupply) {
        _totalSupply = initialSupply;
        _balances[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }


    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }


    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }


    function transfer(address to, uint256 amount) public returns (bool) {
        // Enforce a condition that the sender has enough balance.
        require(_balances[msg.sender] >= amount, "ERC20: transfer amount exceeds balance");

        // Subtract the amount from the sender's balance.
        _balances[msg.sender] -= amount;

        // Add the amount to the recipient's balance.
        _balances[to] += amount;

        // Emit an event to notify about the transfer.
        emit Transfer(msg.sender, to, amount);

        return true;
    }
}
