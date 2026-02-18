// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IToken {
    function transferFrom(address,address,uint) external returns(bool);
    function transfer(address,uint) external returns(bool);
}

contract Staking {

    IToken public token;
    uint public rewardRate = 1e14;

    mapping(address => uint) public stakeBalance;
    mapping(address => uint) public lastUpdate;
    mapping(address => uint) public rewards;

    constructor(address _token){
        token = IToken(_token);
    }

    function stake(uint amount) external {
        updateReward(msg.sender);

        token.transferFrom(msg.sender,address(this),amount);
        stakeBalance[msg.sender] += amount;
    }

    function withdraw(uint amount) external {
        require(stakeBalance[msg.sender] >= amount,"not enough");

        updateReward(msg.sender);

        stakeBalance[msg.sender] -= amount;
        token.transfer(msg.sender,amount);
    }

    function claim() external {
        updateReward(msg.sender);

        uint reward = rewards[msg.sender];
        rewards[msg.sender] = 0;

        token.transfer(msg.sender,reward);
    }

    function updateReward(address user) internal {
        uint staked = stakeBalance[user];
        uint time = block.timestamp - lastUpdate[user];

        if(staked > 0){
            rewards[user] += (staked * time * rewardRate) / 1e18;
        }

        lastUpdate[user] = block.timestamp;
    }
}
