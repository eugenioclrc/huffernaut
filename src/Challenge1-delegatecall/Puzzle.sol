// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback {
    mapping(address => uint256) public contributions;
    address payable public owner;

    constructor() {
        address _vitalik = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;

        owner = payable(_vitalik);
        contributions[_vitalik] = 100 ether;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function contribute() public payable {
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = payable(msg.sender);
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    receive() external payable {
        require(msg.value > contributions[msg.sender]);
        owner = payable(msg.sender);
    }
}