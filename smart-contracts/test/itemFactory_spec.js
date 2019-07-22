const HeroToken = require('Embark/contracts/HeroToken');
const ItemFactory = require('Embark/contracts/ItemFactory');

let accounts;

config({
  contracts: {
    "HeroToken": {
      args: ["Hero", "HERO"]
    },
    "ItemFactory": {
      args: ["$HeroToken"]
    }
  }
}, (_err, web3_accounts) => {
  accounts = web3_accounts
});

contract("HeroFactory", function () {

  it('should pass', () => {
    assert.ok(true);
  });


  // it("should create a hero", async function () {
  //   await HeroToken.methods.addMinter(HeroFactory.address).send();
  //   await HeroFactory.methods.addHero().send();
  // });

})
;