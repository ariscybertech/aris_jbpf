import 'dart:convert';

import 'package:kontrasepsi_app/model/propinsiModel.dart';
import 'package:kontrasepsi_app/model/resultModel.dart';
import 'package:kontrasepsi_app/services/APIService.dart';

class PropinsiRepository{
  
  static APIService<List<PropinsiModel>> get getData {
    return APIService(
      url:  'propinsi',
      parse: (response) {
        final parsed = json.decode(response.body); 
        final dataJson = ResultModel.fromJSON(parsed);
        return dataJson.responsedata.map((i) => PropinsiModel.fromJSON(i)).toList();
      }
    );
  }

  static APIService<PropinsiModel> getDataByID(int id) {
    return APIService(
      url:  'propinsi/' + id.toString(),
      parse: (response) {
        final parsed = json.decode(response.body); 
        final dataJson = ResultModel.fromJSON(parsed);
        return dataJson.responsedata.map((i) => PropinsiModel.fromJSON(i)).single;
      }
    );
  }
}
