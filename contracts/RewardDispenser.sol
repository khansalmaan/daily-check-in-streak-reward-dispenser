// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract RewardDispenser {
    IERC20 public RewardToken;
    address public owner;

    struct User {
        uint256 lastClaimed;
        uint256 streak;
    }

    mapping(address => User) public users;

    constructor(address _token) {
        RewardToken = IERC20(_token);
        owner = msg.sender;
    }

    function claimDailyReward() public {
        User storage user = users[msg.sender];

        // Check if user exists, if not create a new user with an initial streak
        if (user.lastClaimed == 0) {
            user.lastClaimed = block.timestamp;
            user.streak = 1;
        } else {
            // Calculate if the user is eligible to claim the reward today
            uint256 timeSinceLastClaim = block.timestamp - user.lastClaimed;
            if (timeSinceLastClaim >= 1 days) {
                if (timeSinceLastClaim < 2 days) {
                    // Increment streak if claimed within the next day
                    user.streak += 1;
                } else {
                    // Reset streak if more than a day has passed since the last claim
                    user.streak = 1;
                }

                // Update lastClaimed timestamp
                user.lastClaimed = block.timestamp;

                // Calculate and transfer the reward (this part needs to be implemented)
                // uint256 reward = calculateReward(user.streak);
                // require(RewardToken.transfer(msg.sender, reward), "Transfer failed");
            } else {
                revert("Reward already claimed for today");
            }
        }
    }

    function fillRewardPool(uint256 amount) external {
        // Ensure the sender has approved the contract to spend the tokens
        require(RewardToken.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }

    function getRewardPool() external view returns (uint256) {
        return RewardToken.balanceOf(address(this));
    }

    function calculateReward(uint256 streak) internal pure returns (uint256) {
        // Implement the logic to calculate the reward based on the streak
        return streak * 1e18; // Example: 1 token per streak day
    }

    function withdrawTokens(uint256 amount) external {
        require(msg.sender == owner, "Only owner can withdraw tokens");
        require(RewardToken.transfer(owner, amount), "Transfer failed");
    }

    function getUserInfo(address _user) external view returns (uint256 lastClaimed, uint256 streak) {
        User storage user = users[_user];
        return (user.lastClaimed, user.streak);
    }
}
