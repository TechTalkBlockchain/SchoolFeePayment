// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SchoolFeePayment {
    address public owner;
    mapping(address => uint) public studentBalances;

    event FeePaid(address indexed student, uint amount);

    constructor() {
        owner = msg.sender;
    }

    function payFee() public payable {
        require(msg.value > 0, "Payment must be greater than zero");
        studentBalances[msg.sender] += msg.value;
        emit FeePaid(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(msg.sender == owner, "Only the owner can withdraw");
        require(amount <= address(this).balance, "Insufficient balance in contract");
        payable(owner).transfer(amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
