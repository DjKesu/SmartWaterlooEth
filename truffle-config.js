require('dotenv').config();
const HDWalletProvider = require("@truffle/hdwallet-provider");
const { API_URL, MNEMONIC } = process.env;

module.exports = {
  compilers: {
    solc: {
      version: '0.8.3',
      parser: 'solcjs'
    }
  },
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    rinkeby: {
      provider: function() {
        return new HDWalletProvider(MNEMONIC, API_URL)
      },
      network_id: 4,
      gas: 4000000 //4M is the max
    }
  }
};