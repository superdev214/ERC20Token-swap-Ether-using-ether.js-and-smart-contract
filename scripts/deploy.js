// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");


async function main() {
  const DEX = await ethers.getContractFactory("DEXToken");
  const args = [
    "SwapToken Protocol", "swToken", "10000000"
  ];
  const dex = await DEX.deploy("10000000000000000000000000000000000000000000");
  await dex.deployed();

  console.log("dex deployed to:",dex.address);
  //Verify code
   setTimeout(async() => {
    await run("verify:verify",{
      address:dex.address,
      constructorArguments:["10000000000000000000000000000000000000000000"],
      contract:"contracts/DexToken.sol:DEXToken"
    });
  },100000);
  //0xE6C88da534705C196DFaDbBae89950efC6f335B8 // success there is error while I have

/*const sleep = (waitTimeInMs) => new Promise(resolve => setTimeout(resolve, waitTimeInMs));
module.exports = {
  sleep
}*/
}
//npx hardhat run --network goerli scripts/deploy.js
//npx hardhat verify --network goerli --contract contracts/Token.sol:DEX 0xfA1270a04F4954e2Cd497d57d28D1Fb3F91E0a76 
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
