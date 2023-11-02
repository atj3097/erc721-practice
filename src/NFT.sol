// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface INFT {
    function mintNFTUsingERC20(address payer, string memory tokenURI) external returns(uint256);
}


contract NFT is ERC721URIStorage, INFT  {
    uint256[] _tokenIds;
    uint8 _mintFee;
    address tokenContract;

    constructor(uint8 mintFee, address token) ERC721("SpecialNFT", "SNFT") {
        _tokenIds.push(0);
        _mintFee = mintFee;
        tokenContract = token;
    }

    function mintNFTUsingERC20(address payer, string memory tokenURI) public returns(uint256) {
        require(IERC20(tokenContract).balanceOf(payer) >= _mintFee, "Insuffiecnt Token Balance");
        require(IERC20(tokenContract).allowance(payer, address (this)) >= _mintFee, "Insufficient Token Allowance");
        IERC20(tokenContract).transferFrom(payer, address(this), _mintFee);
        uint256 newTokenId = _tokenIds[_tokenIds.length - 1] + 1;
        _tokenIds.push(newTokenId);
        _mint(payer, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        return newTokenId;
    }

}
