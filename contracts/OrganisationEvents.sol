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

    /**
     * @dev struct that contains all information regarding each event
     */

    // string eventName;
    // string ageGroup;
    // string startDate;
    // string endDate;
    // string activityType;
    // string description;

    struct EventInfo {
        address organiser;
        string[6] eventInfo;
        string eID;
        address[] attendees;
    }

    //Array to store all events
    EventInfo[] public events;

    /**
     * @dev create event for an organisation
     */
    function createOrgEvent(
        address organiser,
        string memory eventName,
        string memory ageGroup,
        string memory startDate,
        string memory endDate,
        string memory activityType,
        string memory description,
        string memory eventId
    ) public payable {
        address[] memory attendeeList;
        string[6] memory _eventInfo;
        _eventInfo = [
            eventName,
            ageGroup,
            startDate,
            endDate,
            activityType,
            description
        ];
        EventInfo memory _event = EventInfo(
            organiser,
            _eventInfo,
            eventId,
            attendeeList
        );

        events.push(_event);
    }

    /**
     * @dev get all events set by an organisation
     */
    function getOrgEventIDs(address orgAddress)
        public
        view
        returns (string[] memory)
    {
        string[] memory eIDs = new string[](events.length);
        uint256 k = 0;
        for (uint256 i = 0; i < events.length; i++) {
            if (events[i].organiser == orgAddress) {
                eIDs[k++] = events[i].eID;
            }
        }
        return eIDs;
    }

    function getEventInfoById(string memory _eID)
        public
        view
        returns (string[6] memory)
    {
        string[6] memory info;
        for (uint256 i = 0; i < events.length; i++) {
            if (keccak256(bytes(events[i].eID)) == keccak256(bytes(_eID))) {
                info = events[i].eventInfo;
            }
        }
        return info;
    }

    /**
     * @dev add a new attendee to an event
     * Parameter: user Address, name of event
     */
    function addNewAttendee(address _user, string memory eId) public payable {
        for (uint256 i = 0; i < events.length; i++) {
            if (keccak256(bytes(events[i].eID)) == keccak256(bytes(eId))) {
                events[i].attendees.push(_user);
            }
        }
    }

    /**
     * @dev get attendee list for a specfic event
     * Parameter: Name of event
     */
    function getAllEventAttendees(string memory eId)
        public
        view
        returns (address[] memory)
    {
        for (uint256 i = 0; i < events.length; i++) {
            if (keccak256(bytes(events[i].eID)) == keccak256(bytes(eId))) {
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

    /**
     * @dev get all events a user has signed up for
     * Parameter: user Address
     */
    function getUserEventIDs(address user)
        public
        view
        returns (string[] memory)
    {
        string[] memory userEventIDs = new string[](events.length);
        uint256 k = 0;
        for (uint256 i = 0; i < events.length; i++) {
            for (uint256 j = 0; j < events[i].attendees.length; j++) {
                if (user == events[i].attendees[j]) {
                    userEventIDs[k++] = events[i].eID;
                    break;
                }
            }
        }
        return userEventIDs;
    }

    function getNumberOfEvents() public view returns (uint256) {
        return events.length;
    }
}
