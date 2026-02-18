// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockToken {

    string public name = "Stake Token";
    string public symbol = "STK";
    uint8 public decimals = 18;

    uint public totalSupply;

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);

    constructor() {
        uint supply = 1_000_000 ether;
        totalSupply = supply;
        balanceOf[msg.sender] = supply;
        emit Transfer(address(0), msg.sender, supply);
    }

    function transfer(address to, uint amount) external returns(bool){
        require(balanceOf[msg.sender] >= amount, "balance low");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;

        emit Transfer(msg.sender,to,amount);
        return true;
    }

    function approve(address spender, uint amount) external returns(bool){
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }

    function transferFrom(address from,address to,uint amount) external returns(bool){
        require(balanceOf[from] >= amount,"balance low");
        require(allowance[from][msg.sender] >= amount,"not approved");

        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit Transfer(from,to,amount);
        return true;
    }
}
