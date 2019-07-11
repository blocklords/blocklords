const SimpleStorage = require('Embark/contracts/HeroFactory');

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
    "HeroFactory": {
      args: ["Hero", "HERO"]
    }
  }
}, (_err, web3_accounts) => {
  accounts = web3_accounts
});

