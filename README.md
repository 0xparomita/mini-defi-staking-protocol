# Mini DeFi Staking Protocol

A minimal decentralized staking system demonstrating how DeFi yield mechanics work on-chain.

Users can:

- Stake tokens
- Earn rewards
- Withdraw stake
- Claim rewards

Flat repository structure for maximum readability.

---

## Features

• ERC20 staking token  
• Reward distribution logic  
• Time-based rewards  
• Stake tracking  
• Claim rewards  
• Withdraw stake  

---

## Tech Stack

- Solidity
- Hardhat
- Ethers.js
- HTML + JS

---

## Contract Design

Two contracts:

MockToken → ERC20 used for staking  
Staking → reward logic  

Reward Formula:

reward = stakedAmount × timeElapsed × rewardRate

---

## Setup

Install:

npm install

Compile:

npx hardhat compile

Run local chain:

npx hardhat node

Deploy:

npx hardhat run deploy.js --network localhost

---

## Frontend Setup

Open:

index.html

Edit:

app.js → paste deployed staking contract address

---

## Learning Goals

Understand:

- DeFi reward math
- Token approvals
- Staking logic
- Timestamp calculations
- State accounting

---

## Security Warning

This contract is simplified for learning.

Real staking contracts must include:

- Reentrancy protection
- Precision math libraries
- Reward caps
- Emergency withdraw

---

## License
MIT
