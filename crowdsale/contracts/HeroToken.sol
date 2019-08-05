pragma solidity ^0.5.0;

// import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "opensea/TradeableERC721Token.sol";

/**
* @title HeroToken
* @author Arseny Kin
* @notice Contract for ERC721 Hero token
*/

contract HeroToken is TradeableERC721Token {
  
	constructor(string memory _name, string memory _symbol) TradeableERC721Token(_name, _symbol) public { }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function exists(uint tokenId) public view returns(bool){
        return _exists(tokenId);
    }


}
