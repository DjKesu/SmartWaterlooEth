import { expect } from "chai";
import { ethers } from "hardhat";

describe("SmartUser", function () {
  it("Should return the new user once it's details are added", async function () {
    const smartUserContractFactory = await ethers.getContractFactory("SmartUser");
    const smartUserContract = await smartUserContractFactory.deploy();
    await smartUserContract.deployed();
  });
});
