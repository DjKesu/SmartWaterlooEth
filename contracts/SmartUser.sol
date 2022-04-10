//SPDX-License-Identifier: Unlicensed
/// @custom:security-contact krish.mehta@uwaterloo.ca

//TO-DO:
// 1) Add a mapping and indexing to user's address
// 2) Make contracts inter-operable
// 3) Add organisation data access
// 4) Think of a way to store data added through surveys and be able to query that data

pragma solidity ^0.8.0;

//import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

//inital_Data structuring
// string uid;
// string birthdate;
// string gender;
// string body;
// string grade;
// string postalCode;
// string race;
// string religion;
// string sexuality;
// string avatarName;

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
        string[] initialData;
    }

    /**
     * @dev Create an array of 'Info' structs
     */
    Info[] public infos;
    
    constructor() {}

    // Create an event when a new item is added, you can use this to update remote item lists.
    event InformationAdded(
        address _user,
        string[] _initialData);

    // Adds an item to the user's Item list who called the function.
    function addInfo(
        address _user,
        string[] memory _initialData
    ) public payable {

        if(_initialData.length != 10)
        {
            revert("Tried inserting more elements in initial Data");
        }
        Info memory _formInfo = Info(
            _user,
            _initialData
        );

        infos.push(_formInfo);

        // emits item added event.
        emit InformationAdded(
            msg.sender,
            _initialData
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
            string[] memory
        )
    {
        for (uint256 i = 0; i < infos.length; i++) {
            if (infos[i]._user == _addr) {
                return (
                    infos[i].initialData
                );
            }
        }
        revert("Not Found!");
    }

    /**
     * @dev get a Total Count of signed up addresses
     */
    function getTotalUsers() public view returns (uint256) {
        return infos.length;
    }
}