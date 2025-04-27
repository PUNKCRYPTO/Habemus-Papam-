// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title Habemus Papam Token (HPOPE)
 * @dev ERC-20 Token with initial distribution: 
 * 10% sent to creator's wallet, 90% retained by the deployer for further use.
 */
contract HabemusPapam is ERC20 {
    constructor() ERC20("Habemus Papam!", "HPOPE") {
        uint256 totalSupply = 500_000_000 * 10 ** decimals();

        // 10% to the creator's wallet
        _mint(0x314473811fcA9C8f377803E10Ada04a1Acda31a2, totalSupply * 10 / 100);

        // 90% to the deployer's address (msg.sender)
        _mint(msg.sender, totalSupply * 90 / 100);
    }
}
