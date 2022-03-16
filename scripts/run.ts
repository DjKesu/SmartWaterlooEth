import { ethers } from "hardhat";
const hre = require("hardhat");
require("dotenv").config();
require("@nomiclabs/hardhat-ethers");

async function main(): Promise<void> {

  const { API_URL, PRIVATE_KEY } = process.env;
  console.log(API_URL);
  console.log(PRIVATE_KEY);
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
