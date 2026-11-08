// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
   PiggyBank smart contract
   Fahad Abdullah, 23i-5565
   MG3012 Assignment 2

   Every user has their own piggy bank. You set a savings goal, keep
   depositing SepoliaETH, and the contract only lets you withdraw once
   your balance reaches the goal. After withdrawing it resets so you can
   start a new goal.
*/

contract PiggyBank {

    struct Account {
        uint balance;
        uint goal;
        uint deposits;
    }

    mapping(address => Account) private savers;
    uint public totalSaved;
    uint public totalSavers;

    event GoalSet(address indexed user, uint goal);
    event Deposited(address indexed user, uint amount, uint newBalance);
    event Withdrawn(address indexed user, uint amount);

    // set a goal (in wei). allowed only when the piggy bank is empty,
    // otherwise someone could lower the goal just to withdraw early
    function setGoal(uint _goal) public {
        require(_goal > 0, "Goal must be more than zero");
        require(savers[msg.sender].balance == 0, "Empty your piggy bank before changing the goal");

        if (savers[msg.sender].goal == 0) {
            totalSavers++;
        }
        savers[msg.sender].goal = _goal;
        emit GoalSet(msg.sender, _goal);
    }

    // put money in
    function deposit() public payable {
        require(savers[msg.sender].goal > 0, "Set a goal first");
        require(msg.value > 0, "Send some ETH");

        savers[msg.sender].balance += msg.value;
        savers[msg.sender].deposits++;
        totalSaved += msg.value;

        emit Deposited(msg.sender, msg.value, savers[msg.sender].balance);
    }

    // take everything out, only after reaching the goal
    function withdraw() public {
        Account storage acc = savers[msg.sender];
        require(acc.balance > 0, "Nothing saved yet");
        require(acc.balance >= acc.goal, "Goal not reached yet");

        uint amount = acc.balance;
        acc.balance = 0;
        acc.deposits = 0;
        totalSaved -= amount;

        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    // read: balance, goal and number of deposits of any user
    function getSavings(address _user) public view returns (uint balance, uint goal, uint deposits) {
        Account memory a = savers[_user];
        return (a.balance, a.goal, a.deposits);
    }

    // read: true if the user can withdraw right now
    function goalReached(address _user) public view returns (bool) {
        return savers[_user].balance > 0 && savers[_user].balance >= savers[_user].goal;
    }
}
