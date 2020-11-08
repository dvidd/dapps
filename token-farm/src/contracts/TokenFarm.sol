pragma solidity >=0.5.16;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    string public name = "Dapp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;

    address[] public stakers;
    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    // Stakes Tokens into the smart contract (Deposit)
    function stakeTokens(uint256 _amount) public {
        // Transfar mock dai to this contract for stakin
        daiToken.transferFrom(msg.sender, address(this), _amount);
        // Update stakeBalance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;
        // Add user to stakers array if they are not already
        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }
        // Update staked status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // Unstaking Tokens (Withdraw)

    // Issuing Tokens
}
