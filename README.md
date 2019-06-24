# Cloudbric-Contracts-Klaytn

## Requirements

* Node.js
  Visit https://nodejs.org/en/ and download Node.js.

* Truffle
  Install Truffle either 
	1) globally using npm by executing the following command:
  `sudo npm install -g truffle@4.1.15` or
  2) locally, *i.e.,* in your local directory, by executing the following:

  ```
  # Assuming you are in $HOME/Cloudbric-Contracts-Klaytn/.
  $ npm install truffle@4.1.15
  $ ln -s node_modules/truffle/build/cli.bundled.js truffle
  $ export PATH=`pwd`:$PATH
  ```

## TEST using Truffle

If you want to test our contracts using truffle, follow steps below.

1. Install Ganache and execute.
   https://www.trufflesuite.com/ganache

2. Use Truffle console to test contracts.

   ```
   # Assuming you are in $HOME/Cloudbric-Contracts-Klaytn/.
   $ truffle console
   
   # Verify that the compilation works
   truffle(development)> compile
   # Verify that the features work
   truffle(development)> test
   ```

