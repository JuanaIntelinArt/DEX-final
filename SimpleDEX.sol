// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title SimpleDEX - Un exchange descentralizado básico con pool de liquidez
contract SimpleDEX {
    IERC20 public tokenA;
    IERC20 public tokenB;
    address public owner;

    uint256 public reserveA;
    uint256 public reserveB;

    event LiquidityAdded(uint256 amountA, uint256 amountB);
    event LiquidityRemoved(uint256 amountA, uint256 amountB);
    event Swapped(address indexed user, address tokenIn, uint256 amountIn, address tokenOut, uint256 amountOut);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        owner = msg.sender;
    }

    /// @notice Agrega liquidez al pool
    function addLiquidity(uint256 amountA, uint256 amountB) external onlyOwner {
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "Transfer failed A");
        require(tokenB.transferFrom(msg.sender, address(this), amountB), "Transfer failed B");

        reserveA += amountA;
        reserveB += amountB;

        emit LiquidityAdded(amountA, amountB);
    }

    /// @notice Intercambia TokenA por TokenB
    function swapAforB(uint256 amountAIn) external {
        require(tokenA.transferFrom(msg.sender, address(this), amountAIn), "Transfer failed A");

        uint256 amountBOut = getAmountOut(amountAIn, reserveA, reserveB);
        require(tokenB.transfer(msg.sender, amountBOut), "Transfer failed B");

        reserveA += amountAIn;
        reserveB -= amountBOut;

        emit Swapped(msg.sender, address(tokenA), amountAIn, address(tokenB), amountBOut);
    }

    /// @notice Intercambia TokenB por TokenA
    function swapBforA(uint256 amountBIn) external {
        require(tokenB.transferFrom(msg.sender, address(this), amountBIn), "Transfer failed B");

        uint256 amountAOut = getAmountOut(amountBIn, reserveB, reserveA);
        require(tokenA.transfer(msg.sender, amountAOut), "Transfer failed A");

        reserveB += amountBIn;
        reserveA -= amountAOut;

        emit Swapped(msg.sender, address(tokenB), amountBIn, address(tokenA), amountAOut);
    }

    /// @notice Retira liquidez (solo owner)
    function removeLiquidity(uint256 amountA, uint256 amountB) external onlyOwner {
        require(reserveA >= amountA && reserveB >= amountB, "Not enough reserves");

        reserveA -= amountA;
        reserveB -= amountB;

        require(tokenA.transfer(msg.sender, amountA), "Transfer failed A");
        require(tokenB.transfer(msg.sender, amountB), "Transfer failed B");

        emit LiquidityRemoved(amountA, amountB);
    }

    /// @notice Retorna el precio actual de 1 unidad del token opuesto
    function getPrice(address _token) external view returns (uint256) {
        if (_token == address(tokenA)) {
            return (reserveB * 1e18) / reserveA;
        } else if (_token == address(tokenB)) {
            return (reserveA * 1e18) / reserveB;
        } else {
            revert("Token not supported");
        }
    }

    /// @notice Calcula el output usando la fórmula del producto constante: (x+dx)(y-dy) = xy
    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256) {
        require(reserveIn > 0 && reserveOut > 0, "Invalid reserves");

        uint256 amountInWithFee = amountIn * 997; // 0.3% fee
        uint256 numerator = amountInWithFee * reserveOut;
        uint256 denominator = (reserveIn * 1000) + amountInWithFee;

        return numerator / denominator;
    }
}
