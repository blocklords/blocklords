pragma solidity ^0.5.0;

import "./HeroToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
* @title ItemFactory
* @author Arseny Kin
* @notice Contract for Item creation
*/

contract ItemFactory is Ownable {

	struct Item{

        uint OWNER;   // ID of a hero that ownes an item
        uint STAT_TYPE; // Item can increase only one stat of Hero, there are five: Leadership, Defense, Speed, Strength and Intelligence
        uint QUALITY; // Item can be in different Quality. Used in Gameplay.

        uint GENERATION; // Items are given to Players only as a reward for holding Strongholds on map, or when players create a hero.
                         // Items are given from a list of items batches. Item batches are putted on Blockchain at once by Game Owner.
                         // Each of Item batches is called as a generation.

        uint STAT_VALUE;
        uint LEVEL;
        uint XP;         // Each battle where, Item was used by Hero, increases Experience (XP). Experiences increases Level. Level increases Stat value of Item
    }

    mapping (uint => Item) public items;

    function addItem(uint id,
    				 uint statType,
      				 uint quality,
      				 uint generation,
      				 uint statValue) public onlyOwner {

        items[id] = Item({
                        OWNER: id,
                        STAT_TYPE: statType,
                        QUALITY: quality,     
                        GENERATION: generation,
                        STAT_VALUE: statValue,
                        LEVEL: 0,
                        XP: 0
                    });
    }

}