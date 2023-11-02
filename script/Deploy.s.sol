// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Token.sol";
import "../src/NFT.sol";
contract DeployScript is Script {
    function run() external {
        // Define the mint fee and total supply
        uint8 mintFee = 2;
        uint256 totalSupply = 100000000;

        // Start broadcasting transactions to the network
        vm.startBroadcast();

        // Deploy the ERC20 token contract with the total supply
        Token token = new Token(totalSupply);
        console.log("Token deployed at:", address(token));

        // Deploy the NFT contract with the mint fee and address of the token contract
        NFT nft = new NFT(mintFee, address(token));
        console.log("NFT deployed at:", address(nft));

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
