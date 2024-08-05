// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BeastNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Beast {
        string name;
        uint256 level;
        uint256 xp;
        string[] attacks;
        string metadata;
        uint256 stakedAt;
    }

    mapping(uint256 => Beast) public beasts;

    constructor() ERC721("BeastNFT", "BNFT") {}

    // Minting New Beasts
    function mintBeast(
        address player,
        string memory name,
        string memory metadata
    ) public onlyOwner {
        _tokenIds.increment();
        uint256 newBeastId = _tokenIds.current();
        _mint(player, newBeastId);

        beasts[newBeastId] = Beast(name, 1, 0, new string[](0), metadata, 0);
    }

    // Updating Beast Metadata
    function updateBeastMetadata(
        uint256 beastId,
        uint256 level,
        uint256 xp,
        string[] memory attacks,
        string memory metadata
    ) public onlyOwner {
        require(_exists(beastId), "Beast does not exist");
        Beast storage beast = beasts[beastId];
        beast.level = level;
        beast.xp = xp;
        beast.attacks = attacks;
        beast.metadata = metadata;
    }

    // Staking Beasts for XP
    function stakeBeast(uint256 beastId) public {
        require(ownerOf(beastId) == msg.sender, "You do not own this beast");
        Beast storage beast = beasts[beastId];
        require(beast.stakedAt == 0, "Beast is already staked");
        beast.stakedAt = block.timestamp;
    }

    // Unstaking Beasts
    function unstakeBeast(uint256 beastId) public {
        require(ownerOf(beastId) == msg.sender, "You do not own this beast");
        Beast storage beast = beasts[beastId];
        require(beast.stakedAt != 0, "Beast is not staked");
        uint256 stakedDuration = block.timestamp - beast.stakedAt;
        uint256 earnedXP = stakedDuration / 1 hours; // Earn 1 XP per hour staked
        beast.xp += earnedXP;
        beast.stakedAt = 0;
    }

    // Transferring Beasts
    function transferBeast(address to, uint256 beastId) public {
        require(ownerOf(beastId) == msg.sender, "You do not own this beast");
        _transfer(msg.sender, to, beastId);
    }

    // Checking Beast Ownership
    function checkBeastOwnership(address player, uint256 beastId) public view returns (bool) {
        return ownerOf(beastId) == player;
    }

    // Getting Beast Metadata
    function getBeastMetadata(uint256 beastId) public view returns (string memory) {
        require(_exists(beastId), "Beast does not exist");
        return beasts[beastId].metadata;
    }
}
