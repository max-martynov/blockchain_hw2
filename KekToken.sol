// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KekToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Kek", "KEK") {
        _mint(msg.sender, initialSupply);
    }
}