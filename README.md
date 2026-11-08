# PiggyBank dApp 🐷

Name: Fahad Abdullah
Roll number: 23i-5565
Course: MG3012 Blockchain Technology for Business (Assignment 2)

## About

PiggyBank is a savings dApp on the Sepolia testnet. Each user gets their own piggy bank inside the smart contract. You set a savings goal, deposit SepoliaETH as many times as you like, and you can only withdraw once your savings reach the goal. When you withdraw, the full amount goes back to your wallet and the piggy bank resets so you can start a new goal.

The idea is the same as a real piggy bank: you can't take the money out early. Here the rule is enforced by the smart contract instead of by willpower.

**Deployed contract (Sepolia):** 0xdFaf5147486be7F9f4fb17670143C0fd670b44D5

**View on Etherscan:** https://sepolia.etherscan.io/address/0xdFaf5147486be7F9f4fb17670143C0fd670b44D5

## Project files

```
SmartContract.sol   Solidity code of the PiggyBank contract
index.html          Frontend (HTML + JavaScript with web3.js)
style.css           Page styling
README.md           This file
screenshots/        Deployment and transaction screenshots
```

## Contract functions

**Write functions**
1. `setGoal(uint goal)` sets your savings goal in wei. Only works when your piggy bank is empty, so nobody can lower the goal just to withdraw early.
2. `deposit()` is payable. Adds the ETH you send to your savings. You need a goal first.
3. `withdraw()` sends all your savings back to you, but only if your balance has reached the goal.

**Read functions**
4. `getSavings(address user)` returns balance, goal and number of deposits of a user.
5. `goalReached(address user)` returns true if the user is allowed to withdraw.

Public variables `totalSaved` and `totalSavers` show stats for the whole contract. The contract also emits `GoalSet`, `Deposited` and `Withdrawn` events.

## Setup steps

**1. MetaMask**
Install the MetaMask browser extension, turn on test networks and select Sepolia. Get free test ETH from a Sepolia faucet (I used https://cloud.google.com/application/web3/faucet/ethereum/sepolia).

**2. Deploying the contract**
1. Open Remix (https://remix.ethereum.org) and create `SmartContract.sol` with the code from this repo.
2. Compile it with Solidity 0.8.20 or above.
3. In Deploy & Run Transactions, select **Injected Provider (MetaMask)**, choose `PiggyBank` and press Deploy.
4. Approve the transaction in MetaMask and copy the contract address.

**3. Connecting the frontend**
1. In `index.html` replace the value of `contractAddress` with the deployed address.
2. Open the page through a web server (GitHub Pages or any local server).
3. Click **Connect Wallet**. The page will ask MetaMask to switch to Sepolia if needed.
4. Set a goal, deposit some ETH, and once the progress bar hits 100% press **Break the piggy bank** to withdraw.

## Extra features on the page

* Progress bar showing how close you are to your goal
* Quick amount buttons (0.001, 0.002, 0.005) for deposits
* Activity list with every transaction you make and its Etherscan link
* Contract wide stats (total ETH saved and number of savers)
* Withdraw button stays locked until the goal is reached
* Automatic network switch to Sepolia and reload on account change
* Works on mobile screens

## Screenshots

![Contract deployed in Remix](screenshots/1_deployment.png)

![Wallet connected](screenshots/2_connected.png)

![Withdraw transaction and activity list](screenshots/3_transaction.png)

![Goal reached before withdrawing](screenshots/4_goal_reached.png)

## Tech used

Solidity 0.8, Remix IDE, MetaMask, Sepolia testnet, web3.js 4, HTML, CSS, JavaScript.
