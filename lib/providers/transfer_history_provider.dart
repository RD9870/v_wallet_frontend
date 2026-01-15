import 'package:flutter/material.dart';
import 'package:v_wallet_frontend/models/transfer_model.dart';
import 'package:v_wallet_frontend/providers/base_provider.dart';

class TransferHistoryProvider extends BaseProvider {
  List<Datum> transferHistory = [];
  bool noData = false;
  String? selectedDate;
  bool isLoadingMore = false;
  String? nextPageUrl;
  final ScrollController controller = ScrollController();

  void setLisnter() {
    controller.addListener(() async {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 50) {
        if (!isLoadingMore && nextPageUrl != null) {
          getMoreHistory();
        }
      }
    });
  }

  Future<void> poplateHistory() async {
    setBusy(true);
    final response = await api.get("/getTransferHistory?limit=10");
    final transferModel = transferModelFromJson(response.body);
    if (transferModel.data.isEmpty) {
      noData = true;
      notifyListeners();
    } else {
      noData = false;
      transferHistory.addAll(transferModel.data);
      nextPageUrl = transferModel.links?.next;
      debugPrint("nextPageUrl $nextPageUrl");
      String endPoint = nextPageUrl!.split('/api').last;
      debugPrint("endPoint $endPoint");
      notifyListeners();
    }
    setBusy(false);
  }

  Future<void> getMoreHistory() async {
    if (nextPageUrl == null || isLoadingMore) {
      debugPrint("nothing more");
      return;
    }

    isLoadingMore = true;
    notifyListeners();
    String endPoint = nextPageUrl!.split('/api').last;
    final response = await api.get(endPoint);
    debugPrint("endpoint: $endPoint");
    debugPrint("response: ${response.statusCode}");
    debugPrint("nextPageUrl: $nextPageUrl");

    if (response.statusCode == 200) {
      final transferModel = transferModelFromJson(response.body);

      if (transferModel.data.isNotEmpty) {
        debugPrint("API Response: ${response.body}");
        nextPageUrl = transferModel.links?.next;
        transferHistory.addAll(transferModel.data);
      }
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> handelFiltering(String selectedDate) async {
    setBusy(true);
    final response = await api.get("/filterTransferHistory?date=$selectedDate");
    debugPrint("response filter: ${response.body} ");
    final transferModel = transferModelFromJson(response.body);
    if (transferModel.data.isEmpty) {
      noData = true;
      notifyListeners();
    } else {
      noData = false;
      transferHistory.clear();
      transferHistory.addAll(transferModel.data);
      notifyListeners();
    }
    setBusy(false);
  }
}
