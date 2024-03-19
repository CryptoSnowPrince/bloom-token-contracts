require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

// Config from environment
const mnemonicPhrase = process.env.MNEMONIC;
const privateKey = process.env.PRIVATE_KEY;
const mnemonicPassword = process.env.MNEMONIC_PASSWORD;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: '0.8.7',
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ]
  },
  defaultNetwork: "bsctestnet",
  networks: {
    bsctestnet: {
      url: 'https://bsc-testnet-rpc.publicnode.com',
      accounts: {
        mnemonic: mnemonicPhrase,
        path: 'm/44\'/60\'/0\'/0',
        initialIndex: 0,
        count: 1,
        passphrase: mnemonicPassword,
      },
      network_id: '*',
    },
    bsc: {
      url: 'https://binance.llamarpc.com',
      accounts: {
        mnemonic: mnemonicPhrase,
        path: 'm/44\'/60\'/0\'/0',
        initialIndex: 0,
        count: 1,
        passphrase: mnemonicPassword,
      },
      network_id: '*',
    },
  },
  paths: {
    sources: './contracts',
    tests: './test',
    cache: './cache',
    artifacts: './artifacts',
  },
  mocha: {
    timeout: 0,
  },
  etherscan: {
    apiKey: {
      bsctestnet: "HDCD9C44C7YRZGHE48WGHGUZW5DU1R2WKT",
      bsc: "HDCD9C44C7YRZGHE48WGHGUZW5DU1R2WKT",
    },
    customChains: [
      {
        network: "bsctestnet",
        chainId: 97,
        urls: {
          apiURL: "https://api-testnet.bscscan.com/api",
          browserURL: "https://testnet.bscscan.com"
        }
      },
      {
        network: "bsc",
        chainId: 56,
        urls: {
          apiURL: "https://api.bscscan.com/api",
          browserURL: "https://bscscan.com"
        }
      },
    ]
  },
};
