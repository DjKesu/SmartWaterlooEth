import { ethers } from "hardhat";


require('dotenv').config();

async function main() {

  // const { API_URL, PRIVATE_KEY } = process.env;
  // const d = [`0x${PRIVATE_KEY}`];
  // console.log(d)

  // Smart User Contract Deployment
  const SmartUser = await ethers.getContractFactory("SmartUser");
  const user = await SmartUser.deploy(
    {
      value: hre.ethers.utils.parseEther("0.5"),
    }
  );

  await user.deployed();

  console.log("SmartUser deployed to:", user.address);

  // Smart Organisation Contract Deployment
  const SmartOrganisation = await ethers.getContractFactory(
    "SmartOrganisation"
  );
  const Organisation = await SmartOrganisation.deploy();

  await Organisation.deployed();

  console.log("SmartOrganisation deployed to:", Organisation.address);

  // OrganisationEvents Contract Deployment
  const SmartEvents = await ethers.getContractFactory("OrganisationEvents");
  const events = await SmartEvents.deploy();

  await events.deployed();

  console.log("SmartEvents deployed to:", events.address);
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

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });
