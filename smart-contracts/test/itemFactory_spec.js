const HeroToken = require('Embark/contracts/HeroToken');
const ItemFactory = require('Embark/contracts/ItemFactory');
const HeroFactory = require('Embark/contracts/HeroFactory');

let accounts;

config({
  contracts: {
    "HeroToken": {
      args: ["Hero", "HERO"]
    },
    "ItemFactory": {
      args: ["$HeroToken"]
    },
    "HeroFactory": {
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

  // it("should create an item", async function () {

  // });

})
;