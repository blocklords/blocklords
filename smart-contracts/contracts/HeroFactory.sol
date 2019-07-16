pragma solidity ^0.5.0;

import "./HeroToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
* @title HeroFactory
* @author Arseny Kin
* @notice Contract for Hero creation
*/

contract HeroFactory is Ownable {

	HeroToken public heroToken;

    constructor(address _heroToken) public { 
        heroToken = HeroToken(_heroToken);        
    }

    event HeroCreated(uint indexed id, address receiver);

    enum HeroAge {KID, YOUNG, MID, OLD}

    struct Hero{
        uint    GENERATION;   // Hero generation
        uint    FACE;         // Hero looks
        uint    LEADERSHIP;   // Leadership Stat value
        uint    INTELLIGENCE; // Intelligence Stat value
        uint    STRENGTH;     // Strength Stat value
        uint    SPEED;        // Speed Stat value
        uint    DEFENSE;      // Defense Stat value
        uint    CREATED_TIME;
        HeroAge AGE;          // kid, young, mid, old
        bool    ALIVE;        // indicates if the hero alive
    }

    mapping (uint => Hero) heroes;

    /**
    * @dev Adds a hero and mints a token
    * @param receiver address which token is being minted to
    * @return bool true if the hero was added succesfully
    */

    function addHero(address receiver) public payable onlyOwner returns(bool) {
                
        uint id = heroToken.mintTo(receiver);					
        heroes[id] = Hero({
                            GENERATION: 0,
                            FACE: 0,
                            LEADERSHIP: 0,     
                            INTELLIGENCE: 0,
                            STRENGTH: 0,
                            SPEED: 0,
                            DEFENSE: 0,
                            CREATED_TIME: block.number,
                            AGE: HeroAge.YOUNG,
                            ALIVE: true
                        });

        emit HeroCreated(id, receiver);

        return true;
    }

    /**
    * @dev Returns hero's basic information by id 
    * @param id token/hero id
    * @return Hero a hero with the given id
    */

    function getHero(uint id) public view returns(uint,uint,uint,HeroAge, bool){
        return (heroes[id].GENERATION, 
                heroes[id].FACE, 
                heroes[id].CREATED_TIME,
                heroes[id].AGE,
                heroes[id].ALIVE
                );
    }


    /**
    * @dev Returns hero's stats by id 
    * @param id token/hero id
    * @return Hero a hero with the given id
    */

    function getHeroStats(uint id) public view returns(uint,uint,uint,uint,uint){
        return (heroes[id].LEADERSHIP, 
                heroes[id].INTELLIGENCE, 
                heroes[id].STRENGTH,
                heroes[id].SPEED,
                heroes[id].DEFENSE
                );
    }
 
    /**
    * @dev Updates one of the hero's stats 
    * @param id token/hero id
    * @param statNum number of the stat which you want to update
    * @param newStat value of the updated stat
    */

    function updateStat(uint id, uint statNum, uint newStat) public onlyOwner {
        require(heroToken.exists(id),
                "Hero does not exist");
        require(newStat < 5,
                "Stats out of index");    
        
        if (statNum == 0) heroes[id].LEADERSHIP = newStat; 
        else if (statNum == 1) heroes[id].INTELLIGENCE = newStat;
        else if (statNum == 2) heroes[id].STRENGTH = newStat;
        else if (statNum == 3) heroes[id].SPEED = newStat;
        else if (statNum == 4) heroes[id].DEFENSE = newStat;
    }

}