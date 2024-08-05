// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// Inherit from both contracts with required parameters
contract BeastToken is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("BeastToken", "BST") Ownable() {
        _mint(msg.sender, initialSupply);
    }

    // Minting Tokens
    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Burning Tokens
    function burnTokens(address from, uint256 amount) public onlyOwner {
        _burn(from, amount);
    }

    // Transferring Tokens
    function transferTokens(address from, address to, uint256 amount) public onlyOwner {
        _transfer(from, to, amount);
    }

    // Earning Tokens from Battles
    function earnTokens(address player, uint256 amount) public onlyOwner {
        _mint(player, amount);
    }

    // Getting Token Balance
    function getTokenBalance(address player) public view returns (uint256) {
        return balanceOf(player);
    }

    // Spending Tokens in the In-Game Shop
    function spendTokens(address player, uint256 amount) public onlyOwner {
        _burn(player, amount);
    }
}
