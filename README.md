# Cloudbric-Contracts-Klaytn

## Requirements

* Node.js
  Visit https://nodejs.org/en/ and download Node.js.

* Truffle
  Install Truffle globally
  `sudo npm install -g truffle@5`

## TEST using Truffle

If you want to test our contracts using truffle, follow steps below.

1. Install Ganache or Klaytn Baobab testnet.
   https://www.trufflesuite.com/ganache

2. You should setup your own `.secret.json` file. check our `.secret_dummy.json` file.

3. Use Truffle console to test contracts.

   ```
   # Assuming you are in $HOME/Cloudbric-Contracts-Klaytn/.
   $ truffle console
   
   # Verify that the compilation works
   truffle(development)> compile
   # Verify that the features work
   truffle(development)> test
   ```