const DappToken = artifacts.require("DappToken");
const DaiToken = artifacts.require("DaiToken");
const TokenFarm = artifacts.require("TokenFarm");

module.exports = async function(deployer, network, accounts) {
  // Deploy mock dai token
  await deployer.deploy(DaiToken);
  const daiToken = await DaiToken.deployed();
  // Deploy mock dapp token
  await deployer.deploy(DappToken);
  const dappToken = await DappToken.deployed();

  await deployer.deploy(TokenFarm, dappToken.address, daiToken.address);
  const tokenFarm = await TokenFarm.deployed();
  // transfer tokens to the tokenFarn
  await dappToken.transfer(tokenFarm.address, "1000000000000000000000000");

  // Transfer 100 Mock Dai tokens to investor
  await daiToken.transfer(accounts[1], "1000000000000000000000000");
};
