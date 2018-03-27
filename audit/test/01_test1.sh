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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(gemFabAddress, "GemFab");
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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(voxFabAddress, "VoxFab");
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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(tapFabAddress, "TapFab");
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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(tubFabAddress, "VoxFab");
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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(topFabAddress, "TopFab");
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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(momFabAddress, "MomFab");
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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(dadFabAddress, "DadFab");
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
        // addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        addAccount(daiFabAddress, "DaiFab");
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
// printTokenContractDetails();
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
        addAccount(gemAddress, "Token '" + gem.symbol() + "' '" + gem.name() + "'");
        // addTokenContractAddressAndAbi(tokenAddress, gemAbi);
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
        // addAccount(govAddress, "Token '" + web3.toAscii(gov.symbol()) + "' '" + web3.toAscii(gov.name()) + "'");
        // addTokenContractAddressAndAbi(tokenAddress, gemAbi);
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
        // addTokenContractAddressAndAbi(tokenAddress, gemAbi);
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
        // addTokenContractAddressAndAbi(tokenAddress, gemAbi);
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
        // addTokenContractAddressAndAbi(tokenAddress, gemAbi);
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
addAccount(govAddress, "Token '" + web3.toUtf8(gov.symbol()) + "' '" + web3.toUtf8(gov.name()) + "'");
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
var initFab0_6Tx = daiFab.configAuth(admAddress, {from: contractOwnerAccount, gas: 4000000, gasPrice: defaultGasPrice});
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
addAccount(saiAddress, "Sai");
addAccount(sinAddress, "Sin");
addAccount(skrAddress, "Skr");
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
console.log("RESULT: ");


exit;


