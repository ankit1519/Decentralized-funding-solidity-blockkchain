// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test,console} from "forge-std/Test.sol";
import {DecentralizedFunding} from "../src/DecentralizedFunding.sol";
contract DecentralizedFundingTest is Test{
    uint256 num=1;
    DecentralizedFunding decentralizedFunding;
    function setUp() external{
        decentralizedFunding=new DecentralizedFunding();

    }
    function testMinimumUsdFive() view public {
        assertEq(decentralizedFunding.MINIMUM_USD(), 5e18);
    }

    function testUserIsmsgSender() view public{
        console.log(decentralizedFunding.i_owner());
        console.log(address(this));
        assertEq(decentralizedFunding.i_owner(),address(this));
        
    }

    function testPriceFeedVersionIsAccurate() view public{
        
        uint256 version=decentralizedFunding.getVersion();
        console.log(version);
        assertEq(version, 4);
    }
}