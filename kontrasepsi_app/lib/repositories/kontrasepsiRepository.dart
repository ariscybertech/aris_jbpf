import 'dart:convert';

import 'package:kontrasepsi_app/model/KontrasepsiModel.dart';
import 'package:kontrasepsi_app/model/resultModel.dart';
import 'package:kontrasepsi_app/services/APIService.dart';

class KontrasepsiRepository{
  
  static APIService<List<KontrasepsiModel>> get getData {
    return APIService(
      url:  'kontrasepsi',
      parse: (response) {
        final parsed = json.decode(response.body); 
        final dataJson = ResultModel.fromJSON(parsed);
        return dataJson.responsedata.map((i) => KontrasepsiModel.fromJSON(i)).toList();
      }
    );
  }

  static APIService<KontrasepsiModel> getDataByID(int id) {
    return APIService(
      url:  'kontrasepsi/' + id.toString(),
      parse: (response) {
        final parsed = json.decode(response.body); 
        final dataJson = ResultModel.fromJSON(parsed);
        return dataJson.responsedata.map((i) => KontrasepsiModel.fromJSON(i)).single;
      }
    );
  }
}
