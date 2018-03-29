// 17 Mar 2018 08:45 AEDT from CMC and https://ethgasstation.info/
var ethPriceUSD = 611.45;
var defaultGasPrice = web3.toWei(2, "gwei");

// -----------------------------------------------------------------------------
// Accounts
// -----------------------------------------------------------------------------
var accounts = [];
var accountNames = {};

addAccount(eth.accounts[0], "Account #0 - Miner");
addAccount(eth.accounts[1], "Account #1 - Contract Owner");
addAccount(eth.accounts[2], "Account #2");
addAccount(eth.accounts[3], "Account #3");
// addAccount(eth.accounts[4], "Account #4");
// addAccount(eth.accounts[5], "Account #5");
// addAccount(eth.accounts[6], "Account #6");
// addAccount(eth.accounts[7], "Account #7");
// addAccount(eth.accounts[8], "Account #8");
// addAccount(eth.accounts[9], "Account #9");
// addAccount(eth.accounts[10], "Account #10");
// addAccount(eth.accounts[11], "Account #11");
// addAccount(eth.accounts[12], "Account #12");
// addAccount(eth.accounts[13], "Account #13");
// addAccount(eth.accounts[14], "Account #14");
// addAccount(eth.accounts[15], "Account #15");

var minerAccount = eth.accounts[0];
var contractOwnerAccount = eth.accounts[1];
var account2 = eth.accounts[2];
var account3 = eth.accounts[3];
var account4 = eth.accounts[4];
var account5 = eth.accounts[5];
var account6 = eth.accounts[6];
var account7 = eth.accounts[7];
var account8 = eth.accounts[8];
var account9 = eth.accounts[9];

var baseBlock = eth.blockNumber;

function unlockAccounts(password) {
  for (var i = 0; i < eth.accounts.length && i < accounts.length && i < 13; i++) {
    personal.unlockAccount(eth.accounts[i], password, 100000);
    if (i > 0 && eth.getBalance(eth.accounts[i]) == 0) {
      personal.sendTransaction({from: eth.accounts[0], to: eth.accounts[i], value: web3.toWei(1000000, "ether")});
    }
  }
  while (txpool.status.pending > 0) {
  }
  baseBlock = eth.blockNumber;
}

function addAccount(account, accountName) {
  accounts.push(account);
  accountNames[account] = accountName;
}


// -----------------------------------------------------------------------------
// Token Contract
// -----------------------------------------------------------------------------
var tokenContractAddress = null;
var tokenContractAbi = null;

function addTokenContractAddressAndAbi(address, tokenAbi) {
  tokenContractAddress = address;
  tokenContractAbi = tokenAbi;
}

var addresses = {};
var abis = {};
var tokens = {};
var decimals = {};
var tokenCodes = ["gem", "gov", "sai", "sin", "skr"];
var fromBlock = {};

function addAddressAndAbi(key, address, abi) {
  addresses[key] = address;
  abis[key] = abi;
  fromBlock[key] = 0;
}


// -----------------------------------------------------------------------------
// Account ETH and token balances
// -----------------------------------------------------------------------------
function printBalances() {
  var tokenTotals = {};
  var separator = "-- ------------------------------------------ ---------------------------";
  var header = " # Account                                                      ETHChange";
  tokenCodes.forEach(function(t) {
    separator = separator + " ------------------------------";
    header = header + "                            " + t.toUpperCase();
    tokens[t] = addresses[t] == null || abis[t] == null ? null : web3.eth.contract(abis[t]).at(addresses[t]);
    decimals[t] = 18; // tokens[t] == null ? 18 : tokens[t].decimals();
    tokenTotals[t] = new BigNumber(0);
  });
  separator = separator + " ---------------------------";
  header = header + " Name";
  console.log("RESULT: " + header);
  console.log("RESULT: " + separator);
  var i = 0;
  accounts.forEach(function(e) {
    var etherBalanceBaseBlock = eth.getBalance(e, baseBlock);
    var etherBalance = web3.fromWei(eth.getBalance(e).minus(etherBalanceBaseBlock), "ether");
    var line = pad2(i) + " " + e  + " " + pad(etherBalance);
    tokenCodes.forEach(function(t) {
      var tokenBalance = tokens[t] == null ? new BigNumber(0) : tokens[t].balanceOf(e).shift(-decimals[t]);
      tokenTotals[t] = tokenTotals[t].add(tokenBalance);
      line = line + " " + padToken(tokenBalance, decimals[t]);
    });
    line = line + " " + accountNames[e];
    console.log("RESULT: " + line);
    i++;
  });
  console.log("RESULT: " + separator);
  var line = "                                                                         ";
  tokenCodes.forEach(function(t) {
    line = line + " " + padToken(tokenTotals[t], decimals[t]);
  });
  console.log("RESULT: " + line);
  console.log("RESULT: " + separator);
  console.log("RESULT: ");
}

