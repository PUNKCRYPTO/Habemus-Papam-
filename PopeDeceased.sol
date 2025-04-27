// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract PapalVesting {
    address public owner;
    address public token;
    address public beneficiary;
    uint256 public releaseTime;
    bool public popeDeceased = false;

    constructor(address _token) {
        owner = msg.sender;
        token = _token;
        beneficiary = 0x314473811fcA9C8f377803E10Ada04a1Acda31a2;
        releaseTime = block.timestamp + (12 * 365 days);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // ⚰️ Manually marks the death of the Pope elected in 2025
    function triggerPapalDeath() external onlyOwner {
        popeDeceased = true;
    }

    // 🔓 Allows the beneficiary to release the tokens
    function release() external {
        require(msg.sender == beneficiary, "Only the beneficiary can withdraw");
        require(
            block.timestamp >= releaseTime || popeDeceased,
            "Tokens are still locked"
        );

        uint256 amount = IERC20(token).balanceOf(address(this));
        require(amount > 0, "No tokens available");

        IERC20(token).transfer(beneficiary, amount);
    }
}
