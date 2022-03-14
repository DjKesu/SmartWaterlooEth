//SPDX-License-Identifier: Unlicensed
/// @custom:security-contact krish.mehta@uwaterloo.ca
pragma solidity ^0.8.0;

//import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract OrganisationEvents is Ownable, Pausable {
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

    struct EventInfo {
        address organiser;
        string eventName;
        string ageGroup;
        string startDate;
        string endDate;
        string activityType;
        string description;
        address[] attendees;
    }

    EventInfo[] public events;

    event EventCreated(
        address organiser,
        string eventName,
        string ageGroup,
        string startDate,
        string endDate,
        string activityType,
        string description
    );

    function createOrgEvent(
        address organiser,
        string memory eventName,
        string memory ageGroup,
        string memory startDate,
        string memory endDate,
        string memory activityType,
        string memory description
    ) public payable {
        address[] memory attendeeList;
        EventInfo memory _event = EventInfo(
            organiser,
            eventName,
            ageGroup,
            startDate,
            endDate,
            activityType,
            description,
            attendeeList
        );

        events.push(_event);

        emit EventCreated(
            organiser,
            eventName,
            ageGroup,
            startDate,
            endDate,
            activityType,
            description
        );
    }

    function getOrgEvents(address orgAddress)
        public
        view
        returns (
            string[] memory eventName,
            string[] memory ageGroup,
            string[] memory startDate,
            string[] memory endDate,
            string[] memory activityType,
            string[] memory description
        )
    {
        uint256 counter = 0;
        for (uint256 i = 0; i < events.length; i++) {
            if (events[i].organiser == orgAddress) {
                counter = counter + 1;
            }
        }
        string[] memory _eNames = new string[](counter);
        string[] memory _aGroups = new string[](counter);
        string[] memory _sDate = new string[](counter);
        string[] memory _eDate = new string[](counter);
        string[] memory _aType = new string[](counter);
        string[] memory _desc = new string[](counter);
        counter = 0;
        for (uint256 i = 0; i < events.length; i++) {
            if (events[i].organiser == orgAddress) {
                _eNames[counter] = events[i].eventName;
                _aGroups[counter] = events[i].ageGroup;
                _sDate[counter] = events[i].startDate;
                _eDate[counter] = events[i].endDate;
                _aType[counter] = events[i].activityType;
                _desc[counter] = events[i].description;
                counter++;
            }
        }
        return (_eNames, _aGroups, _sDate, _eDate, _aType, _desc);
    }

    function newAttendee(address _user, string memory eventName)
        public
        payable
    {
        for (uint256 i = 0; i < events.length; i++) {
            if (
                keccak256(bytes(events[i].eventName)) ==
                keccak256(bytes(eventName))
            ) {
                events[i].attendees.push(_user);
            }
        }
    }

    function getAllEventAttendees(string memory eventName)
        public
        view
        returns (address[] memory)
    {
        for (uint256 i = 0; i < events.length; i++) {
            if (
                keccak256(bytes(events[i].eventName)) ==
                keccak256(bytes(eventName))
            ) {
                return events[i].attendees;
            }
        }
        revert("No sign ups yet");
    }

    /**
     * @dev unpauses the contract
     */
    function unpause() public onlyOwner {
        _unpause();
    }
}
