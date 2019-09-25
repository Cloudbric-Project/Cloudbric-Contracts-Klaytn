const Cloudbric = artifacts.require("./Cloudbric.sol");
const fs = require('fs');
const secret = fs.readFileSync('../.secret.json', 'utf-8');
const parsedSecret = JSON.parse(secret);
const admin = parsedSecret.baobab.admin.address;

module.exports = function (deployer) {
    deployer.deploy(Cloudbric, admin)
        .then(() => {
            if (Cloudbric._json) {
                fs.writeFile(
                    'deployedAbiOfCloudbric',
                    JSON.stringify(Cloudbric._json, 2),
                    (err) => {
                        if (err) throw err
                        console.log(`The abi of ${Cloudbric._json.contractName} is recorded on deployedAbiOfCloudbric file`)
                    }
                )
            }
            fs.writeFile(
                'deployedAddressOfCloudbric',
                Cloudbric.address,
                (err) => {
                    if (err) throw err
                    console.log(`The deployed contract address * ${Cloudbric.address}`)
                }
            )
        })
}