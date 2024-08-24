# RewardDispenser

**RewardDispenser** is a Solidity-based smart contract that distributes daily rewards to users based on their engagement streaks. The contract interacts with an ERC-20 token, allowing users to claim rewards on a daily basis, with rewards increasing based on the length of the user's streak.

## Features

- **Daily Rewards**: Users can claim daily rewards if they have not claimed within the last 24 hours.
- **Streak-Based Rewards**: The longer the streak (consecutive daily claims), the higher the reward.
- **Reward Pool Management**: The contract owner or any authorized user can fill the reward pool with tokens.
- **User Information**: Anyone can view their last claim timestamp and current streak.
- **Owner Privileges**: The contract owner can withdraw tokens from the contract.

## Contract Overview

The contract provides the following key functions:

- **`claimDailyReward()`**: Allows users to claim their daily reward if eligible. The reward amount is calculated based on the user's streak.
- **`fillRewardPool(uint256 amount)`**: Allows the contract owner or authorized users to deposit tokens into the reward pool.
- **`getRewardPool()`**: Returns the current balance of the reward pool.
- **`calculateReward(uint256 streak)`**: Internal function to calculate the reward based on the user's streak.
- **`withdrawTokens(uint256 amount)`**: Allows the contract owner to withdraw tokens from the contract.
- **`getUserInfo(address user)`**: Returns the last claim timestamp and streak of a user.
