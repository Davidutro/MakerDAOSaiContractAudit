#!/bin/bash
# ----------------------------------------------------------------------------------------------
# Testing the smart contract
#
# Enjoy. (c) BokkyPooBah / Bok Consulting Pty Ltd 2018. The MIT Licence.
# ----------------------------------------------------------------------------------------------

source settings
echo "---------- Settings ----------" | tee $TEST1OUTPUT
cat ./settings | tee -a $TEST1OUTPUT

CURRENTTIME=`date +%s`
CURRENTTIMES=`date -r $CURRENTTIME -u`
START_DATE=`echo "$CURRENTTIME+30" | bc`
START_DATE_S=`date -r $START_DATE -u`
END_DATE=`echo "$CURRENTTIME+60*1+30" | bc`
END_DATE_S=`date -r $END_DATE -u`
echo "" | tee -a $TEST1OUTPUT

echo "---------- Variables ----------" | tee -a $TEST1OUTPUT
printf "CURRENTTIME='$CURRENTTIME' '$CURRENTTIMES'\n" | tee -a $TEST1OUTPUT
printf "START_DATE='$START_DATE' '$START_DATE_S'\n" | tee -a $TEST1OUTPUT
printf "END_DATE='$END_DATE' '$END_DATE_S'\n" | tee -a $TEST1OUTPUT
echo "" | tee -a $TEST1OUTPUT

