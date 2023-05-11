// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ExchangeOffice {
    address public owner;
    ERC20 public token; 
    uint public exchangeRate; 

    constructor(address newToken) {
        owner = msg.sender;
        exchangeRate = 1;
        token = ERC20(newToken);
    }

    function changeRate(uint newExchangeRate) public {
        require(msg.sender == owner, "Only the owner can change the rate");
        exchangeRate = newExchangeRate;
    }

    function buyTokens(uint amount) public payable {
        uint weiNeed = amount * exchangeRate; 
        require(msg.value >= weiNeed, "Not enough wei to buy tokens");
        uint balance = token.balanceOf(address(this));
        require(balance >= amount, "Not enough tokens in exchange office");
        token.transfer(msg.sender, amount);
    }

    function sellTokens(uint amount) public payable {
        require(token.balanceOf(msg.sender) >= amount, "Not enough tokens on the account");
        uint weiNeed = amount * exchangeRate; 
        require(address(this).balance >= weiNeed, "Not enough wei in exchange office");
        token.transferFrom(msg.sender, address(this), amount);
        payable(msg.sender).transfer(weiNeed);
    }
}
