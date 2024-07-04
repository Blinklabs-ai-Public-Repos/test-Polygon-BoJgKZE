// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MyToken is ERC20, Ownable, ERC20Burnable {
    uint256 private immutable _initialSupply;

    constructor(string memory name_, string memory symbol_, uint256 initialSupply_) ERC20(name_, symbol_) {
        _initialSupply = initialSupply_ * 10 ** decimals();
        _mint(msg.sender, _initialSupply);
    }

    function burn(uint256 amount) public override {
        super.burn(amount);
    }

    function burnFrom(address account, uint256 amount) public override {
        super.burnFrom(account, amount);
    }
}