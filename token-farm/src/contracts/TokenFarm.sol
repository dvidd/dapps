pragma solidity >=0.5.16;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    string public name = "Dapp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;
    address public owner;

    address[] public stakers;
    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    // Stakes Tokens into the smart contract (Deposit)
    function stakeTokens(uint256 _amount) public {
        require(_amount > 0, "amount cannot be 0");
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
    function unstakeTokens() public {
        // Fetch staking balance
        uint256 balance = stakingBalance[msg.sender];
        // requiere amount greater
        require(balance > 0, "staking balance cannot be 0");
        // Tranfer mock Dai tokens to this contract for staking
        daiToken.transfer(msg.sender, balance);
        // Reset staking balance
        stakingBalance[msg.sender] = 0;
        // Updaye staking balance
        isStaking[msg.sender] = false;
    }

    // Issuing Tokens

    function issueTokens() public {
        require(msg.sender == owner, "caller must be the owner");
        // Issuin token
        for (uint256 i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint256 balance = stakingBalance[recipient];
            if (balance > 0) {
                dappToken.transfer(recipient, balance);
            }
        }
    }
}
