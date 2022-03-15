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
        string birthdate;
        string gender;
        string height;
        string weight;
        string grade;
        string postalCode;
        string race;
        string religion;
        string sexuality;
        string nickname;
    }

    /**
     * @dev Create an array of 'Info' structs
     */
    Info[] public infos;

    constructor() {}

    // Create an event when a new item is added, you can use this to update remote item lists.
    event InformationAdded(
        address _user,
        string birthdate,
        string gender,
        string height,
        string weight,
        string grade,
        string postalCode,
        string race,
        string religion,
        string sexuality,
        string nickname
    );

    // Adds an item to the user's Item list who called the function.
    function addInfo(
        address _user,
        string memory birthdate,
        string memory gender,
        string memory height,
        string memory weight,
        string memory grade,
        string memory postalCode,
        string memory race,
        string memory religion,
        string memory sexuality,
        string memory nickname
    ) public payable onlyOwner {
        Info memory _formInfo = Info(
            _user,
            birthdate,
            gender,
            height,
            weight,
            grade,
            postalCode,
            race,
            religion,
            sexuality,
            nickname
        );

        infos.push(_formInfo);

        // emits item added event.
        emit InformationAdded(
            msg.sender,
            birthdate,
            gender,
            height,
            weight,
            grade,
            postalCode,
            race,
            religion,
            sexuality,
            nickname
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
                    infos[i].birthdate,
                    infos[i].gender,
                    infos[i].height,
                    infos[i].weight,
                    infos[i].grade,
                    infos[i].postalCode,
                    infos[i].race,
                    infos[i].religion,
                    infos[i].sexuality,
                    infos[i].nickname
                );
            }
        }
        return (
            "Not found",
            "Not found",
            "Not found",
            "Not found",
            "Not found",
            "Not found",
            "Not found",
            "Not found",
            "Not found",
            "Not found"
        );
    }

    /**
     * @dev get a Total Count of signed up addresses
     */
    function getTotalUsers() public view returns (uint256) {
        return infos.length;
    }
}