// -----------------------------------------------------------------------------
var deployTokenMessage = "Deploy Token Contract";
var saiSymbol="0x4441490000000000000000000000000000000000000000000000000000000000";
var saiName="0x44616920537461626c65636f696e2076312e3000000000000000000000000000";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + deployTokenMessage + " ----------");
var tokenContract = web3.eth.contract(saiAbi);
var tokenTx = null;
var tokenAddress = null;
var token = tokenContract.new(saiSymbol, {from: contractOwnerAccount, data: saiBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        tokenTx = contract.transactionHash;
      } else {
        tokenAddress = contract.address;
        addTokenContractAddressAndAbi(tokenAddress, saiAbi);
        console.log("DATA: var tokenAddress=\"" + tokenAddress + "\";");
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(tokenTx, deployTokenMessage);
printTxData("tokenAddress=" + tokenAddress, tokenTx);
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var setName0Message = "Set Name";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + setName0Message + " ----------");
var setName0_1Tx = token.setName(saiName, {from: contractOwnerAccount, gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
addAccount(tokenAddress, "Token '" + web3.toUtf8(token.symbol()) + "' '" + web3.toUtf8(token.name()) + "'");
printBalances();
failIfTxStatusError(setName0_1Tx, setName0Message);
printTxData("setName0_1Tx", setName0_1Tx);
printTokenContractDetails();
console.log("RESULT: ");


exit;

// -----------------------------------------------------------------------------
var wrapEther0Message = "Wrap Ethers";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + wrapEther0Message + " ----------");
var wrapEther0_1Tx = eth.sendTransaction({from: account2, to: tokenAddress, value: web3.toWei("100", "ether"), gas: 400000, gasPrice: defaultGasPrice});
var wrapEther0_2Tx = eth.sendTransaction({from: account3, to: tokenAddress, value: web3.toWei("100", "ether"), gas: 400000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(wrapEther0_1Tx, wrapEther0Message + " - ac2 100 ETH");
failIfTxStatusError(wrapEther0_2Tx, wrapEther0Message + " - ac3 100 ETH");
printTxData("wrapEther0_1Tx", wrapEther0_1Tx);
printTxData("wrapEther0_2Tx", wrapEther0_2Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var transfer1_Message = "Transfer Tokens";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + transfer1_Message + " ---------");
var transfer1_1Tx = token.transfer(account4, "1000000000000", {from: account2, gas: 100000, gasPrice: defaultGasPrice});
var transfer1_2Tx = token.approve(account5,  "30000000000000000", {from: account3, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var transfer1_3Tx = token.transferFrom(account3, account6, "30000000000000000", {from: account5, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(transfer1_1Tx, transfer1_Message + " - transfer 0.000001 tokens ac2 -> ac4. CHECK for movement");
failIfTxStatusError(transfer1_2Tx, transfer1_Message + " - approve 0.03 tokens ac3 -> ac5");
failIfTxStatusError(transfer1_3Tx, transfer1_Message + " - transferFrom 0.03 tokens ac3 -> ac6 by ac5. CHECK for movement");
printTxData("transfer1_1Tx", transfer1_1Tx);
printTxData("transfer1_2Tx", transfer1_2Tx);
printTxData("transfer1_3Tx", transfer1_3Tx);
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var transfer2_Message = "Transfer 0 Tokens";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + transfer2_Message + " ---------");
var transfer2_1Tx = token.transfer(account4, "0", {from: account2, gas: 100000, gasPrice: defaultGasPrice});
var transfer2_2Tx = token.approve(account5,  "0", {from: account3, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var transfer2_3Tx = token.transferFrom(account3, account6, "0", {from: account5, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(transfer2_1Tx, transfer2_Message + " - transfer 0 tokens ac2 -> ac4. CHECK for movement");
failIfTxStatusError(transfer2_2Tx, transfer2_Message + " - approve 0 tokens ac3 -> ac5");
failIfTxStatusError(transfer2_3Tx, transfer2_Message + " - transferFrom 0 tokens ac3 -> ac6 by ac5. CHECK for movement");
printTxData("transfer2_1Tx", transfer2_1Tx);
printTxData("transfer2_2Tx", transfer2_2Tx);
printTxData("transfer2_3Tx", transfer2_3Tx);
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var transfer3_Message = "Transfer Too Many Tokens";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + transfer3_Message + " ---------");
var transfer3_1Tx = token.transfer(account4, new BigNumber("1000").shift(18), {from: account2, gas: 100000, gasPrice: defaultGasPrice});
var transfer3_2Tx = token.approve(account5,  new BigNumber("2000").shift(18), {from: account3, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var transfer3_3Tx = token.transferFrom(account3, account6, new BigNumber("2000").shift(18), {from: account5, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
passIfTxStatusError(transfer3_1Tx, transfer3_Message + " - transfer 1,000 tokens ac2 -> ac4. CHECK no movement");
failIfTxStatusError(transfer3_2Tx, transfer3_Message + " - approve 2,000 tokens ac3 -> ac5");
passIfTxStatusError(transfer3_3Tx, transfer3_Message + " - transferFrom 2,000 tokens ac3 -> ac6 by ac5. CHECK no movement");
printTxData("transfer3_1Tx", transfer3_1Tx);
printTxData("transfer3_2Tx", transfer3_2Tx);
printTxData("transfer3_3Tx", transfer3_3Tx);
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var withdraw1_Message = "Withdraw Tokens";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + withdraw1_Message + " ---------");
var withdraw1_1Tx = token.withdraw(new BigNumber("10").shift(18), {from: account2, gas: 100000, gasPrice: defaultGasPrice});
var withdraw1_2Tx = token.withdraw(new BigNumber("20").shift(18), {from: account3, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(withdraw1_1Tx, withdraw1_Message + " - ac2 withdraw 10 ETH");
failIfTxStatusError(withdraw1_2Tx, withdraw1_Message + " - ac3 withdraw 20 ETH");
printTxData("withdraw1_1Tx", withdraw1_1Tx);
printTxData("withdraw1_2Tx", withdraw1_2Tx);
printTokenContractDetails();
console.log("RESULT: ");



exit;

// -----------------------------------------------------------------------------
var setWhitelistAdmin_Message = "Set Whitelist Admin";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + setWhitelistAdmin_Message + " ----------");
var setWhitelistAdmin_1Tx = whitelist.setAdmin(adminAccount, {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(setWhitelistAdmin_1Tx, setWhitelistAdmin_Message + " - ac4 admin");
printTxData("setWhitelistAdmin_1Tx", setWhitelistAdmin_1Tx);
printWhitelistContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var whitelistAddress_Message = "Whitelist Address";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + whitelistAddress_Message + " ----------");
var whitelistAddress_1Tx = whitelist.addToWhitelist(account5, 1, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
var whitelistAddress_2Tx = whitelist.addToWhitelist(account6, 2, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
var whitelistAddress_3Tx = whitelist.addToWhitelist(account7, 3, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(whitelistAddress_1Tx, whitelistAddress_Message + " - ac5 T1");
failIfTxStatusError(whitelistAddress_2Tx, whitelistAddress_Message + " - ac6 T2");
failIfTxStatusError(whitelistAddress_3Tx, whitelistAddress_Message + " - ac7 T3");
printTxData("whitelistAddress_1Tx", whitelistAddress_1Tx);
printTxData("whitelistAddress_2Tx", whitelistAddress_2Tx);
printTxData("whitelistAddress_3Tx", whitelistAddress_3Tx);
printWhitelistContractDetails();
console.log("RESULT: ");


// BK 17/03/18 Tested on different positions in the list
if (false) {
// -----------------------------------------------------------------------------
var removeFromWhitelist_Message = "Remove Address From Whitelist #1";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + removeFromWhitelist_Message + " ----------");
var removeFromWhitelist_1Tx = whitelist.removeFromWhitelist(account7, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(removeFromWhitelist_1Tx, removeFromWhitelist_Message + " - remove ac7");
printTxData("removeFromWhitelist_1Tx", removeFromWhitelist_1Tx);
printWhitelistContractDetails();
console.log("RESULT: ");

// -----------------------------------------------------------------------------
var removeFromWhitelist_Message = "Remove Address From Whitelist #2";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + removeFromWhitelist_Message + " ----------");
var removeFromWhitelist_1Tx = whitelist.removeFromWhitelist(account5, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(removeFromWhitelist_1Tx, removeFromWhitelist_Message + " - remove ac5");
printTxData("removeFromWhitelist_1Tx", removeFromWhitelist_1Tx);
printWhitelistContractDetails();
console.log("RESULT: ");

// -----------------------------------------------------------------------------
var removeFromWhitelist_Message = "Remove Address From Whitelist #3";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + removeFromWhitelist_Message + " ----------");
var removeFromWhitelist_1Tx = whitelist.removeFromWhitelist(account6, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(removeFromWhitelist_1Tx, removeFromWhitelist_Message + " - remove ac6");
printTxData("removeFromWhitelist_1Tx", removeFromWhitelist_1Tx);
printWhitelistContractDetails();
console.log("RESULT: ");
}


// -----------------------------------------------------------------------------
var deployConfigMessage = "Deploy Config Contract";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + deployConfigMessage + " ----------");
var configContract = web3.eth.contract(configAbi);
var configTx = null;
var configAddress = null;
var config = configContract.new({from: contractOwnerAccount, data: configBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        configTx = contract.transactionHash;
      } else {
        configAddress = contract.address;
        addAccount(configAddress, "Config Contract");
        addConfigContractAddressAndAbi(configAddress, configAbi);
        console.log("DATA: configAddress=" + configAddress);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(configTx, deployConfigMessage);
printTxData("configAddress=" + configAddress, configTx);
printConfigContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var crowdsaleMessage = "Deploy Crowdsale Contract";
var startTime = parseInt(new Date()/1000) + 10;
var endTime = parseInt(startTime) + 30;
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + crowdsaleMessage + " ----------");
var crowdsaleContract = web3.eth.contract(crowdsaleAbi);
var crowdsaleTx = null;
var crowdsaleAddress = null;
var tokenAddress = null;
var token = null;
var crowdsale = crowdsaleContract.new(startTime, endTime, wallet, whitelistAddress, configAddress, {from: contractOwnerAccount, data: crowdsaleBin, gas: 6000000, gasPrice: defaultGasPrice},
  function(e, contract) {
    if (!e) {
      if (!contract.address) {
        crowdsaleTx = contract.transactionHash;
      } else {
        crowdsaleAddress = contract.address;
        addAccount(crowdsaleAddress, "Crowdsale Contract");
        addCrowdsaleContractAddressAndAbi(crowdsaleAddress, crowdsaleAbi);
        console.log("DATA: crowdsaleAddress=" + crowdsaleAddress);
        tokenAddress = crowdsale.token();
        token = eth.contract(tokenAbi).at(tokenAddress);
        addAccount(tokenAddress, "Token '" + token.symbol() + "' '" + token.name() + "'");
        addTokenContractAddressAndAbi(tokenAddress, tokenAbi);
      }
    }
  }
);
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(crowdsaleTx, crowdsaleMessage);
printTxData("crowdsaleAddress=" + crowdsaleAddress, crowdsaleTx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("startTime", crowdsale.startTime(), 0);


// -----------------------------------------------------------------------------
var sendContribution0Message = "Send Contribution #0 - First Round";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + sendContribution0Message + " ----------");
var sendContribution0_1Tx = eth.sendTransaction({from: account5, to: crowdsaleAddress, gas: 400000, value: web3.toWei("3", "ether")});
var sendContribution0_2Tx = eth.sendTransaction({from: account6, to: crowdsaleAddress, gas: 400000, value: web3.toWei("3", "ether")});
var sendContribution0_3Tx = eth.sendTransaction({from: account7, to: crowdsaleAddress, gas: 400000, value: web3.toWei("3", "ether")});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(sendContribution0_1Tx, sendContribution0Message + " - ac5 3 ETH");
passIfTxStatusError(sendContribution0_2Tx, sendContribution0Message + " - ac6 3 ETH - Expecting failure - wrong round");
passIfTxStatusError(sendContribution0_3Tx, sendContribution0Message + " - ac7 3 ETH - Expecting failure - wrong round");
printTxData("sendContribution0_1Tx", sendContribution0_1Tx);
printTxData("sendContribution0_2Tx", sendContribution0_2Tx);
printTxData("sendContribution0_3Tx", sendContribution0_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("startTime+10s", crowdsale.startTime(), 10);


// -----------------------------------------------------------------------------
var sendContribution1Message = "Send Contribution #1 - Next Round";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + sendContribution1Message + " ----------");
var sendContribution1_1Tx = eth.sendTransaction({from: account5, to: crowdsaleAddress, gas: 400000, value: web3.toWei("2", "ether")});
var sendContribution1_2Tx = eth.sendTransaction({from: account6, to: crowdsaleAddress, gas: 400000, value: web3.toWei("2", "ether")});
var sendContribution1_3Tx = eth.sendTransaction({from: account7, to: crowdsaleAddress, gas: 400000, value: web3.toWei("2", "ether")});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(sendContribution1_1Tx, sendContribution1Message + " - ac5 2 ETH");
failIfTxStatusError(sendContribution1_2Tx, sendContribution1Message + " - ac6 2 ETH");
passIfTxStatusError(sendContribution1_3Tx, sendContribution1Message + " - ac7 2 ETH - Expecting failure - wrong round");
printTxData("sendContribution1_1Tx", sendContribution1_1Tx);
printTxData("sendContribution1_2Tx", sendContribution1_2Tx);
printTxData("sendContribution1_3Tx", sendContribution1_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("startTime+20s", crowdsale.startTime(), 20);


// -----------------------------------------------------------------------------
var sendContribution2Message = "Send Contribution #2 - Next Round";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + sendContribution2Message + " ----------");
var sendContribution2_1Tx = eth.sendTransaction({from: account5, to: crowdsaleAddress, gas: 400000, value: web3.toWei("5", "ether")});
var sendContribution2_2Tx = eth.sendTransaction({from: account6, to: crowdsaleAddress, gas: 400000, value: web3.toWei("500", "ether")});
var sendContribution2_3Tx = eth.sendTransaction({from: account7, to: crowdsaleAddress, gas: 400000, value: web3.toWei("5488", "ether")});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(sendContribution2_1Tx, sendContribution2Message + " - ac5 5 ETH");
failIfTxStatusError(sendContribution2_2Tx, sendContribution2Message + " - ac6 500 ETH");
failIfTxStatusError(sendContribution2_3Tx, sendContribution2Message + " - ac7 5488 ETH");
printTxData("sendContribution2_1Tx", sendContribution2_1Tx);
printTxData("sendContribution2_2Tx", sendContribution2_2Tx);
printTxData("sendContribution2_3Tx", sendContribution2_3Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var setupAllocationAddress_Message = "Setup Allocation";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + setupAllocationAddress_Message + " ----------");
var setupAllocationAddress_1Tx = presaleAllocation.setAdmin(adminAccount, {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
var setupAllocationAddress_2Tx = teamAllocation.setAdmin(adminAccount, {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
var setupAllocationAddress_3Tx = advisorAllocation.setAdmin(adminAccount, {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
var setupAllocationAddress_4Tx = presaleAllocation.setToken(tokenAddress, {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
var setupAllocationAddress_5Tx = teamAllocation.setToken(tokenAddress, {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
var setupAllocationAddress_6Tx = advisorAllocation.setToken(tokenAddress, {from: contractOwnerAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var setupAllocationAddress_7Tx = teamAllocation.registerAllocation(team1Account, new BigNumber("100").shift(18), new BigNumber("50").shift(18), 1, 60, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
var setupAllocationAddress_8Tx = teamAllocation.registerAllocation(team2Account, new BigNumber("200").shift(18), new BigNumber("150").shift(18), 60, 240, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
var setupAllocationAddress_9Tx = teamAllocation.registerAllocation(team3Account, new BigNumber("300").shift(18), new BigNumber("250").shift(18), 60, 240, {from: adminAccount, gas: 200000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(setupAllocationAddress_1Tx, setupAllocationAddress_Message + " - Presale setAdmin");
failIfTxStatusError(setupAllocationAddress_2Tx, setupAllocationAddress_Message + " - Team setAdmin");
failIfTxStatusError(setupAllocationAddress_3Tx, setupAllocationAddress_Message + " - Advisor setAdmin");
failIfTxStatusError(setupAllocationAddress_4Tx, setupAllocationAddress_Message + " - Presale setToken");
failIfTxStatusError(setupAllocationAddress_5Tx, setupAllocationAddress_Message + " - Team setToken");
failIfTxStatusError(setupAllocationAddress_6Tx, setupAllocationAddress_Message + " - Advisor setToken");
failIfTxStatusError(setupAllocationAddress_7Tx, setupAllocationAddress_Message + " - teamAllocation.registerAllocation(team1, value=100, vestingValue=50, cliff=1, vesting=240)");
failIfTxStatusError(setupAllocationAddress_8Tx, setupAllocationAddress_Message + " - teamAllocation.registerAllocation(team2, value=200, vestingValue=150, cliff=60, vesting=240)");
failIfTxStatusError(setupAllocationAddress_9Tx, setupAllocationAddress_Message + " - teamAllocation.registerAllocation(team3, value=300, vestingValue=250, cliff=60, vesting=240)");
printTxData("setupAllocationAddress_1Tx", setupAllocationAddress_1Tx);
printTxData("setupAllocationAddress_2Tx", setupAllocationAddress_2Tx);
printTxData("setupAllocationAddress_3Tx", setupAllocationAddress_3Tx);
printTxData("setupAllocationAddress_4Tx", setupAllocationAddress_4Tx);
printTxData("setupAllocationAddress_5Tx", setupAllocationAddress_5Tx);
printTxData("setupAllocationAddress_6Tx", setupAllocationAddress_6Tx);
printTxData("setupAllocationAddress_7Tx", setupAllocationAddress_7Tx);
printTxData("setupAllocationAddress_8Tx", setupAllocationAddress_8Tx);
printTxData("setupAllocationAddress_9Tx", setupAllocationAddress_9Tx);
printAllocationContractDetails("presale", presaleAllocationAddress, allocationAbi, false);
printAllocationContractDetails("team", teamAllocationAddress, allocationAbi, false);
printAllocationContractDetails("advisor", advisorAllocationAddress, allocationAbi, true);
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var finalise_Message = "Finalise";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + finalise_Message + " ----------");
var finalise_1Tx = crowdsale.setPresaleAllocations(presaleAllocationAddress, {from: contractOwnerAccount, gas: 500000, gasPrice: defaultGasPrice});
var finalise_2Tx = crowdsale.setTeamAllocations(teamAllocationAddress, {from: contractOwnerAccount, gas: 500000, gasPrice: defaultGasPrice});
var finalise_3Tx = crowdsale.setAdvisorsAllocations(advisorAllocationAddress, {from: contractOwnerAccount, gas: 500000, gasPrice: defaultGasPrice});
var finalise_4Tx = crowdsale.setReserveFund(reserveFundAccount, {from: contractOwnerAccount, gas: 500000, gasPrice: defaultGasPrice});
var finalise_5Tx = crowdsale.setDevelopmentFund(developmentFundAccount, {from: contractOwnerAccount, gas: 500000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var finalise_6Tx = crowdsale.finalize({from: contractOwnerAccount, gas: 500000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(finalise_1Tx, finalise_Message + " - setPresaleAllocations");
failIfTxStatusError(finalise_2Tx, finalise_Message + " - setTeamAllocations");
failIfTxStatusError(finalise_3Tx, finalise_Message + " - setAdvisorsAllocations");
failIfTxStatusError(finalise_4Tx, finalise_Message + " - setReserveFund");
failIfTxStatusError(finalise_5Tx, finalise_Message + " - setDevelopmentFund");
failIfTxStatusError(finalise_6Tx, finalise_Message + " - Finalise");
printTxData("finalise_1Tx", finalise_1Tx);
printTxData("finalise_2Tx", finalise_2Tx);
printTxData("finalise_3Tx", finalise_3Tx);
printTxData("finalise_4Tx", finalise_4Tx);
printTxData("finalise_5Tx", finalise_5Tx);
printTxData("finalise_6Tx", finalise_6Tx);
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var distributeVesting_Message = "Distribute Vesting";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + distributeVesting_Message + " ----------");
var distributeVesting_1Tx = teamAllocation.distributeAllocation(team1Account, {from: contractOwnerAccount, gas: 1000000, gasPrice: defaultGasPrice});
var distributeVesting_2Tx = teamAllocation.distributeAllocation(team2Account, {from: contractOwnerAccount, gas: 1000000, gasPrice: defaultGasPrice});
var distributeVesting_3Tx = teamAllocation.distributeAllocation(team3Account, {from: contractOwnerAccount, gas: 1000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(distributeVesting_1Tx, distributeVesting_Message + " - teamAllocation.distributeAllocation(team1Account)");
failIfTxStatusError(distributeVesting_2Tx, distributeVesting_Message + " - teamAllocation.distributeAllocation(team2Account)");
failIfTxStatusError(distributeVesting_3Tx, distributeVesting_Message + " - teamAllocation.distributeAllocation(team3Account)");
printTxData("distributeVesting_1Tx", distributeVesting_1Tx);
printTxData("distributeVesting_2Tx", distributeVesting_2Tx);
printTxData("distributeVesting_3Tx", distributeVesting_3Tx);
printAllocationContractDetails("team", teamAllocationAddress, allocationAbi, true);
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var transfer1_Message = "Move Tokens";
// -----------------------------------------------------------------------------
console.log("RESULT: " + transfer1_Message);
var transfer1_1Tx = token.transfer(account8, "1000000000000", {from: account5, gas: 100000, gasPrice: defaultGasPrice});
var transfer1_2Tx = token.approve(account9,  "30000000000000000", {from: account6, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
var transfer1_3Tx = token.transferFrom(account6, eth.accounts[10], "30000000000000000", {from: account9, gas: 100000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
printTxData("transfer1_1Tx", transfer1_1Tx);
printTxData("transfer1_2Tx", transfer1_2Tx);
printTxData("transfer1_3Tx", transfer1_3Tx);
failIfTxStatusError(transfer1_1Tx, transfer1_Message + " - transfer 0.000001 tokens ac5 -> ac8. CHECK for movement");
failIfTxStatusError(transfer1_2Tx, transfer1_Message + " - approve 0.03 tokens ac6 -> ac9");
failIfTxStatusError(transfer1_3Tx, transfer1_Message + " - transferFrom 0.03 tokens ac6 -> ac10 by ac9. CHECK for movement");
printCrowdsaleContractDetails();
printTokenContractDetails();
console.log("RESULT: ");


// -----------------------------------------------------------------------------
var claimVesting0_Message = "Claim Vesting #1";
var team1VestingContractAddress = teamAllocation.getVesting(team1Account);
var team1VestingContract = eth.contract(vestingAbi).at(team1VestingContractAddress);
addAccount(team1VestingContractAddress, "Team #1 Vesting Contract");
var team2VestingContractAddress = teamAllocation.getVesting(team2Account);
addAccount(team2VestingContractAddress, "Team #2 Vesting Contract");
var team3VestingContractAddress = teamAllocation.getVesting(team3Account);
addAccount(team3VestingContractAddress, "Team #3 Vesting Contract");
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + claimVesting0_Message + " ----------");
var claimVesting0_1Tx = team1VestingContract.release(tokenAddress, {from: team1Account, gas: 1000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(claimVesting0_1Tx, claimVesting0_Message + " - team1VestingContract.release(token)");
printTxData("claimVesting0_1Tx", claimVesting0_1Tx);
printAllocationContractDetails("team", teamAllocationAddress, allocationAbi, true);
printVestingContractDetails(team1VestingContractAddress, vestingAbi, true);
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("vesting.start+30s", team1VestingContract.start(), 30);


// -----------------------------------------------------------------------------
var claimVesting1_Message = "Claim Vesting #2";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + claimVesting1_Message + " ----------");
var claimVesting1_1Tx = team1VestingContract.release(tokenAddress, {from: team1Account, gas: 1000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(claimVesting1_1Tx, claimVesting1_Message + " - team1VestingContract.release(token)");
printTxData("claimVesting1_1Tx", claimVesting1_1Tx);
printAllocationContractDetails("team", teamAllocationAddress, allocationAbi, true);
printVestingContractDetails(team1VestingContractAddress, vestingAbi, true);
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("vesting.start+45s", team1VestingContract.start(), 45);


// -----------------------------------------------------------------------------
var claimVesting2_Message = "Claim Vesting #3";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + claimVesting2_Message + " ----------");
var claimVesting2_1Tx = team1VestingContract.release(tokenAddress, {from: team1Account, gas: 1000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(claimVesting2_1Tx, claimVesting2_Message + " - team1VestingContract.release(token)");
printTxData("claimVesting2_1Tx", claimVesting2_1Tx);
printAllocationContractDetails("team", teamAllocationAddress, allocationAbi, true);
printVestingContractDetails(team1VestingContractAddress, vestingAbi, true);
printTokenContractDetails();
console.log("RESULT: ");


waitUntil("vesting.start+60s", team1VestingContract.start(), 60);


// -----------------------------------------------------------------------------
var claimVesting3_Message = "Claim Vesting #4";
// -----------------------------------------------------------------------------
console.log("RESULT: ---------- " + claimVesting3_Message + " ----------");
var claimVesting3_1Tx = team1VestingContract.release(tokenAddress, {from: team1Account, gas: 1000000, gasPrice: defaultGasPrice});
while (txpool.status.pending > 0) {
}
printBalances();
failIfTxStatusError(claimVesting3_1Tx, claimVesting3_Message + " - team1VestingContract.release(token)");
printTxData("claimVesting3_1Tx", claimVesting3_1Tx);
printAllocationContractDetails("team", teamAllocationAddress, allocationAbi, true);
printVestingContractDetails(team1VestingContractAddress, vestingAbi, true);
printTokenContractDetails();
console.log("RESULT: ");


EOF
grep "DATA: " $TEST1OUTPUT | sed "s/DATA: //" > $DEPLOYMENTDATA
cat $DEPLOYMENTDATA
grep "RESULT: " $TEST1OUTPUT | sed "s/RESULT: //" > $TEST1RESULTS
cat $TEST1RESULTS
