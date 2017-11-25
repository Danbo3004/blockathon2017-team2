/**
 * Created by navnahn on 11/25/17.
 */
"use strict";

const express = require('express');
const app = express();

app.get('/', function (req, res) {
    res.send('Hello World!')
});

app.get('/')

app.listen(3000, function() {
    console.log('Example app listening on port 3000!')


    var Web3 = require('web3');
    var Wallet = require('ethereumjs-wallet');
    // var wallet = Wallet.generate();
    // console.log('privateKey:   0x' + wallet.getPrivateKey().toString('hex'));
    // console.log('address:      0x' + wallet.getAddress().toString('hex'));
    // console.log('publicKey:    0x' + wallet.getPublicKey().toString('hex'));



    var privKey = new Buffer('a4e7bdede2be7e801f763ab6c18daf8f0fd3aae5fd2064997b79ac2bb18cbba5', 'hex');
    var wallet = Wallet.fromPrivateKey(privKey);


//     var contractAbi = eth.contract(AbiOfContract);
//     var myContract = contractAbi.at(contractAddress);
// // suppose you want to call a function named myFunction of myContract
//     var getData = myContract.myFunction.getData(function parameters);
// //finally paas this data parameter to send Transaction
//     web3.eth.sendTransaction({to:Contractaddress, from:Accountaddress, data: getData});




    var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
    var codeABI = your_contract_abi_object;
    var address = your_contract_address;
    var contract = web3.eth.contract(codeABI).at(address) contract.constFoo(some_params);
    contract.foo(params, {from: accounts[0], value: web3.toWei(1), gas: 500000});s
    contract.foo.sendTransaction(params, {from: accounts[0], value: web3.toWei(1), gas: 500000});



    //console.log(wallet.toV3('your_password'))
});

