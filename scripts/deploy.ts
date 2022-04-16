import { ethers } from "hardhat";
import "../build";

require('dotenv').config();

async function main() {

  // Smart User Contract Deployment
  const SmartUser = await ethers.getContractFactory("SmartUser");
  const user = await SmartUser.deploy();

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

  //SurveyResponse Contract Deployment
  const SurveyResponse = await ethers.getContractFactory("UserSurveyResponses");
  const surveyResponse = await SurveyResponse.deploy();
  await surveyResponse.deployed();

  console.log("SurveyResponse deployed to:", surveyResponse.address);

  //OrgSurvey Contract Deployment
  const OrgSurvey = await ethers.getContractFactory("OrgSurvey");
  const orgSurvey = await OrgSurvey.deploy();
  await orgSurvey.deployed();

  console.log("OrgSurvey deployed to:", orgSurvey.address);
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
