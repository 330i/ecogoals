import 'dart:async';
import 'dart:convert';

import 'package:ecogoals/models/web_result.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

Future<List<WebResult>> fetchWebResult(String val) async {
  String url = 'http://192.168.0.10:5000/get_web_data?item=' + val;
  Response response = await get(url);

  print(response);
  var j = json.decode(response.body);
  List<WebResult> webresults = [];
  webresults.add(WebResult.fromJson(j['result']));

  print(webresults);

  return webresults;
}
