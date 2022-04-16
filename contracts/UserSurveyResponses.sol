//SPDX-License-Identifier: Unlicensed
/// @custom:security-contact krish.mehta@uwaterloo.ca

pragma solidity ^0.8.0;

//import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract UserSurveyResponses is Ownable, Pausable {
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

    struct SurveyResponse {
        address user;
        string[] response;
        string sId;
    }

    SurveyResponse[] public responses;

    function addSurveyResponse(
        address _user,
        string[] memory _response,
        string memory _sId
    ) public payable {
        SurveyResponse memory surveyForm = SurveyResponse(
            _user,
            _response,
            _sId
        );
        responses.push(surveyForm);
    }

    function getSurveyResponsesByUser(address _user)
        public
        view
        returns (string[][] memory)
    {
        string[][] memory allResponses = new string[][](responses.length);
        uint256 k = 0;
        for (uint256 i = 0; i < responses.length; i++) {
            if (responses[i].user == _user) {
                allResponses[k++] = responses[i].response;
            }
        }
        return allResponses;
    }

    function getSurveyResponsesBySurvey(string memory _sId)
        public
        view
        returns (string[][] memory)
    {
        string[][] memory allResponses = new string[][](responses.length);
        uint256 k = 0;
        for (uint256 i = 0; i < responses.length; i++) {
            if (keccak256(bytes(responses[i].sId)) == keccak256(bytes(_sId))) {
                allResponses[k++] = responses[i].response;
            }
        }
        return allResponses;
    }
}
