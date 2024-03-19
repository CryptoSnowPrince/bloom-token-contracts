// SPDX-License-Identifier: MIT

// Website: https://www.revivethenaira.com/
// Telegram: https://t.me/revivethenaira
// Youtube: https://www.youtube.com/@revivethenaira
// X(Twitter): https://twitter.com/revivethe_naira

// ██████╗ ███████╗██╗   ██╗██╗██╗   ██╗███████╗    ████████╗██╗  ██╗███████╗    ███╗   ██╗ █████╗ ██╗██████╗  █████╗ 
// ██╔══██╗██╔════╝██║   ██║██║██║   ██║██╔════╝    ╚══██╔══╝██║  ██║██╔════╝    ████╗  ██║██╔══██╗██║██╔══██╗██╔══██╗
// ██████╔╝█████╗  ██║   ██║██║██║   ██║█████╗         ██║   ███████║█████╗      ██╔██╗ ██║███████║██║██████╔╝███████║
// ██╔══██╗██╔══╝  ╚██╗ ██╔╝██║╚██╗ ██╔╝██╔══╝         ██║   ██╔══██║██╔══╝      ██║╚██╗██║██╔══██║██║██╔══██╗██╔══██║
// ██║  ██║███████╗ ╚████╔╝ ██║ ╚████╔╝ ███████╗       ██║   ██║  ██║███████╗    ██║ ╚████║██║  ██║██║██║  ██║██║  ██║
// ╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝  ╚═══╝  ╚══════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝

pragma solidity 0.8.7;

interface IRouter02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function factory() external pure returns (address);
    function WETH() external pure returns (address);
}
