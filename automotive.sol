pragma solidity ^0.8.19;

contract automobile {

    address public owner; //deployer of the contract
    mapping(address => bool) public buyers;//keeping track of our buyers
    string public vehicleModel;//the vehicle model to be sold
    string public vehicleMake;
    uint256 public price;//price of vehice to be sold

    event Purchase(address buyer, string make, string model, uint price);//this emits the purchase transaction

    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }


    function buyVehicle (string memory _make, string memory _model) public payable {
        require(msg.value >= price, "insufficeint funds");
        require(buyers[msg.sender] == false,"anything can happen");
        vehicleMake = _make;
        vehicleModel = _model;
        buyers[msg.sender] = true;
        emit Purchase(msg.sender, _make,_model,price);

    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function checkOwnership() public view returns(bool) {
        return(buyers[msg.sender]);//from our mapping... we keeping track our owners of a particular vehicle
    }
}