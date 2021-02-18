import 'package:celebrity/models/celebrity.dart';
import 'package:celebrity/services/web_network_service.dart';
import 'package:flutter/material.dart';

class CelebrityDataProviderService extends ChangeNotifier {
  List<Celebrity> youngCelebrities = [];
  List<Celebrity> oldCelebrities = [];

  // Service call to fetch player tournaments info data
  getCelebritiesData(GlobalKey<ScaffoldState> scaffoldKey) async {
    print("Called get celebrities function");

    Map<String, dynamic> celebritiesData =
        await WebNetworkService().getCelebritiesData();
    if (celebritiesData.containsKey("youngCelebrities") &&
        celebritiesData.containsKey("oldCelebrities")) {
      youngCelebrities.addAll(celebritiesData["youngCelebrities"]);
      oldCelebrities.addAll(celebritiesData["oldCelebrities"]);
      notifyListeners();
    } else {
      // Displaying error, if there is any issue in fetching data
      scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(celebritiesData["error"])));
    }
  }
}
