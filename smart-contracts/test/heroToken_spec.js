const HeroToken = require('Embark/contracts/HeroToken');

let accounts;

config({
  contracts: {
    "HeroToken": {
      args: ["Hero", "HERO"]
    }
  }
}, (_err, web3_accounts) => {
  accounts = web3_accounts
});

contract("HeroToken", function () {

  it("should mint a token", async function () {

    await HeroToken.methods.mintTo(accounts[0]).send();
    let supply = await HeroToken.methods.totalSupply().call();
    
    assert.strictEqual('1', supply);
  });

})
;