import 'dart:convert';

import 'package:covid19_tracker/Models/WorldstateModel.dart';
import 'package:covid19_tracker/Services/Utilities/Api_urls.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStates> getworldstates() async {
    final response = await http.get(Uri.parse(Baseurl.Worldstatesurl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStates.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> getworldList() async {
    var data;
    final response = await http.get(Uri.parse(Baseurl.CountryList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
