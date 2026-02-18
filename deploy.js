const hre = require("hardhat");

async function main() {
  const Token = await hre.ethers.getContractFactory("MockToken");
  const token = await Token.deploy();

  await token.waitForDeployment();

  const Staking = await hre.ethers.getContractFactory("Staking");
  const staking = await Staking.deploy(await token.getAddress());

  await staking.waitForDeployment();

  console.log("Token:", await token.getAddress());
  console.log("Staking:", await staking.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
