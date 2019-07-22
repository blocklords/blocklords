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

  before(async() => {

    await HeroToken.methods.addMinter(HeroFactory.address).send();

  } );

  it("should create a hero", async function () {

    let hero = await HeroFactory.methods.createHero(HeroFactory.address, 1, 2, 3, 4, 5, 6, 7, 0).send();
    let id = hero.events.HeroCreated.returnValues.id;

    assert.strictEqual('1', id);
  });


  it("should not allow to create a hero", async function () {

    try {
      let hero = await HeroFactory.methods.createHero(HeroFactory.address, 1, 2, 3, 4, 5, 6, 7, 0).send({from: accounts[2]});
      assert.fail('should have reverted before');
    }
    catch (error) {
      assert.strictEqual(error.message, "VM Exception while processing transaction: revert Ownable: caller is not the owner");
    }

  });

  it("should get hero info", async function () {

    let heroInfo = await HeroFactory.methods.getHeroInfo('1').call();
    assert.strictEqual('1', heroInfo[0]);   

  });

  it("should make hero older", async function () {

    await HeroFactory.methods.makeOlder('1').send();
    let hero = await HeroFactory.methods.getHeroInfo('1').call();

    assert.strictEqual('1', hero[3]);   
  });

})
;