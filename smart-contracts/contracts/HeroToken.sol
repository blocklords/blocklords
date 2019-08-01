pragma solidity ^0.5.0;

// import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
// import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "opensea/TradeableERC721Token.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Mintable.sol";

/**
* @title HeroToken
* @author Arseny Kin
* @notice Contract for ERC721 Hero token
*/

contract HeroToken is ERC721Mintable, ERC721Mintable {
  
	constructor(address _proxyRegistryAddress) TradeableERC721Token("Hero", "HERO", _proxyRegistryAddress) public { }

    /**
    * @dev calculates the next token ID based on totalSupply
    * @return uint256 for the next token ID
    */
    function _getNextTokenId() private view onlyMinter returns (uint256) {
        return totalSupply().add(1); 
    }

    /**
    * @dev Mints a token to an address 
    * @param _to address of the future owner of the token
    * @return uint256 for the token ID
    */
 
	function mintTo(address _to) public returns(uint256){
		uint256 newTokenId = _getNextTokenId();
		mint(_to, newTokenId);
		return newTokenId;
	}


    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function exists(uint tokenId) public view returns(bool){
        return _exists(tokenId);
    }

    /**
     * @dev Returns token URI
     * @return string token uri
     */
  //   function baseTokenURI() public view returns (string memory) {
  //       return "https://herotoken-uri.herokuapp.com/api/hero/";
  // }


}

