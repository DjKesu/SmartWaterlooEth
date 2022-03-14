//SPDX-License-Identifier: Unlicensed
/// @custom:security-contact krish.mehta@uwaterloo.ca
pragma solidity ^0.8.0;

//import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract SmartOrganisation is Ownable, Pausable {
    /**
     * @dev Set who may pause the contract
     */
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
     * @dev Initialize a list of verified businesses
     */
    string[] verifiedBusinesses;

    struct Organisation {
        address _orgOwner;
        string businessNumber;
        string[] members;
        bool verified;
    }

    constructor() {
        verifiedBusinesses = ["1234567890"];
    }

    Organisation[] public organisations;

    /**
     * @dev log transaction whenever new business is added to the verified business list
     */
    event newBusinessAdded(string businessNumber);

    // Create an event when a new item is added, you can use this to update remote item lists.
    event OrganisationCreated(
        address _orgOwner,
        string businessNumber,
        string[] members,
        bool verified
    );

    // Adds an item to the user's Item list who called the function.
    function createOrg(
        address _user,
        string memory businessNumber,
        string[] memory members
    ) public payable onlyOwner {
        for (uint256 i = 0; i < organisations.length; i++) {
            require(
                keccak256(bytes(organisations[i].businessNumber)) !=
                    keccak256(bytes(businessNumber)),
                "Organisation already exists"
            );
        }
        bool verify = false;

        for (uint256 i = 0; i < verifiedBusinesses.length; i++) {
            if (
                keccak256(bytes(verifiedBusinesses[i])) ==
                keccak256(bytes(businessNumber))
            ) {
                verify = true;
            }
        }
        Organisation memory newOrg = Organisation(
            _user,
            businessNumber,
            members,
            verify
        );
        organisations.push(newOrg);

        // emits item added event.
        emit OrganisationCreated(_user, businessNumber, members, verify);
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

    function getTotalOrganisations() public view returns (uint256) {
        return organisations.length;
    }

    function addVerifiedBusiness(string memory _bnumber) public onlyOwner {
        verifiedBusinesses.push(_bnumber);

        emit newBusinessAdded(_bnumber);
    }

    function getAllVerifiedBusinesses() public view returns (string[] memory) {
        return verifiedBusinesses;
    }
}
