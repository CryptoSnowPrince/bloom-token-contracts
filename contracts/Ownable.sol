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

import "./Context.sol";

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
}
