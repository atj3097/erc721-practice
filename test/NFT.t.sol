// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/NFT.sol";
import "../src/Token.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";


contract NFTTest is Test {
    NFT public nft;
    Token public token;

    function setUp() public {
        token = new Token(100000000);
        IERC20(token).transfer(msg.sender, 1000);
        nft = new NFT(2, address(token));
        IERC20(token).approve(address(nft), 10);
    }

    function testNFTMint() public {
        INFT(nft).mintNFTUsingERC20(msg.sender, "idk");
        assert(IERC721(nft).balanceOf(msg.sender) > 1);
    }
}