//SPDX-License-Identifier: Unlicensed
/// @custom:security-contact krish.mehta@uwaterloo.ca

pragma solidity ^0.8.0;

//import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

//Inital data structuring
// string uid;
// string birthdate;
// string gender;
// string body;
// string grade;
// string postalCode;
// string race;
// string religion;
// string sexuality;
// string nickname;
// string avatarString

contract SmartUser is Ownable, Pausable {
    /**
     * @dev Set who may pause the contract
     */
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Create a struct to store User Info
     */

    struct Info {
        string[] initialData;
    }

    /**
     * @dev Create an array of 'Info' structs
     */
    mapping(address => Info) infos;

    uint counter = 0;

    constructor() {}

    function addInfo(address _user, string[] memory _initialData)
        public
        payable
    {
        if (_initialData.length != 10) {
            revert("Tried inserting more elements in initial Data");
        }

        infos[_user].initialData = _initialData;
        counter += 1;
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
    function getInfo(address _addr) public view returns (string[] memory) {
        return infos[_addr].initialData;
    }

    /**
     * @dev get a Total Count of signed up addresses
     */
    function getTotalUsers() public view returns (uint256) {
        return counter;
    }
}
