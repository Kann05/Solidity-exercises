
//SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe{

    uint256 public minimumUsd = 5e18;

   
    address transactionAddress;
        
  
    address[] public funders;

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable{

        require(getConversionRate(msg.value) >= minimumUsd, "Didnt send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] +=  msg.value;
    }

    function withdraw() public onlyOwner{
        
        for(uint256 getAddressIndex = 0; getAddressIndex < funders.length; getAddressIndex++){
            address getTempAddress = funders[getAddressIndex];
            addressToAmountFunded[getTempAddress] = 0;
            
        }

        funders = new address[](0);
        (bool sent, ) = payable(msg.sender).call{value:address(this).balance}("");
        require(sent,"Failed Sending");
    }

    function getPrice()public view returns(uint256){
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306  ETH/USD ChainLink
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        //Price of ETH in terms of USD
        return uint256(answer * 1e10);
    }
    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() public view returns(uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

    modifier onlyOwner() {  //ADDS SECURITY  GIVES ACCESS ONLY TO SPECIFIC OWNERS ADDRESS PERMISSION TO WITHDRAW FROM CONTRACT
        require(msg.sender == owner, "Must be owner address !");
        _;
    }

}