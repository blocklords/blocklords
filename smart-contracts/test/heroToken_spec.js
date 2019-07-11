const HeroToken = require('Embark/contracts/HeroToken');

let accounts;

// For documentation please see https://embark.status.im/docs/contracts_testing.html
config({
  //deployment: {
  //  accounts: [
  //    // you can configure custom accounts with a custom balance
  //    // see https://embark.status.im/docs/contracts_testing.html#Configuring-accounts
  //  ]
  //},
  contracts: {
    "HeroToken": {
      args: ["Hero", "HERO"]
    }
  }
}, (_err, web3_accounts) => {
  accounts = web3_accounts
});

contract("HeroToken", function () {

  it("should set up blocklords address", async function () {
    await HeroToken.methods.setBlocklordsAddress(accounts[0]).call();
  });
  
  it("should mint a token", async function () {
    await HeroToken.methods.mintTo(accounts[0]).call();
  });

})
;