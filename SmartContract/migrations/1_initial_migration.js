var PePointContract = artifacts.require("./PePointContract.sol");

module.exports = function(deployer) {
  deployer.deploy(PePointContract);
};
