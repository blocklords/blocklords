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
    // create hero 1
    await HeroFactory.methods.createHero(HeroFactory.address, 1, 2, 3, 4, 5, 6, 7, 0).send();
    // create hero 2
    await HeroFactory.methods.createHero(HeroFactory.address, 1, 2, 3, 4, 5, 6, 7, 0).send();
  } );

  it("should not allow to create an item for a hero with 0 id", async function () {

    try {
      await ItemFactory.methods.createItem(0, 3, 3, 2, 1).send();
    }
    catch (error) {
      assert.strictEqual(error.message, "VM Exception while processing transaction: revert Hero id should be greater than 0");
    }

  });


  it("should create an item", async function () {

    await ItemFactory.methods.createItem(1, 1, 1, 1, 1).send();
    let totalItems = await ItemFactory.methods.totalItems().call();
    assert.strictEqual('1', totalItems);

  });

  it("should check if item exists", async function () {

    let exists = await ItemFactory.methods.itemExists('1').call();
    assert.strictEqual(true, exists);
  
  });

  it("should upgrade item stat value", async function () {

    await ItemFactory.methods.upgradeItemStatValue('1', '8').send();
    let stats = await ItemFactory.methods.getItemInfo('1').call();

    assert.strictEqual('8', stats[3]);

  });


  it("should not allow to upgrade item stat value", async function () {

    await ItemFactory.methods.createItem(1, 1, 1, 1, 0).send();

    try {
        await ItemFactory.methods.upgradeItemStatValue('2', '8').send();
    }
    catch (error) {
      assert.strictEqual(error.message, "VM Exception while processing transaction: revert This item is not upgradable");
    }

  });

  it("should upgrade item level", async function () {

    await ItemFactory.methods.incrementItemLvl('1').send();
    stats = await ItemFactory.methods.getItemInfo('1').call();

    assert.strictEqual('1', stats[4]);
  });

  it("should not allow to level up higher than level 3", async function () {

    await ItemFactory.methods.incrementItemLvl('1').send();
    await ItemFactory.methods.incrementItemLvl('1').send();

    try {
        await ItemFactory.methods.incrementItemLvl('1').send();
    }
    catch (error) {
      assert.strictEqual(error.message, "VM Exception while processing transaction: revert This item is not upgradable");
    }

  });

  it("should upgrade item XP", async function () {

    await ItemFactory.methods.createItem(1, 1, 1, 1, 1).send();
    
    await ItemFactory.methods.updateItemXp('3', 20).send();
    stats = await ItemFactory.methods.getItemInfo('3').call();

    assert.strictEqual('20', stats[5]);
  });

  it("should burn the item", async function () {

    await ItemFactory.methods.burnItem('3').send();

    exists = await ItemFactory.methods.itemExists('3').call();
    assert.strictEqual(false, exists);
  });

  it("should not allow to burn the item", async function () {

    try {
      await ItemFactory.methods.burnItem('3').send();  
    }
    catch (error) {
      assert.strictEqual(error.message, "VM Exception while processing transaction: revert Item does not exist");
    }

  });

  it("should transfer item to another hero", async function () {

    await ItemFactory.methods.changeItemOwner('1', '2').send();

    let owner = await ItemFactory.methods.getItemOwner('1').call();
    assert.strictEqual('2', owner);
  });

  it("should not allow to transfer item to the same hero", async function () {

    try {
      await ItemFactory.methods.changeItemOwner('1', '2').send();
    }
    catch (error) {
      assert.strictEqual(error.message, "VM Exception while processing transaction: revert Hero already ownes this item");
    }
    
  });


})
;