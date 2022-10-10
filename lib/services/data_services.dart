import 'dart:convert';
import 'dart:developer' show log;
import 'package:http/http.dart' as http;
import '../model/data_model.dart';

class DataServices{
  String baseUrl = "http://127.0.0.1:5500/json/datamodel.json";

 Future<List<DataModel>> getInfo() async {
    //var apiUrl = '/getplaces';
    http.Response res = await http.get(Uri.parse(baseUrl));
    try{
      if(res.statusCode==200){
        List<dynamic> list = json.decode(res.body);
        log(list.toString());
        return list.map((e) => DataModel.fromJson(e)).toList();
      }else{
        return <DataModel>[];
      }
    }catch(e){
      print(e);
      return <DataModel>[];
    }
  }
}