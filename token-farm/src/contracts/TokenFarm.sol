pragma solidity >=0.5.16;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    string public name = "Dapp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;

    // mapping()

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    // Stakes Tokens into the smart contract (Deposit)
    function stakeTokens(uint256 _amount) public {
        // Transfar mock dai to this contract for stakin
        daiToken.transferFrom(msg.sender, address(this), _amount);
    }

    // Unstaking Tokens (Withdraw)

    // Issuing Tokens
}
