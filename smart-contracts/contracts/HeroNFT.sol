pragma solidity ^0.5.0;

// import "./common/Ownable.sol";
// import "./MetadataStore.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Mintable.sol";



/**
* @title HeroToken
* @author Arseny Kin
* @notice Contract for ERC721 Hero token
*/

contract HeroToken is ERC721Full, ERC721Mintable/*, Ownable, MetadataStore*/ {

    address public blocklords;

    function setBlocklordsAddress(address _blocklords) public /* onlyOwner */ {
        blocklords = _blocklords;
    }
  
	constructor(string _name, string _symbol) ERC721Full(_name, _symbol) public { }

    /**
    * @dev calculates the next token ID based on totalSupply
    * @return uint256 for the next token ID
    */
    function _getNextTokenId() private view returns (uint256) {
        return totalSupply().add(1); 
    }

    /**
    * @dev Mints a token to an address 
    * @param _to address of the future owner of the token
    * @return uint256 for the token ID
    */
 
	function mintTo(address _to) public returns(uint256){
        require(msg.sender == blocklords, // TODO: add signature check
            "Only blocklords contract can initiate this transaction");

		uint256 newTokenId = _getNextTokenId();
		_mint(_to, newTokenId);
		return newTokenId;
	}

}