function pad2(s) {
  var o = s.toFixed(0);
  while (o.length < 2) {
    o = " " + o;
  }
  return o;
}

function pad(s) {
  var o = s.toFixed(18);
  while (o.length < 27) {
    o = " " + o;
  }
  return o;
}

function padToken(s, decimals) {
  var o = s.toFixed(decimals);
  var l = parseInt(decimals)+12;
  while (o.length < l) {
    o = " " + o;
  }
  return o;
}


// -----------------------------------------------------------------------------
// Transaction status
// -----------------------------------------------------------------------------
function printTxData(name, txId) {
  var tx = eth.getTransaction(txId);
  var txReceipt = eth.getTransactionReceipt(txId);
  var gasPrice = tx.gasPrice;
  var gasCostETH = tx.gasPrice.mul(txReceipt.gasUsed).div(1e18);
  var gasCostUSD = gasCostETH.mul(ethPriceUSD);
  var block = eth.getBlock(txReceipt.blockNumber);
  console.log("RESULT: " + name + " status=" + txReceipt.status + (txReceipt.status == 0 ? " Failure" : " Success") + " gas=" + tx.gas +
    " gasUsed=" + txReceipt.gasUsed + " costETH=" + gasCostETH + " costUSD=" + gasCostUSD +
    " @ ETH/USD=" + ethPriceUSD + " gasPrice=" + web3.fromWei(gasPrice, "gwei") + " gwei block=" + 
    txReceipt.blockNumber + " txIx=" + tx.transactionIndex + " txId=" + txId +
    " @ " + block.timestamp + " " + new Date(block.timestamp * 1000).toUTCString());
}

function assertEtherBalance(account, expectedBalance) {
  var etherBalance = web3.fromWei(eth.getBalance(account), "ether");
  if (etherBalance == expectedBalance) {
    console.log("RESULT: OK " + account + " has expected balance " + expectedBalance);
  } else {
    console.log("RESULT: FAILURE " + account + " has balance " + etherBalance + " <> expected " + expectedBalance);
  }
}

function failIfTxStatusError(tx, msg) {
  var status = eth.getTransactionReceipt(tx).status;
  if (status == 0) {
    console.log("RESULT: FAIL " + msg);
    return 0;
  } else {
    console.log("RESULT: PASS " + msg);
    return 1;
  }
}

function passIfTxStatusError(tx, msg) {
  var status = eth.getTransactionReceipt(tx).status;
  if (status == 1) {
    console.log("RESULT: FAIL " + msg);
    return 0;
  } else {
    console.log("RESULT: PASS " + msg);
    return 1;
  }
}

function gasEqualsGasUsed(tx) {
  var gas = eth.getTransaction(tx).gas;
  var gasUsed = eth.getTransactionReceipt(tx).gasUsed;
  return (gas == gasUsed);
}

function failIfGasEqualsGasUsed(tx, msg) {
  var gas = eth.getTransaction(tx).gas;
  var gasUsed = eth.getTransactionReceipt(tx).gasUsed;
  if (gas == gasUsed) {
    console.log("RESULT: FAIL " + msg);
    return 0;
  } else {
    console.log("RESULT: PASS " + msg);
    return 1;
  }
}

function passIfGasEqualsGasUsed(tx, msg) {
  var gas = eth.getTransaction(tx).gas;
  var gasUsed = eth.getTransactionReceipt(tx).gasUsed;
  if (gas == gasUsed) {
    console.log("RESULT: PASS " + msg);
    return 1;
  } else {
    console.log("RESULT: FAIL " + msg);
    return 0;
  }
}

function failIfGasEqualsGasUsedOrContractAddressNull(contractAddress, tx, msg) {
  if (contractAddress == null) {
    console.log("RESULT: FAIL " + msg);
    return 0;
  } else {
    var gas = eth.getTransaction(tx).gas;
    var gasUsed = eth.getTransactionReceipt(tx).gasUsed;
    if (gas == gasUsed) {
      console.log("RESULT: FAIL " + msg);
      return 0;
    } else {
      console.log("RESULT: PASS " + msg);
      return 1;
    }
  }
}


