// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test,console} from "forge-std/Test.sol";
import {DecentralizedFunding} from "../src/DecentralizedFunding.sol";
import {DeployDecentralizedFunding} from "../script/DeployDecentralizedFunding.s.sol";


contract DecentralizedFundingTest is Test{
    // uint256 num=1;
    DecentralizedFunding decentralizedFunding;
    function setUp() external{
        // decentralizedFunding=new DecentralizedFunding(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployDecentralizedFunding deployDecentralizedFunding=new DeployDecentralizedFunding();
        decentralizedFunding=deployDecentralizedFunding.run();

    }
    function testMinimumUsdFive() view public {
        assertEq(decentralizedFunding.MINIMUM_USD(), 5e18);
    }

    function testUserIsmsgSender() view public{
        console.log(decentralizedFunding.i_owner());
        console.log(address(this));
        assertEq(decentralizedFunding.i_owner(),msg.sender);
        
    }

    function testPriceFeedVersionIsAccurate() view public{
        
        uint256 version=decentralizedFunding.getVersion();
        console.log(version);
        assertEq(version, 4);
    }
}