// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(uint256 totalSupply) ERC20("T", "Token") {
        _mint(msg.sender, totalSupply);
    }
}