import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices{
  // var baseUrl = "http://192.168.10.105:8000";
  // var baseUrl = "http://192.168.110.127:8000";
  // var baseUrl = "http://10.0.2.2:8000";
  var baseUrl = "http://127.0.0.1:8000";

  Future getSymptoms() async{
    var symptomsList = [];
    var client = http.Client();
    var headers = {'Content-Type': 'application/json'};
    Uri uri = Uri.parse('${baseUrl}/myapp/getSymptoms');
    // Uri uri = Uri.http('127.0.0.1:8000','/myapp/getSymptoms');
    // print(uri);
    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      symptomsList = data["symptoms"];
    }

    return symptomsList;
  }

  Future getProbability(var userSymptoms) async{
    var probabilityList = [];
    var client = http.Client();
    var headers = {'Content-Type': 'application/json'};
    Uri uri = Uri.parse('${baseUrl}/myapp/getProbability');
    // Uri uri = Uri.http('127.0.0.1:8000','/myapp/getSymptoms');
    var response = await client.post(uri,headers: headers, body: jsonEncode({"userSymptoms":userSymptoms}));
    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      // print({"data":data});
      probabilityList = data["probability"];
    }

    return probabilityList;
  }
}
