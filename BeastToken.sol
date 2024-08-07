// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BeastToken is ERC20 {
    address public owner;

    constructor(uint256 initialSupply) ERC20("BeastToken", "BST")  {
        _mint(msg.sender, initialSupply);
        owner = msg.sender; // set the deployer as the contract owner
    }
    
    function _owner() public view returns (address) {
        return owner;
    }

    // Minting Tokens
    function mintTokens(address to, uint256 amount) public  {
        require(msg.sender == owner, "Only the contract owner can mint tokens");
        _mint(to, amount);
    }

function burnTokens(address from, uint256 amount) public {
    require(msg.sender == owner, "Only the contract owner can burn tokens");
    _burn(from, amount);
}

    // Transferring Tokens
    function transferTokens(address from, address to, uint256 amount) public   {
        require(msg.sender == owner, "Only the contract owner can transfer tokens");
         _transfer(from, to, amount);
    }

    // Earning Tokens from Battles
    function earnTokens(address player, uint256 amount) public  {
        require(msg.sender == owner, "Only the contract owner can earn tokens");
        _mint(player, amount);
    }

    // Getting Token Balance
    function getTokenBalance(address player) public view returns (uint256) {
        return balanceOf(player);
    }

    function spendTokens(address player, uint256 amount) public    {
        require(msg.sender == owner, "Only the contract owner can spend tokens");
              _burn(player, amount);
    }
}
