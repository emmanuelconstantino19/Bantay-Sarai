import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class EthereumUtils {
  Web3Client web3client;
  http.Client httpClient;
  final contractAddress = '0x6071939967007795d8D46EeB36421917eA08F906';

  void initial() {
    httpClient = http.Client();
    String infuraApi = "https://goerli.infura.io/v3/cddca677b6014d9fa96036ad69dc2c77";
    web3client = Web3Client(infuraApi, httpClient);
  }

  Future getBalance() async {
    final contract = await getDeployedContract();
    final etherFunction = contract.function("balanceOf");
    final result = await web3client.call(contract: contract, function: etherFunction, params: [EthereumAddress.fromHex("0x117B981aDf15C784a671A863031154f8fbe84647")]);
    List<dynamic> res = result;
    return res[0];
  }

  Future<String> sendEth(int amount) async {
  var bigAmount = BigInt.from(amount);
    EthPrivateKey privateKeyCred = EthPrivateKey.fromHex('97ead9dfd690c6ea839fe258fbe9a44e92470c1ab3177a4bc0d09ed25bc16c06');
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("transfer");
    final result = await web3client.sendTransaction(
        privateKeyCred,
        Transaction.callContract(
          contract: contract,
          function: etherFunction,
          parameters: [EthereumAddress.fromHex("0xe5D4E0683ef0c66581928D253F6CC7c3d010eBCc"),bigAmount],
          maxGas: 100000,
        ),chainId: 5,
        fetchChainIdFromNetworkId: false);
    return result;
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "BasicDapp"), EthereumAddress.fromHex(contractAddress));
    return contract;
  }
}