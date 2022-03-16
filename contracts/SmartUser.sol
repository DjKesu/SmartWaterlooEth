//SPDX-License-Identifier: Unlicensed
/// @custom:security-contact krish.mehta@uwaterloo.ca
pragma solidity ^0.8.0;

//import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract SmartUser is Ownable, Pausable {
    /**
     * @dev Set who may pause the contract
     */
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Create a struct to store User Info
     */
    struct Info {
        address _user;
        string uid;
        string birthdate;
        string gender;
        string body;
        string grade;
        string postalCode;
        string race;
        string religion;
        string sexuality;
        string avatarName;
    }

    /**
     * @dev Create an array of 'Info' structs
     */
    Info[] public infos;

    constructor() {}

    // Create an event when a new item is added, you can use this to update remote item lists.
    event InformationAdded(
        address _user,
        string uid,
        string birthdate,
        string gender,
        string body,
        string grade,
        string postalCode,
        string race,
        string religion,
        string sexuality,
        string avatarName
    );

    // Adds an item to the user's Item list who called the function.
    function addInfo(
        address _user,
        string memory uid,
        string memory birthdate,
        string memory gender,
        string memory body,
        string memory grade,
        string memory postalCode,
        string memory race,
        string memory religion,
        string memory sexuality,
        string memory avatarName
    ) public payable {
        Info memory _formInfo = Info(
            _user,
            uid,
            birthdate,
            gender,
            body,
            grade,
            postalCode,
            race,
            religion,
            sexuality,
            avatarName
        );

        infos.push(_formInfo);

        // emits item added event.
        emit InformationAdded(
            msg.sender,
            uid,
            birthdate,
            gender,
            body,
            grade,
            postalCode,
            race,
            religion,
            sexuality,
            avatarName
        );
    }

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

    /**
     * @dev send address to retrieve information
     */
    function getInfo(address _addr)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        for (uint256 i = 0; i < infos.length; i++) {
            if (infos[i]._user == _addr) {
                return (
                    infos[i].uid,
                    infos[i].birthdate,
                    infos[i].gender,
                    infos[i].body,
                    infos[i].grade,
                    infos[i].postalCode,
                    infos[i].race,
                    infos[i].religion,
                    infos[i].sexuality,
                    infos[i].avatarName
                );
            }
        }
        // return ("Not found", "Not found", "Not found", "Not found", "Not found", "Not found", "Not found", "Not found", "Not found","Not found");
        revert("Not Found!");
    }

    /**
     * @dev get a Total Count of signed up addresses
     */
    function getTotalUsers() public view returns (uint256) {
        return infos.length;
    }
}
