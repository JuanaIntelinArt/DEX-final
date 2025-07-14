# 🧪 Proyecto Final - SimpleDEX

Este proyecto es un **Exchange Descentralizado Simple (DEX)** implementado en Solidity, desplegado en la red de prueba **Sepolia**. Permite el intercambio de dos tokens ERC-20 mediante un **pool de liquidez**, siguiendo la fórmula del producto constante:  
**(x + dx)(y - dy) = xy**

## 🔗 Contratos desplegados en Sepolia

- **TokenA:** 0xc5c665312c0e3b371da5c64840a9a6c4eb729338
- **TokenB:** 0x05da5a7e6a909272877b8f7d8f1556920e79f2cc
- **SimpleDEX:** 0x2d41c4bd7fa1557701aec81bc1e39744f252796c

## 🛠️ Funcionalidades

### ✅ TokenA y TokenB
- ERC-20 estándar usando OpenZeppelin.
- 18 decimales.
- Supply definido en el constructor y asignado al deployer.

### ✅ SimpleDEX
- Pool de liquidez para `TokenA` y `TokenB`
- Funciones clave:
  - `addLiquidity(uint256 amountA, uint256 amountB)`
  - `swapAforB(uint256 amountAIn)`
  - `swapBforA(uint256 amountBIn)`
  - `removeLiquidity(uint256 amountA, uint256 amountB)`
  - `getPrice(address _token)`
- Solo el owner puede agregar o quitar liquidez.
- Eventos emitidos para swaps y movimientos de liquidez.

## 📸 Pruebas realizadas

- ✅ Despliegue de tokens y DEX en Remix
- ✅ Aprobación (`approve`) de tokens desde el usuario hacia `SimpleDEX`
- ✅ Agregado exitoso de liquidez usando `addLiquidity`

## 📚 Lecciones aprendidas

- Comprendí cómo funcionan los **pools de liquidez** y la fórmula de producto constante.
- Aprendí a implementar y desplegar **tokens ERC-20** personalizados.
- Usé `approve` y `transferFrom` para interactuar entre contratos.
- Aprendí a usar Remix, Sepolia, y GitHub para desplegar y documentar proyectos Web3.

## 🚀 Herramientas utilizadas

- Solidity 0.8.20
- OpenZeppelin Contracts
- Remix IDE
- Sepolia Testnet
- Rabby Wallet
- Git & GitHub

## 📁 Estructura del repositorio

/DEX-Final
├── TokenA.sol
├── TokenB.sol
├── SimpleDEX.sol

Proyecto final del **Módulo 3 – Smart Contracts**



