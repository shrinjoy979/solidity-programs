// SPDX-License-Identifier: MIT
/*
    Every user will deploy their own Will Contract.
    When initialized, set the owner to be the person initializing
    The owner can define a recipient in the constructor
    Owner should be allowed to change the recipient
    Owner should be allowed to interact with the contract via a ping function
    If ping hasn’t been called for > 1 year, the recipient should be allowed to call a drain function
*/
pragma solidity ^0.8.26;

contract Will {
    address public owner;
    address public recipient;
    uint private lastPingedTimestamp;
    uint private depositeAmount;

    constructor(address _recipient) payable {
        owner = msg.sender;
        depositeAmount = msg.value;
        recipient = _recipient;
        lastPingedTimestamp = block.timestamp;
    }

    function changeReceipient(address _newReceipient) public {
        recipient = _newReceipient;
    }

    function ping() public{
        require(owner != msg.sender, "Only owner can access");
        lastPingedTimestamp = block.timestamp;
    }

    function drain(address _recipient) public {
        require(lastPingedTimestamp >= lastPingedTimestamp + 365 days, "Last pinged was less than 365 days");
        require(recipient != _recipient, "Please enter a valid recipient");

        address payable to = payable(recipient);
        to.transfer(depositeAmount);
    }

    function withdrawFundsByOwner() public payable {
        require(owner != msg.sender, "Only owner can access");
        address payable ownerAddress = payable(msg.sender);
        ownerAddress.transfer(depositeAmount);
    }
}