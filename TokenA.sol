// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title TokenA - ERC20 Token para el DEX
contract TokenA is ERC20 {
    constructor(uint256 initialSupply) ERC20("TokenA", "TKA") {
        // Al desplegar, asigna toda la cantidad al creador
        _mint(msg.sender, initialSupply);
    }
}