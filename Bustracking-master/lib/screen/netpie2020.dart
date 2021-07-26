import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
var x;
var y;
class NETPIE2020 {
  // publish message topic
  Future<bool> publish(
      String topic, String clientId, String token, String message) async {
    // sent request token
    String deviceAuth = 'Device ' + clientId + ":" + token;
    Response response =await http.put( x + topic, headers: <String, String>
        {
          'Authorization': deviceAuth,
        },
            body: message);
      }}