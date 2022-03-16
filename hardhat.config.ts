
import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";

// require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const API_URL = "https://eth-rinkeby.alchemyapi.io/v2/Vfwm0qRpvLqtRGSWTRpGeeO4nUCl5D8B";
const PRIVATE_KEY = '0x92bc53d5538b36c4bd84ea69b9058a5c800827013b4c23a4280e8f960c690217';

const config: HardhatUserConfig = {
  solidity: "0.8.4",
  defaultNetwork: "rinkeby",
  networks: {
    rinkeby: {
      url: `${API_URL}`,
      accounts: [`${PRIVATE_KEY}`],
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 40000
  }
};

export default config;
