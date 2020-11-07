const DappToken = artifacts.require("DappToken");
const DaiToken = artifacts.require("DaiToken");
const TokenFarm = artifacts.require("TokenFarm");

require("chai")
  .use(require("chai-as-promised"))
  .should();

function tokens(n) {
  return web3.utils.toWei(n, "Ether");
}

contract("TokenFarm", ([owner, investor]) => {
  // Write here tests
  let daiToken, dappToken, tokenFarm;
  before(async () => {
    // Load contracts
    daiToken = await DaiToken.new();
    dappToken = await DappToken.new();
    tokenFarm = await TokenFarm.new(dappToken.address, daiToken.address);

    // Transfer all dapp token to farm
    await dappToken.transfer(tokenFarm.address, tokens("1000000"));

    // Send tokens to investor
    await daiToken.transfer(investor, tokens("100"), { from: owner });
  });

  describe("Mock DAI deployment", async () => {
    it("has a name", async () => {
      let daiToken = await DaiToken.new();
      const name = await daiToken.name();
      assert.equal(name, "Mock DAI Token");
    });
  });
});
