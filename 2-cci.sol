// CCI contract
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IStorage {
    function getNum() external view returns (uint);
    function add() external;
}

contract CCI {
    constructor() {

    }

    function proxyAdd() public {
        IStorage(0x9C22ce44f598cf5616c28a25b3514a1f293B3919).add();
    }

    function proxyGet() public view returns (uint) {
        return IStorage(0x9C22ce44f598cf5616c28a25b3514a1f293B3919).getNum();
    }
}