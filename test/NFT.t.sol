// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFT.sol";
import "../src/Token.sol";

contract NFTTest is Test {
    NFT public nft;
    Token public token;
    address public user;

    function setUp() public {
        // Deploy the ERC20 Token contract and mint tokens to the test contract
        token = new Token(100000000);

        // Deploy the NFT contract with a mint fee
        nft = new NFT(2, address(token)); // Assuming the mint fee is 2 tokens

        // Setup a user address
        user = address(0x1);

        // Give the user some tokens
        token.transfer(user, 100);

        // Approve the NFT contract to spend tokens on behalf of the user
        vm.prank(user);
        token.approve(address(nft), 10);
    }

    function testMintNFT() public {
        // Check user's token balance before minting the NFT
        uint256 userTokenBalanceBefore = token.balanceOf(user);
        assertEq(userTokenBalanceBefore, 100);

        // Mint the NFT using ERC20 tokens
        vm.prank(user);
        uint256 tokenId = nft.mintNFTUsingERC20(user, "tokenURI");

        // Check that the NFT was minted and the token balance was deducted
        uint256 userTokenBalanceAfter = token.balanceOf(user);
        assertEq(userTokenBalanceAfter, userTokenBalanceBefore - 2);
        assertEq(nft.balanceOf(user), 1);
        assertEq(nft.ownerOf(tokenId), user);
    }
}
