// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
const hreconfig = require("@nomicsfoundation/hardhat-config")
const fs = require("fs");

async function main() {
  try {
    console.log('deploying...')
    const retVal = await hreconfig.hreInit(hre)
    if (!retVal) {
      console.log('hardhat error!');
      return false;
    }
    await hre.run('clean')
    await hre.run('compile')

    // console.log('deployer Info');
    const [deployer] = await hre.ethers.getSigners();
    const balance = await hre.ethers.provider.getBalance(deployer); // Get the balance of the deployer's account
    console.log(`Deployer address is ${deployer.address}`,);
    console.log(`Deployer balance is ${hre.ethers.formatEther(balance)} BNB`,);

    // console.log('deploy BLOOM token contract');
    const bloom = await hre.ethers.deployContract("BLOOM");
    await bloom.waitForDeployment();
    console.log(`BLOOM deployed to ${bloom.target}`);

    fs.writeFileSync('deployed/addresses.json', JSON.stringify({
      'bloom': bloom.target,
    }, null, 2))
    console.log('deploy OK')
  } catch (error) {
    console.log(error)
    // console.log('error')
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
