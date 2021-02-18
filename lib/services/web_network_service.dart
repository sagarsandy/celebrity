import 'dart:async';
import 'package:celebrity/models/celebrity.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WebNetworkService {
  // Service call to fetch data
  Future<Map> getCelebritiesData() async {
    const url = "https://celebritybucks.com/developers/birthdays/JSON";
    List<Celebrity> youngCelebrities = [];
    List<Celebrity> oldCelebrities = [];
    try {
      final response = await get(url).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final celebritiesData = jsonData["Birthdays"] as List;

        if (celebritiesData.length > 0) {
          celebritiesData.forEach((eachCelebrity) {
            if (eachCelebrity["age"] > 50) {
              print(eachCelebrity["celebId"]);
              oldCelebrities.add(Celebrity.fromJson(eachCelebrity));
            } else {
              youngCelebrities.add(Celebrity.fromJson(eachCelebrity));
            }
          });

          final data = {
            "youngCelebrities": youngCelebrities,
            "oldCelebrities": oldCelebrities
          };
          return data;
        } else {
          print("No records found");
          final data = {"error": "No data not found!!"};
          return data;
        }
      } else {
        print("Something went wrong, handle error here 1");
        final data = {"error": "Status response code error"};
        return data;
      }
    } on TimeoutException catch (e) {
      print("Something went wrong, handle error here 2");
      print(e.toString());
      final data = {"error": "Network timeout!!"};
      return data;
    } on Error catch (e) {
      print("Something went wrong, try catch error");
      print(e.toString());
      final data = {"error": e.toString()};
      return data;
    }
  }
}
