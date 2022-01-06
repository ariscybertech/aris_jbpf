import 'package:bloc/bloc.dart';
import 'package:kontrasepsi_app/model/KontrasepsiModel.dart';
import 'package:kontrasepsi_app/model/propinsiModel.dart';
import 'package:kontrasepsi_app/model/transactionModel.dart';
import 'package:kontrasepsi_app/repositories/kontrasepsiRepository.dart';
import 'package:kontrasepsi_app/repositories/propinsiRepository.dart';
import 'package:kontrasepsi_app/repositories/transactionRepository.dart';
import 'package:kontrasepsi_app/services/APIService.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {

  void onGetDataPropinsi() {
    dispatch(GetPropinsiEvent());
  }

  void onGetDataPropinsiByID(int id) {
    dispatch(GetPropinsiByID(id));
  }

  void onGetDataKontrasepsiByID(int id) {
    dispatch(GetKontrasepsiByID(id));
  }

  void onGetDataReport() {
    dispatch(GetReportEvent());
  }

  Future<bool> insertData(int idPropinsi, int idKontrasepsi, int jumlah) async {
    bool bResult = false;
    Map<String, dynamic> jsonBody = {
        'idPropinsi': idPropinsi.toString().replaceAll(".0", ""),
        'idKontrasepsi': idKontrasepsi.toString().replaceAll(".0", ""),
        'jumlah': jumlah.toString().replaceAll(".0", ""),
      };
    await  APIWeb().post(TransactionRepository.insert(jsonBody))
        .then((onValue) {
        bResult = true;
      }).catchError((onError) {
        bResult = false;
      });
      
      return bResult;
  }


  @override
  TransactionState get initialState => TransactionState.initial();
  
  @override
  Stream<TransactionState> mapEventToState(TransactionState state, TransactionEvent event) async* {
    if (event is GetPropinsiByID){
      final data = await APIWeb().load(PropinsiRepository.getDataByID(event.id));
      yield TransactionState(propinsiModel: data, kontrasepsiModel: currentState.kontrasepsiModel);
    }
    if (event is GetKontrasepsiByID){
      final data = await APIWeb().load(KontrasepsiRepository.getDataByID(event.id));
      yield TransactionState(propinsiModel: currentState.propinsiModel, kontrasepsiModel: data);
    }
    if (event is GetReportEvent){
      final data = await APIWeb().load(TransactionRepository.getDataReport);
      yield TransactionState(report: data);
    }
    
  }

}


abstract class TransactionEvent {}

class GetPropinsiEvent extends TransactionEvent {}

class GetPropinsiByID extends TransactionEvent {
  final int id;
  GetPropinsiByID(this.id);
}

class GetKontrasepsiByID extends TransactionEvent {
  final int id;
  GetKontrasepsiByID(this.id);
}

class GetReportEvent extends TransactionEvent {}

class TransactionState {
  final PropinsiModel propinsiModel;
  final KontrasepsiModel kontrasepsiModel;
  final List<TransactionReportModel> report;
  final bool statusPost;

  const TransactionState({this.propinsiModel, this.kontrasepsiModel, this.report, this.statusPost});

  factory TransactionState.initial() => TransactionState(statusPost: false);
}
