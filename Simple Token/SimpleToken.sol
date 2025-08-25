// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleToken
 * @dev A very basic, non-standard token contract.
 * It demonstrates how to manage a supply and balances using a mapping.
 */
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

    /**
     * @dev The constructor mints the initial supply of tokens and assigns them to the contract creator.
     * @param initialSupply The total number of tokens to create.
     */
    constructor(uint256 initialSupply) {
        _totalSupply = initialSupply;
        _balances[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    /**
     * @dev Returns the total supply of tokens.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Returns the token balance of a specific address.
     * @param account The address to query.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev Transfers a specified amount of tokens to a recipient.
     * @param to The address of the recipient.
     * @param amount The amount of tokens to transfer.
     */
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
