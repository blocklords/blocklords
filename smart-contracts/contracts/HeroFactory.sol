pragma solidity ^0.5.0;

import "./HeroToken.sol";

contract HeroFactory {

	HeroToken public heroToken;



    struct Hero{
        uint GENERATION;   // Hero generation
        uint LEADERSHIP;   // Leadership Stat value
        uint INTELLIGENCE; // Intelligence Stat value
        uint STRENGTH;     // Strength Stat value
        uint SPEED;        // Speed Stat value
        uint DEFENSE;      // Defense Stat value
        uint CREATED_TIME;
    }

    mapping (uint => Hero) heroes;

    /**
    * @dev Adds a hero and mints a token 
    * @param heroStats hero attributes
    * @return uint256 for the token ID
    */

    function addHero(uint[] memory heroStats/*, uint[] _heroItems*/) public payable returns(bool) {
        
        uint id = heroToken.mintTo(msg.sender); // NOTE: temporary solution!!
        										// will add key check in the future
        heroes[id] = Hero(  heroStats[0], 
        					heroStats[1],  
        					heroStats[2], 
        					heroStats[3], 
        					heroStats[4],
                            heroStats[5], 
        					block.number);
        return true;
    }

    /**
    * @dev Returns a hero by id 
    * @param id token/hero id
    * @return Hero a hero with the given id
    */

    function getHero(uint id) public view returns(uint,uint,uint,uint,uint,uint,uint){
        return (heroes[id].GENERATION, 
                heroes[id].LEADERSHIP, 
                heroes[id].INTELLIGENCE,
                heroes[id].STRENGTH,
                heroes[id].SPEED,
                heroes[id].DEFENSE,
                heroes[id].CREATED_TIME
                );
    }

}
