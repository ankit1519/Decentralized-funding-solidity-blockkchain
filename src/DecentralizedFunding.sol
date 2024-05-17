// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//get funds from users
//withdraw funds
//set minimum funding value in USD
import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
error DecentralizedFunding__NotOwner();
contract  DecentralizedFunding {
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD=5e18;
    address[] public funders;


    address public immutable i_owner;
    AggregatorV3Interface private s_priceFeed;
    constructor(address priceFeed){
        i_owner=msg.sender;
        s_priceFeed=AggregatorV3Interface(priceFeed);
    }
    mapping(address funder=>uint256 amount) public fundDetail;
    function fund()public payable {
        //allow user to send money and set min amt
        // require(msg.value>1e18,"didnt have enough eth"); //1e18=1ETH=1000000000000000000=10**18 wei
        require(msg.value.getConversionRate(s_priceFeed)>=MINIMUM_USD,"didnt have enough eth"); //1e18=1ETH=1000000000000000000=10**18 wei
        funders.push(msg.sender);
        // fundDetail[msg.sender]+=getConversionRate(msg.value);
    }

    function getVersion() public view returns (uint256){
        return s_priceFeed.version();
    }
     function withdraw() public onlyOwner {
        // require(msg.sender==owner,"Must be owner");

        for(uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            fundDetail[funder]=0;
        }
        //resetting array
        funders=new address[](0);

        //withdraw funds

        // //transfer
        // payable(msg.sender).transfer(address(this).balance); //revert automatically

        // //send
        // bool success=payable (msg.sender).send(address(this).balance);
        // require(success,"failed");

        //call

        (bool callSuccess,)=payable (msg.sender).call{value:address(this).balance}("");
        require((callSuccess),"call failed");
    }


    //modifier
    modifier onlyOwner(){
        // require(msg.sender==i_owner,"sender is not owner");
        if(msg.sender!=i_owner){
            revert DecentralizedFunding__NotOwner();
        }
        _;
    }
    

    //recieve, fallback
    receive()  external payable 
    {
        fund();
    }
    fallback() external payable { 
        fund();
    }

   
}