//-----------------------------------------------------------------------------
// Wait one block
//-----------------------------------------------------------------------------
function waitOneBlock(oldCurrentBlock) {
  while (eth.blockNumber <= oldCurrentBlock) {
  }
  console.log("RESULT: Waited one block");
  console.log("RESULT: ");
  return eth.blockNumber;
}


//-----------------------------------------------------------------------------
// Pause for {x} seconds
//-----------------------------------------------------------------------------
function pause(message, addSeconds) {
  var time = new Date((parseInt(new Date().getTime()/1000) + addSeconds) * 1000);
  console.log("RESULT: Pausing '" + message + "' for " + addSeconds + "s=" + time + " now=" + new Date());
  while ((new Date()).getTime() <= time.getTime()) {
  }
  console.log("RESULT: Paused '" + message + "' for " + addSeconds + "s=" + time + " now=" + new Date());
  console.log("RESULT: ");
}


//-----------------------------------------------------------------------------
//Wait until some unixTime + additional seconds
//-----------------------------------------------------------------------------
function waitUntil(message, unixTime, addSeconds) {
  var t = parseInt(unixTime) + parseInt(addSeconds) + parseInt(1);
  var time = new Date(t * 1000);
  console.log("RESULT: Waiting until '" + message + "' at " + unixTime + "+" + addSeconds + "s=" + time + " now=" + new Date());
  while ((new Date()).getTime() <= time.getTime()) {
  }
  console.log("RESULT: Waited until '" + message + "' at at " + unixTime + "+" + addSeconds + "s=" + time + " now=" + new Date());
  console.log("RESULT: ");
}


//-----------------------------------------------------------------------------
//Wait until some block
//-----------------------------------------------------------------------------
function waitUntilBlock(message, block, addBlocks) {
  var b = parseInt(block) + parseInt(addBlocks);
  console.log("RESULT: Waiting until '" + message + "' #" + block + "+" + addBlocks + "=#" + b + " currentBlock=" + eth.blockNumber);
  while (eth.blockNumber <= b) {
  }
  console.log("RESULT: Waited until '" + message + "' #" + block + "+" + addBlocks + "=#" + b + " currentBlock=" + eth.blockNumber);
  console.log("RESULT: ");
}


