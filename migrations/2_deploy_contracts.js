const Cloudbric = artifacts.require("./Cloudbric.sol");

module.exports = function(deployer, network, accounts) {
    const owner = accounts[0];
    const admin = accounts[1];

    var cloudbric = null;

    deployer.deploy(
        Cloudbric, admin, {from: owner}
    ).then(function() {
        return Cloudbric.deployed();    
    }).then(function(instance) {
        cloudbric = instance;
        // interact wiht Cloudbric contract
        console.log(`Cloudbric deployed at ${cloudbric.address}`);
    });
}