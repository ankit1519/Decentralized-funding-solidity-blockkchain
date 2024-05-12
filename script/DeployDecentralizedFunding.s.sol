// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {DecentralizedFunding} from "../src/DecentralizedFunding.sol";
import {Script} from "forge-std/Script.sol";

contract DeployDecentralizedFunding is Script{
    function run() external{
        vm.startBroadcast();
       new DecentralizedFunding();
        vm.stopBroadcast();
    }
}