import 'dart:convert';

import 'package:kontrasepsi_app/model/resultModel.dart';
import 'package:kontrasepsi_app/model/transactionModel.dart';
import 'package:kontrasepsi_app/services/APIService.dart';

class TransactionRepository{
  
  static APIService<List<TransactionModel>> get getData {
    return APIService(
      url:  'transaction/',
      parse: (response) {
        final parsed = json.decode(response.body); 
        final dataJson = ResultModel.fromJSON(parsed);
        return dataJson.responsedata.map((i) => TransactionModel.fromJSON(i)).toList();
      }
    );
  }

  static APIService<List<TransactionReportModel>> get getDataReport {
    return APIService(
      url:  'transaction/report',
      parse: (response) {
        final parsed = json.decode(response.body); 
        final dataJson = ResultModel.fromJSON(parsed);
        return dataJson.responsedata.map((i) => TransactionReportModel.fromJSON(i)).toList();
      }
    );
  }

  static APIService<bool> insert(dynamic body) {
    bool bresult = false;
    return APIService(
      url:  'transaction/',
      body: body,
      parse: (response) {
        final parsed = json.decode(response.body); 
        final dataJson = ResultModel.fromJSON(parsed);
        if (dataJson.responsemessage == "Success"){
          bresult = true;
        }
        return bresult;
      }
    );
  }
}
