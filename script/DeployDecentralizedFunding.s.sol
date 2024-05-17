// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {DecentralizedFunding} from "../src/DecentralizedFunding.sol";
import {Script} from "forge-std/Script.sol";

contract DeployDecentralizedFunding is Script{
    function run() external returns(DecentralizedFunding){
        vm.startBroadcast();
       DecentralizedFunding decentralizedFunding=new DecentralizedFunding(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.stopBroadcast();
        return decentralizedFunding;
    }
}