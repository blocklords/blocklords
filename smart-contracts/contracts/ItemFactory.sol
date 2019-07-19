pragma solidity ^0.5.0;

import "./HeroToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
* @title ItemFactory
* @author Arseny Kin
* @notice Contract for Item creation
*/

contract ItemFactory is Ownable {

	HeroToken public heroToken;

    constructor(address _heroToken) public { 
        heroToken = HeroToken(_heroToken);        
    }

	struct Item{

        uint OWNER;      
        uint STAT_TYPE;  
        uint QUALITY;    
        uint GENERATION; 
        uint STAT_VALUE;
        uint LEVEL;
        uint XP;         // Each battle where, Item was used by Hero, increases Experience (XP). Experiences increases Level. Level increases Stat value of Item
    }

    uint[] itemIds = [0]; // a list of item ids, item ids start from 1
    mapping (uint => Item) public items;

    /**
    * @dev Creates an item
    * @param heroId id of a hero owner- ERC721 id
    * @param statType Item can increase only one stat of Hero, there are five: Leadership, Defense, Speed, Strength and Intelligence
	* @param quality Item can be in different Quality. Used in Gameplay.
	* @param generation generation of an item
	* @param statValue value of a stat improvement for the item
    */

    function addItem(uint heroId,
    				 uint statType,
      				 uint quality,
      				 uint generation,
      				 uint statValue) public onlyOwner {
        require(heroToken.exists(heroId),
                "Hero does not exist");

        uint id = itemIds.length;
		itemIds.push(id);        

        items[id] = Item({
                        OWNER: heroId,
                        STAT_TYPE: statType,
                        QUALITY: quality,     
                        GENERATION: generation,
                        STAT_VALUE: statValue,
                        LEVEL: 0,
                        XP: 0
                    });
    }

    function totalItems() public view returns(uint){
    	return itemIds.length-1; // kill 0 element
    }
}