

/** @type import('hardhat/config').HardhatUserConfig */
require('@nomiclabs/hardhat-waffle')
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();
const GOERLI_URL = 'https://goerli.infura.io/v3/939460b989b94e17a47862f19242a1e6'
const DEPLOYER_PRIVATE_KEY = process.env.DEPLOYER_PRIVATE_KEY
const ALCHEMY_API_KEY = "segRwns6xqSvXI0jZE-WEDFbdtbLHZPD";
module.exports = {
  solidity: "0.8.17",
  paths: {
    artifacts: './frontend/src/artifacts',
  },
  networks: {
    hardhat: {
      chainId: 1337,
    },
    goerli: {
      // url: `${GOERLI_URL}`,
      url:`https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [`${DEPLOYER_PRIVATE_KEY}`],
    },
  },
  etherscan:{
    apiKey:"34QZRTHPHPWE1FENPC13AADQUBIH8CN215",
  }
};
