import 'dart:convert';
import 'package:v_wallet_frontend/models/transfer_model.dart';
import 'package:v_wallet_frontend/providers/base_provider.dart';

class HomeProvider extends BaseProvider {
  int index = 1;
  int userBalance = 0;
  String username = "";
  bool noData = false;
  List<Datum> homeScreen = [];

  void setIndex(int value) {
    index = value;
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    setBusy(true);
    final response = await api.get("/user");
    final res = jsonDecode(response.body);
    userBalance = res["balance"];
    username = res["name"];
    setBusy(false);
  }

  Future<void> poplateHome() async {
    setBusy(true);
    final response = await api.get("/getTransferHistory?limit=7");
    final transferModel = transferModelFromJson(response.body);
    if (transferModel.data.isEmpty) {
      noData = true;
      notifyListeners();
    } else {
      noData = false;
      homeScreen.addAll(transferModel.data);
      notifyListeners();
    }
    setBusy(false);
  }
}
