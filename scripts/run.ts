import { ethers } from "hardhat";
const hre = require("hardhat"); 
async function main(): Promise<void> {
    const [owner,randomPerson] = await hre.ethers.getSigners();
    const smartUserContractFactory = await ethers.getContractFactory("SmartUser");
    const smartUserContract = await smartUserContractFactory.deploy();
    await smartUserContract.deployed();
    console.log("Contract Deployed to:", smartUserContract.address);
    console.log("Contract deployed by:", owner.address);
    let user;
    // user = await smartUserContract.setInfo("1","2","3","4","5","6","7","8","9","10","11");
    user = smartUserContract.getInfo();

}

const runMain = async() => {
    try{
        await main();
        process.exit(0);
    }
    catch(error){
        console.log(error);
        process.exit(1);
    }
}

runMain();