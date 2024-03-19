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

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}
