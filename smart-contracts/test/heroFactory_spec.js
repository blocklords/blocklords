const HeroToken = require('Embark/contracts/HeroToken');
const HeroFactory = require('Embark/contracts/HeroFactory');

let accounts;

config({
  contracts: {
    "HeroToken": {
      args: ["Hero", "HERO"]
    },
    "HeroFactory": {
      args: ["$HeroToken"]
    }
  }
}, (_err, web3_accounts) => {
  accounts = web3_accounts
});

contract("HeroFactory", function () {

  it("should create a hero", async function () {
  	await HeroToken.methods.addMinter(HeroFactory.address).send();
    await HeroFactory.methods.addHero().send();
  });

})
;