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

contract("ItemFactory", function () {

  before(async() => {

    await HeroToken.methods.addMinter(HeroFactory.address).send();
    await HeroFactory.methods.createHero(HeroFactory.address, 1, 2, 3, 4, 5, 6, 7, 0).send();


  } );

  it("should create an item", async function () {

    await ItemFactory.methods.createItem(1, 3, 3, 2, 1).send();

    let totalItems = await ItemFactory.methods.totalItems().call();

    assert.strictEqual('1', totalItems);
  });

})
;