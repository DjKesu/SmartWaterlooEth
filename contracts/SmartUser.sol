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
     * @dev Create an array of 'Info' structs
     */
    // Info[] public infos;


    uint256 totalUsers = 0;
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
    }
    
    mapping(address => Info[]) public infos;

    address payable public user;

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
        string sexuality
    );

    function setUser(address payable _user) public onlyOwner {
        user = _user;
    }

    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,30092002,Male,173,132,14,N2L3G5,Asian,Other,Other

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
        string memory sexuality
    ) public payable onlyOwner {

        Info memory _formInfo = Info(_user,
        birthdate,
        gender,
        height,
        weight,
        grade,
        postalCode,
        race,
        religion,
        sexuality);

        infos[msg.sender].push(_formInfo);


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
            sexuality
        );
        totalUsers = totalUsers + 1;
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

    function getInfo(address _addr) public view returns (string memory, string memory, string memory, string memory, string memory, string memory, string memory, string memory, string memory)
    {
        return (infos[msg.sender][0].birthdate,infos[msg.sender][0].gender,infos[msg.sender][0].height,infos[msg.sender][0].weight,infos[msg.sender][0].grade,infos[msg.sender][0].postalCode,infos[msg.sender][0].race,infos[msg.sender][0].religion,infos[msg.sender][0].sexuality);
    }
    
    function getTotalUsers() public view returns(uint256)
    {
        return totalUsers;
    }
}