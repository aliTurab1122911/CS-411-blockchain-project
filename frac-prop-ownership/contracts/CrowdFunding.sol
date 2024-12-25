// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    struct PropertyListing{
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] investors;
        uint256[] investments;
    }
    mapping(uint256 => PropertyListing) public PropertyListings;
    uint256 public numberOfPropertyListings = 0;

    function createPropertyLIsting(
        address _owner,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        string memory _image
    ) public returns (uint256){
        PropertyListing storage propertyListing = PropertyListings[numberOfPropertyListings];

        require(propertyListing.deadline < block.timestamp, "Please choose a valid deadline" );

        propertyListing.owner = _owner;
        propertyListing.title = _title;
        propertyListing.description = _description;
        propertyListing.target = _target;
        propertyListing.deadline = _deadline;

        numberOfPropertyListings++;

        return numberOfPropertyListings -1;


    }

    function investToPropertyListing(
        uint256 _id
    ) public payable {
        uint256 amount = msg.value;

        PropertyListing storage propertyListing = PropertyListings[_id];

        propertyListing.investors.push(msg.sender);
        propertyListing.investments.push(amount);

        (bool sent,) = payable(propertyListing.owner).call{value: amount}("");

        if(sent){propertyListing.amountCollected+=amount;}

    }

    function getInvestors(
        uint256 _id
    ) view public returns (address[] memory,uint256[] memory) {
        return (PropertyListings[_id].investors, PropertyListings[_id].investments);
    }

    function getPropertyLIstings(

    ) public view returns (PropertyListing[] memory)  {
        PropertyListing[] memory allpropertyListings = new PropertyListing[](numberOfPropertyListings);
    }

}