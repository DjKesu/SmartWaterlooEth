const SmartUser = artifacts.require("SmartUser.sol");
const SmartOrganisation = artifacts.require("SmartOrganisation.sol");
const UserSurveyResponses = artifacts.require("UserSurveyResponses.sol");
const OrgSurvey = artifacts.require("OrgSurvey.sol");
const OrganisationEvents = artifacts.require("OrganisationEvents.sol");

module.exports = function (deployer) {
  deployer.deploy(SmartUser);
  deployer.deploy(SmartOrganisation);
  deployer.deploy(UserSurveyResponses);
  deployer.deploy(OrgSurvey);
  deployer.deploy(OrganisationEvents);
};