//-----------------------------------------------------------------------------
// Token Contract
//-----------------------------------------------------------------------------
var tokenFromBlock = 0;
function printTokenContractDetails() {
  console.log("RESULT: tokenContractAddress=" + tokenContractAddress);
  if (tokenContractAddress != null && tokenContractAbi != null) {
    var contract = eth.contract(tokenContractAbi).at(tokenContractAddress);
    var decimals = contract.decimals();
    var symbol = contract.symbol();
    if (symbol.substring(0, 2) == "0x") {
      symbol = web3.toUtf8(symbol);
    }
    var name = contract.name();
    if (name.substring(0, 2) == "0x") {
      name = web3.toUtf8(name);
    }
    console.log("RESULT: token.symbol=" + symbol);
    console.log("RESULT: token.name=" + name);
    console.log("RESULT: token.decimals=" + decimals);
    console.log("RESULT: token.totalSupply=" + contract.totalSupply().shift(-decimals));

    var latestBlock = eth.blockNumber;
    var i;

    if (name == "WETH") {
      var depositEvents = contract.Deposit({}, { fromBlock: tokenFromBlock, toBlock: latestBlock });
      i = 0;
      depositEvents.watch(function (error, result) {
        console.log("RESULT: Deposit " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
      });
      depositEvents.stopWatching();

      var withdrawalEvents = contract.Withdrawal({}, { fromBlock: tokenFromBlock, toBlock: latestBlock });
      i = 0;
      withdrawalEvents.watch(function (error, result) {
        console.log("RESULT: Withdrawal " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
      });
      withdrawalEvents.stopWatching();
    }

    var approvalEvents = contract.Approval({}, { fromBlock: tokenFromBlock, toBlock: latestBlock });
    i = 0;
    approvalEvents.watch(function (error, result) {
      console.log("RESULT: Approval " + i++ + " #" + result.blockNumber + " src=" + result.args.src +
        " guy=" + result.args.guy + " wad=" + result.args.wad.shift(-decimals));
    });
    approvalEvents.stopWatching();

    var transferEvents = contract.Transfer({}, { fromBlock: tokenFromBlock, toBlock: latestBlock });
    i = 0;
    transferEvents.watch(function (error, result) {
      console.log("RESULT: Transfer " + i++ + " #" + result.blockNumber + ": src=" + result.args.src + " dst=" + result.args.dst +
        " wad=" + result.args.wad.shift(-decimals));
    });
    transferEvents.stopWatching();

    tokenFromBlock = latestBlock + 1;
  }
}


// -----------------------------------------------------------------------------
// Adm
// -----------------------------------------------------------------------------
function printAdmContractDetails() {
  var key = 'adm';
  console.log("RESULT: addresses['" + key + "']=" + addresses[key]);
  // console.log("RESULT: abis['" + key + "']=" + JSON.stringify(abis[key]));
  if (addresses[key] != null && abis[key] != null) {
    var contract = eth.contract(abis[key]).at(addresses[key]);
    console.log("RESULT: adm.owner=" + contract.owner());
    console.log("RESULT: adm.authority=" + contract.authority());
    console.log("RESULT: adm.GOV=" + contract.GOV());
    console.log("RESULT: adm.IOU=" + contract.IOU());
    console.log("RESULT: adm.hat=" + contract.hat());
    console.log("RESULT: adm.MAX_YAYS=" + contract.MAX_YAYS());

    var latestBlock = eth.blockNumber;
    var i;

    var etchEvents = contract.Etch({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    etchEvents.watch(function (error, result) {
      console.log("RESULT: Etch " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    etchEvents.stopWatching();

    var logSetAuthorityEvents = contract.LogSetAuthority({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    logSetAuthorityEvents.watch(function (error, result) {
      console.log("RESULT: LogSetAuthority " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    logSetAuthorityEvents.stopWatching();

    var logSetOwnerEvents = contract.LogSetOwner({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    logSetOwnerEvents.watch(function (error, result) {
      console.log("RESULT: LogSetOwner " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    logSetOwnerEvents.stopWatching();

    var logNoteEvents = contract.LogNote({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    logNoteEvents.watch(function (error, result) {
      console.log("RESULT: LogNote " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    logNoteEvents.stopWatching();

    fromBlock[key] = latestBlock + 1;
  }
}


// -----------------------------------------------------------------------------
// Tub
// -----------------------------------------------------------------------------
function printTubContractDetails() {
  var key = 'tub';
  console.log("RESULT: addresses['" + key + "']=" + addresses[key]);
  // console.log("RESULT: abis['" + key + "']=" + JSON.stringify(abis[key]));
  if (addresses[key] != null && abis[key] != null) {
    var contract = eth.contract(abis[key]).at(addresses[key]);
    console.log("RESULT: adm.owner=" + contract.owner());
    console.log("RESULT: adm.authority=" + contract.authority());
    // console.log("RESULT: adm.GOV=" + contract.GOV());
    // console.log("RESULT: adm.IOU=" + contract.IOU());
    // console.log("RESULT: adm.hat=" + contract.hat());
    // console.log("RESULT: adm.MAX_YAYS=" + contract.MAX_YAYS());

    var latestBlock = eth.blockNumber;
    var i;

    var logSetAuthorityEvents = contract.LogSetAuthority({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    logSetAuthorityEvents.watch(function (error, result) {
      console.log("RESULT: LogSetAuthority " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    logSetAuthorityEvents.stopWatching();

    var logSetOwnerEvents = contract.LogSetOwner({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    logSetOwnerEvents.watch(function (error, result) {
      console.log("RESULT: LogSetOwner " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    logSetOwnerEvents.stopWatching();

    var logNoteEvents = contract.LogNote({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    logNoteEvents.watch(function (error, result) {
      console.log("RESULT: LogNote " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    logNoteEvents.stopWatching();

    var logNewCupEvents = contract.LogNewCup({}, { fromBlock: fromBlock[key], toBlock: latestBlock });
    i = 0;
    logNewCupEvents.watch(function (error, result) {
      console.log("RESULT: LogNewCup " + i++ + " #" + result.blockNumber + " " + JSON.stringify(result.args));
    });
    logNewCupEvents.stopWatching();

    fromBlock[key] = latestBlock + 1;
  }
}

