// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {Vault} from "src/Challenge8-vault/Puzzle.sol";

contract Challenge8Test is Test {
    Vault public puzzle;
    address player = makeAddr("player");

    /// @dev Setup the testing environment.
    function setUp() public {
        // lets imagine that the password is a random value
        puzzle = new Vault(keccak256("password"));
        
    }

    function testSimpleHack() public {
        // all the data inside a contract is public and readable even if you set it as private
        // so we can just read the password and send it to the withdraw function
        // we could also take a look at the construction transaction and get the password from there
        
        assertEq(puzzle.locked(), true);

        bytes32 value = vm.load(address(puzzle), bytes32(uint256(1)));
        // you could also use cast for a more real world case;
        // https://book.getfoundry.sh/reference/cast/cast-storage
        // or even dump all the storage
        // https://twitter.com/BeckerrJon/status/1636512763710242817

        puzzle.unlock(value);
        
        assertEq(puzzle.locked(), false);
        
    }


    function testHackHuff() public {
        // no need to
    }
    
}
