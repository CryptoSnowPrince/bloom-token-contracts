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

interface IBEP20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
