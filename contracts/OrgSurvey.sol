//SPDX-License-Identifier: Unlicensed
/// @custom:security-contact krish.mehta@uwaterloo.ca

pragma solidity ^0.8.0;

//import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract OrgSurvey is Ownable, Pausable {
    /**
     * @dev Set who may pause the contract
     */
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    constructor() {}

    /**
     * @dev pauses the contract
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev unpauses the contract
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    struct Surveys {
        address org;
        string[] questions;
        string sId;
    }

    Surveys[] public survey;

    function createSurvey(
        address _org,
        string[] memory _questions,
        string memory _sId
    ) public payable {
        Surveys memory surveyInfo = Surveys(_org, _questions, _sId);
        survey.push(surveyInfo);
    }

    function getSurveyIDs(address _org) public view returns (string[] memory) {
        string[] memory surveyIDs = new string[](survey.length);
        uint256 k = 0;
        for (uint256 i = 0; i < survey.length; i++) {
            if (survey[i].org == _org) {
                surveyIDs[k++] = (survey[i].sId);
            }
        }
        return surveyIDs;
    }

    function getSurveyInfoByID(string memory _sId)
        public
        view
        returns (string[] memory)
    {
        for (uint256 i = 0; i < survey.length; i++) {
            if (keccak256(bytes(survey[i].sId)) == keccak256(bytes(_sId))) {
                return survey[i].questions;
            }
        }
        revert("No Survey found");
    }
}
