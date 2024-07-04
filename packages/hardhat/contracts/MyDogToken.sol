// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MyDogToken is ERC20, Ownable, ERC20Burnable {
    uint256 private immutable _initialSupply;
    mapping(address => bool) private _whitelist;

    event WhitelistUpdated(address indexed account, bool isWhitelisted);

    constructor(string memory name_, string memory symbol_, uint256 initialSupply_) ERC20(name_, symbol_) {
        _initialSupply = initialSupply_ * 10 ** decimals();
        _mint(msg.sender, _initialSupply);
        _whitelist[msg.sender] = true;
    }

    function burn(uint256 amount) public override {
        super.burn(amount);
    }

    function burnFrom(address account, uint256 amount) public override {
        super.burnFrom(account, amount);
    }

    function addToWhitelist(address account) external onlyOwner {
        _whitelist[account] = true;
        emit WhitelistUpdated(account, true);
    }

    function removeFromWhitelist(address account) external onlyOwner {
        _whitelist[account] = false;
        emit WhitelistUpdated(account, false);
    }

    function isWhitelisted(address account) public view returns (bool) {
        return _whitelist[account];
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        require(_whitelist[from] && _whitelist[to], "MyDogToken: transfer not allowed");
        super._beforeTokenTransfer(from, to, amount);
    }
}