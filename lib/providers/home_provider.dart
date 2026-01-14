

import 'package:v_wallet_frontend/providers/base_provider.dart';

class HomeProvider extends BaseProvider {
  int index = 1;


  void setIndex(int value){
    index = value;
    notifyListeners();
  }
}