echo "---------- Copy Files ----------" | tee -a $TEST1OUTPUT
# Make copy of SOL file and modify start and end times ---
rm -f $CONTRACTS/*.sol
rmdir $CONTRACTS
mkdir $CONTRACTS
cp -v $SOURCEDIR/*.sol $CONTRACTS/
cp -v modifiedContracts/*.sol $CONTRACTS/
echo "" | tee -a $TEST1OUTPUT

echo "---------- Modifications To Files ----------" | tee -a $TEST1OUTPUT
# --- Modify parameters ---
#`perl -pi -e "s/ROUND_DURATION \= 3 days;/ROUND_DURATION \= 10 seconds;/" *.sol`

for FILE in $CONTRACTS/*.sol
do
  FILENAME=`basename $FILE`
  DIFFS1=`diff $SOURCEDIR/$FILENAME $CONTRACTS/$FILENAME`
  echo "--- Differences $SOURCEDIR/$FILENAME $CONTRACTS/$FILENAME ---" | tee -a $TEST1OUTPUT
  echo "$DIFFS1" | tee -a $TEST1OUTPUT
done
echo "" | tee -a $TEST1OUTPUT

echo "---------- Compile Files ----------" | tee -a $TEST1OUTPUT
rm -f $JSFILES/*.js
rmdir $JSFILES
mkdir $JSFILES

solc_0.4.18 --version | tee -a $TEST1OUTPUT
echo "var admOutput=`solc_0.4.18 --optimize --pretty-json --combined-json abi,bin,interface $CONTRACTS/$ADMSOL`;" > $JSFILES/$ADMJS
echo "var fabOutput=`solc_0.4.18 --optimize --pretty-json --combined-json abi,bin,interface $CONTRACTS/$FABSOL`;" > $JSFILES/$FABJS
echo "var gemOutput=`solc_0.4.18 --optimize --pretty-json --combined-json abi,bin,interface $CONTRACTS/$GEMSOL`;" > $JSFILES/$GEMJS
echo "var govOutput=`solc_0.4.18 --optimize --pretty-json --combined-json abi,bin,interface $CONTRACTS/$GOVSOL`;" > $JSFILES/$GOVJS
echo "var pipOutput=`solc_0.4.18 --optimize --pretty-json --combined-json abi,bin,interface $CONTRACTS/$PIPSOL`;" > $JSFILES/$PIPJS
echo "var pepOutput=`solc_0.4.18 --optimize --pretty-json --combined-json abi,bin,interface $CONTRACTS/$PEPSOL`;" > $JSFILES/$PEPJS
echo "var pitOutput=`solc_0.4.18 --optimize --pretty-json --combined-json abi,bin,interface $CONTRACTS/$PITSOL`;" > $JSFILES/$PITJS


geth --verbosity 3 attach $GETHATTACHPOINT << EOF | tee -a $TEST1OUTPUT
loadScript("$JSFILES/$ADMJS");
loadScript("$JSFILES/$FABJS");
loadScript("$JSFILES/$GEMJS");
loadScript("$JSFILES/$GOVJS");
loadScript("$JSFILES/$PIPJS");
loadScript("$JSFILES/$PEPJS");
loadScript("$JSFILES/$PITJS");
loadScript("functions.js");

var admAbi = JSON.parse(admOutput.contracts["$CONTRACTS/$ADMSOL:$ADMNAME"].abi);
var admBin = "0x" + admOutput.contracts["$CONTRACTS/$ADMSOL:$ADMNAME"].bin;
var fabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$FABNAME"].abi);
var fabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:$FABNAME"].bin;
var gemFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:GemFab"].abi);
var gemFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:GemFab"].bin;
var voxFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:VoxFab"].abi);
var voxFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:VoxFab"].bin;
var tapFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:TapFab"].abi);
var tapFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:TapFab"].bin;
var tubFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:TubFab"].abi);
var tubFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:TubFab"].bin;
var topFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:TopFab"].abi);
var topFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:TopFab"].bin;
var momFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:MomFab"].abi);
var momFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:MomFab"].bin;
var dadFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:DadFab"].abi);
var dadFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:DadFab"].bin;
var daiFabAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:DaiFab"].abi);
var daiFabBin = "0x" + fabOutput.contracts["$CONTRACTS/$FABSOL:DaiFab"].bin;
var gemAbi = JSON.parse(gemOutput.contracts["$CONTRACTS/$GEMSOL:$GEMNAME"].abi);
var gemBin = "0x" + gemOutput.contracts["$CONTRACTS/$GEMSOL:$GEMNAME"].bin;
var govAbi = JSON.parse(govOutput.contracts["$CONTRACTS/$GOVSOL:$GOVNAME"].abi);
var govBin = "0x" + govOutput.contracts["$CONTRACTS/$GOVSOL:$GOVNAME"].bin;
var pipAbi = JSON.parse(pipOutput.contracts["$CONTRACTS/$PIPSOL:$PIPNAME"].abi);
var pipBin = "0x" + pipOutput.contracts["$CONTRACTS/$PIPSOL:$PIPNAME"].bin;
var pepAbi = JSON.parse(pepOutput.contracts["$CONTRACTS/$PEPSOL:$PEPNAME"].abi);
var pepBin = "0x" + pepOutput.contracts["$CONTRACTS/$PEPSOL:$PEPNAME"].bin;
var pitAbi = JSON.parse(pitOutput.contracts["$CONTRACTS/$PITSOL:$PITNAME"].abi);
var pitBin = "0x" + pitOutput.contracts["$CONTRACTS/$PITSOL:$PITNAME"].bin;

var saiAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$SAINAME"].abi);
var sinAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$SAINAME"].abi);
var skrAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$SKRNAME"].abi);
var voxAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$VOXNAME"].abi);
var tubAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$TUBNAME"].abi);
var tapAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$TAPNAME"].abi);
var topAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$TOPNAME"].abi);
var momAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$MOMNAME"].abi);
var dadAbi = JSON.parse(fabOutput.contracts["$CONTRACTS/$FABSOL:$DADNAME"].abi);

// console.log("DATA: var admAbi=" + JSON.stringify(admAbi) + ";");
// console.log("DATA: admBin=" + JSON.stringify(admBin));
// console.log("DATA: var fabAbi=" + JSON.stringify(fabAbi) + ";");
// console.log("DATA: fabBin=" + JSON.stringify(fabBin));
// console.log("DATA: var gemFabAbi=" + JSON.stringify(gemFabAbi) + ";");
// console.log("DATA: gemFabBin=" + JSON.stringify(gemFabBin));
// console.log("DATA: var voxFabAbi=" + JSON.stringify(voxFabAbi) + ";");
// console.log("DATA: voxFabBin=" + JSON.stringify(voxFabBin));
// console.log("DATA: var tapFabAbi=" + JSON.stringify(tapFabAbi) + ";");
// console.log("DATA: tapFabBin=" + JSON.stringify(tapFabBin));
// console.log("DATA: var tubFabAbi=" + JSON.stringify(tubFabAbi) + ";");
// console.log("DATA: tubFabBin=" + JSON.stringify(tubFabBin));
// console.log("DATA: var topFabAbi=" + JSON.stringify(topFabAbi) + ";");
// console.log("DATA: topFabBin=" + JSON.stringify(topFabBin));
// console.log("DATA: var momFabAbi=" + JSON.stringify(momFabAbi) + ";");
// console.log("DATA: momFabBin=" + JSON.stringify(momFabBin));
// console.log("DATA: var dadFabAbi=" + JSON.stringify(dadFabAbi) + ";");
// console.log("DATA: dadFabBin=" + JSON.stringify(dadFabBin));
// console.log("DATA: var daiFabAbi=" + JSON.stringify(daiFabAbi) + ";");
// console.log("DATA: daiFabBin=" + JSON.stringify(daiFabBin));
// console.log("DATA: var gemAbi=" + JSON.stringify(gemAbi) + ";");
// console.log("DATA: gemBin=" + JSON.stringify(gemBin));
// console.log("DATA: var govAbi=" + JSON.stringify(govAbi) + ";");
// console.log("DATA: govBin=" + JSON.stringify(govBin));
// console.log("DATA: var pipAbi=" + JSON.stringify(pipAbi) + ";");
// console.log("DATA: pipBin=" + JSON.stringify(pipBin));
// console.log("DATA: var pepAbi=" + JSON.stringify(pepAbi) + ";");
// console.log("DATA: pepBin=" + JSON.stringify(pepBin));
// console.log("DATA: var pitAbi=" + JSON.stringify(pitAbi) + ";");
// console.log("DATA: pitBin=" + JSON.stringify(pitBin));

// console.log("DATA: var saiAbi=" + JSON.stringify(saiAbi) + ";");
// console.log("DATA: var sinAbi=" + JSON.stringify(sinAbi) + ";");
// console.log("DATA: var skrAbi=" + JSON.stringify(skrAbi) + ";");
// console.log("DATA: var voxAbi=" + JSON.stringify(voxAbi) + ";");
// console.log("DATA: var tubAbi=" + JSON.stringify(tubAbi) + ";");
// console.log("DATA: var tapAbi=" + JSON.stringify(tapAbi) + ";");
// console.log("DATA: var topAbi=" + JSON.stringify(topAbi) + ";");
// console.log("DATA: var momAbi=" + JSON.stringify(momAbi) + ";");
// console.log("DATA: var dadAbi=" + JSON.stringify(dadAbi) + ";");

unlockAccounts("$PASSWORD");
printBalances();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var deployFabs1Message = "Deploy Fabs";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + deployFabs1Message + " ----------");
var gemFabContract = web3.eth.contract(gemFabAbi);
var gemFabTx = null;
var gemFabAddress = null;
var gemFab = gemFabContract.new({from: contractOwnerAccount, data: gemFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        gemFabTx = contract.transactionHash;
      } else {
        gemFabAddress = contract.address;
        // Only used for fab addAccount(gemFabAddress, "GemDaiFab");
        console.log("DATA: var gemFabAddress=\"" + gemFabAddress + "\";");
      }
    }
  }
);
var voxFabContract = web3.eth.contract(voxFabAbi);
var voxFabTx = null;
var voxFabAddress = null;
var voxFab = voxFabContract.new({from: contractOwnerAccount, data: voxFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        voxFabTx = contract.transactionHash;
      } else {
        voxFabAddress = contract.address;
        // Only used for fab addAccount(voxFabAddress, "VoxDaiFab");
        console.log("DATA: var voxFabAddress=\"" + voxFabAddress + "\";");
      }
    }
  }
);
var tapFabContract = web3.eth.contract(tapFabAbi);
var tapFabTx = null;
var tapFabAddress = null;
var tapFab = tapFabContract.new({from: contractOwnerAccount, data: tapFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        tapFabTx = contract.transactionHash;
      } else {
        tapFabAddress = contract.address;
        // Only used for fab addAccount(tapFabAddress, "TapDaiFab");
        console.log("DATA: var tapFabAddress=\"" + tapFabAddress + "\";");
      }
    }
  }
);
var tubFabContract = web3.eth.contract(tubFabAbi);
var tubFabTx = null;
var tubFabAddress = null;
var tubFab = tubFabContract.new({from: contractOwnerAccount, data: tubFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        tubFabTx = contract.transactionHash;
      } else {
        tubFabAddress = contract.address;
        // Only used for fab addAccount(tubFabAddress, "TubDaiFab");
        console.log("DATA: var tubFabAddress=\"" + tubFabAddress + "\";");
      }
    }
  }
);
var topFabContract = web3.eth.contract(topFabAbi);
var topFabTx = null;
var topFabAddress = null;
var topFab = topFabContract.new({from: contractOwnerAccount, data: topFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        topFabTx = contract.transactionHash;
      } else {
        topFabAddress = contract.address;
        // Only used for fab addAccount(topFabAddress, "TopDaiFab");
        console.log("DATA: var topFabAddress=\"" + topFabAddress + "\";");
      }
    }
  }
);
var momFabContract = web3.eth.contract(momFabAbi);
var momFabTx = null;
var momFabAddress = null;
var momFab = momFabContract.new({from: contractOwnerAccount, data: momFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        momFabTx = contract.transactionHash;
      } else {
        momFabAddress = contract.address;
        // Only used for fab addAccount(momFabAddress, "MomDaiFab");
        console.log("DATA: var momFabAddress=\"" + momFabAddress + "\";");
      }
    }
  }
);
var dadFabContract = web3.eth.contract(dadFabAbi);
var dadFabTx = null;
var dadFabAddress = null;
var dadFab = dadFabContract.new({from: contractOwnerAccount, data: dadFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        dadFabTx = contract.transactionHash;
      } else {
        dadFabAddress = contract.address;
        // Only used for fab addAccount(dadFabAddress, "DadDaiFab");
        console.log("DATA: var dadFabAddress=\"" + dadFabAddress + "\";");
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
var daiFabContract = web3.eth.contract(daiFabAbi);
var daiFabTx = null;
var daiFabAddress = null;
var daiFab = daiFabContract.new(gemFabAddress, voxFabAddress, tubFabAddress, tapFabAddress, topFabAddress, momFabAddress, dadFabAddress, 
  {from: contractOwnerAccount, data: daiFabBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        daiFabTx = contract.transactionHash;
      } else {
        daiFabAddress = contract.address;
        addAddressAndAbi('daiFab', daiFabAddress, daiFabAbi);
        // Only used for fab addAccount(daiFabAddress, "DaiFab");
        console.log("DATA: var daiFabAddress=\"" + daiFabAddress + "\";");
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(gemFabTx, deployFabs1Message + " - GemFab");
failIfTxStatusError(voxFabTx, deployFabs1Message + " - VoxFab");
failIfTxStatusError(tapFabTx, deployFabs1Message + " - TapFab");
failIfTxStatusError(tubFabTx, deployFabs1Message + " - TubFab");
failIfTxStatusError(topFabTx, deployFabs1Message + " - TopFab");
failIfTxStatusError(momFabTx, deployFabs1Message + " - MomFab");
failIfTxStatusError(dadFabTx, deployFabs1Message + " - DadFab");
failIfTxStatusError(daiFabTx, deployFabs1Message + " - DaiFab");
printTxData("gemFabAddress=" + gemFabAddress, gemFabTx);
printTxData("voxFabAddress=" + voxFabAddress, voxFabTx);
printTxData("tapFabAddress=" + tapFabAddress, tapFabTx);
printTxData("tubFabAddress=" + tubFabAddress, tubFabTx);
printTxData("topFabAddress=" + topFabAddress, topFabTx);
printTxData("momFabAddress=" + momFabAddress, momFabTx);
printTxData("dadFabAddress=" + dadFabAddress, dadFabTx);
printTxData("daiFabAddress=" + daiFabAddress, daiFabTx);
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var deployGemGovMessage = "Deploy Gem, Gov, Pip, Pep, Pit, Adm";
var govSymbol="0x4d4b520000000000000000000000000000000000000000000000000000000000";
var govName="0x4d616b6572000000000000000000000000000000000000000000000000000000";
var govTotalSupply="1000000000000000000000000";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + deployGemGovMessage + " ----------");
var gemContract = web3.eth.contract(gemAbi);
var gemTx = null;
var gemAddress = null;
var gem = gemContract.new({from: contractOwnerAccount, data: gemBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        gemTx = contract.transactionHash;
      } else {
        gemAddress = contract.address;
        addAccount(gemAddress, "Gem - Token '" + gem.symbol() + "' '" + gem.name() + "'");
        addAddressAndAbi('gem', gemAddress, gemAbi);
        console.log("DATA: var gemAddress=\"" + gemAddress + "\";");
      }
    }
  }
);
var govContract = web3.eth.contract(govAbi);
var govTx = null;
var govAddress = null;
var gov = govContract.new(govSymbol, {from: contractOwnerAccount, data: govBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        govTx = contract.transactionHash;
      } else {
        govAddress = contract.address;
        addAddressAndAbi('gov', govAddress, govAbi);
        console.log("DATA: var govAddress=\"" + govAddress + "\";");
      }
    }
  }
);
var pipContract = web3.eth.contract(pipAbi);
var pipTx = null;
var pipAddress = null;
var pip = pipContract.new({from: contractOwnerAccount, data: pipBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        pipTx = contract.transactionHash;
      } else {
        pipAddress = contract.address;
        addAccount(pipAddress, "Pip");
        addAddressAndAbi('pip', pipAddress, pipAbi);
        console.log("DATA: var pipAddress=\"" + pipAddress + "\";");
      }
    }
  }
);
var pepContract = web3.eth.contract(pepAbi);
var pepTx = null;
var pepAddress = null;
var pep = pepContract.new({from: contractOwnerAccount, data: pepBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        pepTx = contract.transactionHash;
      } else {
        pepAddress = contract.address;
        addAccount(pepAddress, "Pep");
        addAddressAndAbi('pep', pepAddress, pepAbi);
        console.log("DATA: var pepAddress=\"" + pepAddress + "\";");
      }
    }
  }
);
var pitContract = web3.eth.contract(pitAbi);
var pitTx = null;
var pitAddress = null;
var pit = pitContract.new({from: contractOwnerAccount, data: pitBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        pitTx = contract.transactionHash;
      } else {
        pitAddress = contract.address;
        addAccount(pitAddress, "Pit");
        addAddressAndAbi('pit', pitAddress, pitAbi);
        console.log("DATA: var pitAddress=\"" + pitAddress + "\";");
      }
    }
  }
);
var admContract = web3.eth.contract(admAbi);
var admTx = null;
var admAddress = null;
var adm = admContract.new({from: contractOwnerAccount, data: admBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        admTx = contract.transactionHash;
      } else {
        admAddress = contract.address;
        addAccount(admAddress, "Adm");
        addAddressAndAbi("adm", admAddress, admAbi);
        console.log("DATA: var admAddress=\"" + admAddress + "\";");
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
var govNameTx = gov.setName(govName, {from: contractOwnerAccount, gas: 400000, gasPrice: defaultGasPrice});
var govMintTx = gov.mint(contractOwnerAccount, govTotalSupply, {from: contractOwnerAccount, gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
addAccount(govAddress, "Gov - Token '" + web3.toUtf8(gov.symbol()) + "' '" + web3.toUtf8(gov.name()) + "'");
printBalances();
failIfTxStatusError(gemTx, deployGemGovMessage + " - Gem");
failIfTxStatusError(govTx, deployGemGovMessage + " - Gov");
failIfTxStatusError(govNameTx, deployGemGovMessage + " - Gov Name");
failIfTxStatusError(govMintTx, deployGemGovMessage + " - Gov Mint 1,000,000");
failIfTxStatusError(pipTx, deployGemGovMessage + " - Pip");
failIfTxStatusError(pepTx, deployGemGovMessage + " - Pep");
failIfTxStatusError(pitTx, deployGemGovMessage + " - Pit");
failIfTxStatusError(admTx, deployGemGovMessage + " - Adm");
printTxData("gemAddress=" + gemAddress, gemTx);
printTxData("govAddress=" + govAddress, govTx);
printTxData("govAddress=" + govAddress, govNameTx);
printTxData("govAddress=" + govAddress, govMintTx);
printTxData("pipAddress=" + pipAddress, pipTx);
printTxData("pepAddress=" + pepAddress, pepTx);
printTxData("pitAddress=" + pepAddress, pitTx);
printTxData("admAddress=" + admAddress, admTx);
printAdmContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var initFab0Message = "Init Fab";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + initFab0Message + " ----------");
var initFab0_1Tx = daiFab.makeTokens({from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
var initFab0_2Tx = daiFab.makeVoxTub(gemAddress, govAddress, pipAddress, pepAddress, pitAddress, {from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
var initFab0_3Tx = daiFab.makeTapTop({from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
var initFab0_4Tx = daiFab.configParams({from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
var initFab0_5Tx = daiFab.verifyParams({from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
// var initFab0_6Tx = daiFab.configAuth(admAddress, {from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
var initFab0_6Tx = daiFab.configAuth(contractOwnerAccount, {from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var saiAddress = daiFab.sai();
var sinAddress = daiFab.sin();
var skrAddress = daiFab.skr();
var voxAddress = daiFab.vox();
var tubAddress = daiFab.tub();
var tapAddress = daiFab.tap();
var topAddress = daiFab.top();
var momAddress = daiFab.mom();
var dadAddress = daiFab.dad();
var sai = eth.contract(saiAbi).at(saiAddress);
var sin = eth.contract(sinAbi).at(sinAddress);
var skr = eth.contract(skrAbi).at(skrAddress);
var vox = eth.contract(voxAbi).at(voxAddress);
var tub = eth.contract(tubAbi).at(tubAddress);
var tap = eth.contract(tapAbi).at(tapAddress);
var top = eth.contract(topAbi).at(topAddress);
var mom = eth.contract(momAbi).at(momAddress);
var dad = eth.contract(dadAbi).at(dadAddress);
addAddressAndAbi("sai", saiAddress, saiAbi);
addAddressAndAbi("sin", sinAddress, sinAbi);
addAddressAndAbi("skr", skrAddress, skrAbi);
addAddressAndAbi("vox", voxAddress, voxAbi);
addAddressAndAbi("tub", tubAddress, tubAbi);
addAddressAndAbi("tap", tapAddress, tapAbi);
addAddressAndAbi("top", topAddress, topAbi);
addAddressAndAbi("mom", momAddress, momAbi);
addAddressAndAbi("dad", dadAddress, dadAbi);
addAccount(saiAddress, "Sai - Token '" + web3.toUtf8(sai.symbol()) + "' '" + web3.toUtf8(sai.name()) + "'");
addAccount(sinAddress, "Sin - Token '" + web3.toUtf8(sin.symbol()) + "' '" + web3.toUtf8(sin.name()) + "'");
addAccount(skrAddress, "Skr - Token '" + web3.toUtf8(skr.symbol()) + "' '" + web3.toUtf8(skr.name()) + "'");
addAccount(voxAddress, "Vox");
addAccount(tubAddress, "Tub");
addAccount(tapAddress, "Tap");
addAccount(topAddress, "Top");
addAccount(momAddress, "Mom");
addAccount(dadAddress, "Dad");
printBalances();
failIfTxStatusError(initFab0_1Tx, initFab0Message + " - makeTokens");
failIfTxStatusError(initFab0_2Tx, initFab0Message + " - makeVoxTub");
failIfTxStatusError(initFab0_3Tx, initFab0Message + " - makeTapTop");
failIfTxStatusError(initFab0_4Tx, initFab0Message + " - configParams");
failIfTxStatusError(initFab0_5Tx, initFab0Message + " - verifyParams");
failIfTxStatusError(initFab0_6Tx, initFab0Message + " - configAuth");
printTxData("initFab0_1Tx", initFab0_1Tx);
printTxData("initFab0_2Tx", initFab0_2Tx);
printTxData("initFab0_3Tx", initFab0_3Tx);
printTxData("initFab0_4Tx", initFab0_4Tx);
printTxData("initFab0_5Tx", initFab0_5Tx);
printTxData("initFab0_6Tx", initFab0_6Tx);
printAdmContractDetails();
printPipContractDetails();
printMomContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var wrapEther0Message = "Wrap Ethers";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + wrapEther0Message + " ----------");
var wrapEther0_1Tx = eth.sendTransaction({from: account2, to: gemAddress, value: web3.toWei("100", "ether"), gas: 400000, gasPrice: defaultGasPrice});
var wrapEther0_2Tx = eth.sendTransaction({from: account3, to: gemAddress, value: web3.toWei("100", "ether"), gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var wrapEther0_3Tx = gem.approve(tubAddress, new BigNumber(10).shift(18), {from: account2, gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var wrapEther0_4Tx = tub.join(new BigNumber(10).shift(18), {from: account2, gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(wrapEther0_1Tx, wrapEther0Message + " - ac2 100 ETH");
failIfTxStatusError(wrapEther0_2Tx, wrapEther0Message + " - ac3 100 ETH");
failIfTxStatusError(wrapEther0_3Tx, wrapEther0Message + " - ac2 gem.approve(tub, 10 WETH)");
failIfTxStatusError(wrapEther0_4Tx, wrapEther0Message + " - ac3 tub.join(10 WETH)");
printTxData("wrapEther0_1Tx", wrapEther0_1Tx);
printTxData("wrapEther0_2Tx", wrapEther0_2Tx);
printTxData("wrapEther0_3Tx", wrapEther0_3Tx);
printTxData("wrapEther0_4Tx", wrapEther0_4Tx);
// printCrowdsaleContractDetails();
// printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var openCup0Message = "Open Cup";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + openCup0Message + " ----------");
var openCup0_1Tx = mom.setCap(new BigNumber(1000000).shift(18), {from: contractOwnerAccount, gas: 400000, gasPrice: defaultGasPrice});
// 382872500000000000000 = 382.725
var openCup0_2Tx = pip.poke("0x000000000000000000000000000000000000000000000014c16c5e345dbf4000", {from: contractOwnerAccount, gas: 400000, gasPrice: defaultGasPrice});
var openCup0_3Tx = tub.open({from: account2, gas: 400000, gasPrice: defaultGasPrice});
var openCup0_4Tx = skr.approve(tubAddress, new BigNumber(10).shift(18), {from: account2, gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var cup = "0x" + web3.padLeft(web3.toHex(1).substring(2), 64);
var openCup0_5Tx = tub.lock(cup, new BigNumber(10).shift(18), {from: account2, gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
console.log("RESULT: ask(ac2)=" + tub.ask(account2));
var openCup0_6Tx = tub.draw(cup, new BigNumber("2551.5").shift(18), {from: account2, gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(openCup0_1Tx, openCup0Message + " - owner mom.setCap(1,000,000 DAI)");
failIfTxStatusError(openCup0_2Tx, openCup0Message + " - owner pip.poke(382.725)");
failIfTxStatusError(openCup0_3Tx, openCup0Message + " - ac2 tub.open()");
failIfTxStatusError(openCup0_4Tx, openCup0Message + " - ac2 skr.approve(tub, 10 SKR)");
failIfTxStatusError(openCup0_5Tx, openCup0Message + " - ac2 tub.lock(0x1, 10 WETH)");
failIfTxStatusError(openCup0_6Tx, openCup0Message + " - ac2 tub.draw(0x1, 2,551.5 DAI)");
printTxData("openCup0_1Tx", openCup0_1Tx);
printTxData("openCup0_2Tx", openCup0_2Tx);
printTxData("openCup0_3Tx", openCup0_3Tx);
printTxData("openCup0_4Tx", openCup0_4Tx);
printTxData("openCup0_5Tx", openCup0_5Tx);
printTxData("openCup0_6Tx", openCup0_6Tx);
printTubContractDetails();
printPipContractDetails();
printMomContractDetails();
console.log("RESULT: ");


EOF
grep "DATA: " $TEST1OUTPUT | sed "s/DATA: //" > $DEPLOYMENTDATA
cat $DEPLOYMENTDATA
grep "RESULT: " $TEST1OUTPUT | sed "s/RESULT: //" > $TEST1RESULTS
cat $TEST1RESULTS
