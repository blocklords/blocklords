pragma solidity ^0.5.0;

import "./HeroToken.sol";

contract HeroFactory {

	HeroToken public heroToken;

    struct Hero{
        uint LEADERSHIP;   // Leadership Stat value
        uint INTELLIGENCE; // Intelligence Stat value
        uint STRENGTH;     // Strength Stat value
        uint SPEED;        // Speed Stat value
        uint DEFENSE;      // Defense Stat value
        uint CREATED_TIME;
    }

    mapping (uint => Hero) heroes;

    function addHero(uint[] memory _heroStats/*, uint[] _heroItems*/) public payable returns(bool) {
        
        uint _id = heroToken.mintTo(msg.sender); // NOTE: temporary solution!!
        heroes[_id] = Hero( _heroStats[0], _heroStats[1],  _heroStats[2], _heroStats[3], _heroStats[4], block.number);

        return true;
    }

    function getHero(uint id) public view returns(uint, uint, uint, uint, uint, uint){
        return (heroes[id].LEADERSHIP, heroes[id].INTELLIGENCE, heroes[id].STRENGTH, heroes[id].SPEED, heroes[id].DEFENSE, heroes[id].CREATED_TIME);
    }

}
