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

import "./IBEP20.sol";
import "./Ownable.sol";
import "./IFactory.sol";
import "./IRouter02.sol";

contract RTN is IBEP20, Ownable {
    mapping(address => uint256) private _balance;
    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => bool) private _isExcludedFromFeeWallet;
    uint256 private constant MAX = ~uint256(0);
    uint8 private constant _decimals = 9;
    uint256 private constant _totalSupply = 10 ** 10 * 10 ** _decimals; // 10Billion tokens
    uint256 public buyTax = 2; // 2% buy tax
    uint256 public sellTax = 2; // 2% sell tax
    // 1% will go to burn wallet, other 1% will go to marketing wallet
    address public burnWallet = 0x000000000000000000000000000000000000dEaD; // Burn Wallet
    address public marketWallet = 0x5F417D6A6b4bE90b7E38B72e2b090EC1A0CAA805; // Market Wallet
    uint256 public maxHoldAmount = (_totalSupply * 3) / 100; // 3% of _totalSupply

    uint256 public threshold = _totalSupply / 1000; // 0.1% of _totalSupply

    uint256 private _tax;

    string private constant _name = "Revive The Naira";
    string private constant _symbol = "RTN";

    IRouter02 private router;
    address public pair;

    mapping(address => bool) public _isWhiteList;

    uint256 private launchBlock;
    uint256 private blockDelay = 50; // 150 seconds

    bool private launch = false;

    // Events
    event UpdateWhiteList(address indexed holder, bool value);
    event SetMaxHoldAmount(uint256 indexed maxHoldAmount);

    constructor() {
        router = IRouter02(0x10ED43C718714eb63d5aA57B78B54704E256024E); // bsc mainnet
        pair = IFactory(router.factory()).createPair(
            address(this),
            router.WETH()
        );

        _balance[msg.sender] = _totalSupply;

        _isExcludedFromFeeWallet[msg.sender] = true;
        _isExcludedFromFeeWallet[marketWallet] = true;
        _isExcludedFromFeeWallet[burnWallet] = true;
        _isExcludedFromFeeWallet[address(this)] = true;

        _isWhiteList[msg.sender] = true; // owner
        _isWhiteList[address(this)] = true; // token contract
        _isWhiteList[pair] = true; // pair

        _allowances[address(this)][address(router)] = MAX;

        emit Transfer(address(0), _msgSender(), _totalSupply);
    }

    function name() public pure returns (string memory) {
        return _name;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }

    function totalSupply() public pure override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balance[account];
    }

    function transfer(
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()] - amount
        );
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function enableTrading() external onlyOwner {
        launch = true;
        launchBlock = block.number;
    }

    function configureExempted(
        address[] memory _wallets,
        bool _enable
    ) external onlyOwner {
        for (uint256 i = 0; i < _wallets.length; i++) {
            _isExcludedFromFeeWallet[_wallets[i]] = _enable;
        }
    }

    function newBlockDelay(uint256 number) external onlyOwner {
        blockDelay = number;
    }

    function changeTax(
        uint256 newBuyTax,
        uint256 newSellTax
    ) external onlyOwner {
        require(newBuyTax < 100 && newSellTax < 100, "BEP20: wrong tax value!");
        buyTax = newBuyTax;
        sellTax = newSellTax;
    }

    function setMarketingWallet(address _marketWallet) external onlyOwner {
        marketWallet = _marketWallet;
    }

    function _tokenTransfer(address from, address to, uint256 amount) private {
        uint256 taxTokens = (amount * _tax) / 100;
        uint256 transferAmount = amount - taxTokens;

        _balance[from] = _balance[from] - amount;
        _balance[to] = _balance[to] + transferAmount;
        emit Transfer(from, to, transferAmount);

        uint256 burnAmount = taxTokens / 2;
        uint256 marketAmount = taxTokens - burnAmount;

        if (burnAmount > 0) {
            _balance[burnWallet] = _balance[burnWallet] + burnAmount; // half to burn wallet
            emit Transfer(from, burnWallet, burnAmount);
        }

        if (marketAmount > 0) {
            _balance[address(this)] = _balance[address(this)] + marketAmount; // half to market wallet
            emit Transfer(from, address(this), marketAmount);
        }

        // maxHoldAmount check
        if (!_isWhiteList[to]) {
            require(_balance[to] <= maxHoldAmount, "Over Max Holding Amount");
        }
    }

    function _transfer(address from, address to, uint256 amount) private {
        require(from != address(0), "BEP20: transfer from the zero address");

        if (_isExcludedFromFeeWallet[from] || _isExcludedFromFeeWallet[to]) {
            _tax = 0;
        } else {
            require(launch, "Wait till launch");
            if (block.number < launchBlock + blockDelay) {
                _tax = 99;
            } else {
                if (from == pair) {
                    _tax = buyTax;
                } else if (to == pair) {
                    uint256 tokensToSwap = balanceOf(address(this));
                    if (tokensToSwap > threshold) {
                        swapTokensForEth(threshold);
                    }
                    _tax = sellTax;
                } else {
                    _tax = 0;
                }
            }
        }
        _tokenTransfer(from, to, amount);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = router.WETH();
        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            marketWallet,
            block.timestamp
        );
    }
    receive() external payable {}

    function setMaxHoldAmount(uint256 _maxHoldAmount) external onlyOwner {
        maxHoldAmount = _maxHoldAmount;

        emit SetMaxHoldAmount(_maxHoldAmount);
    }

    function updateWhiteList(address _holder, bool _value) external onlyOwner {
        _isWhiteList[_holder] = _value;

        emit UpdateWhiteList(_holder, _value);
    }
}
