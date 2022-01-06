import 'package:bloc/bloc.dart';
import 'package:kontrasepsi_app/model/KontrasepsiModel.dart';
import 'package:kontrasepsi_app/repositories/kontrasepsiRepository.dart';
import 'package:kontrasepsi_app/services/APIService.dart';

class KontrasepsiBloc extends Bloc<KontrasepsiEvent, KontrasepsiState> {
  void onGetData() {
    dispatch(GetKontrasepsiEvent());
  }

  @override
  KontrasepsiState get initialState => KontrasepsiState.initial();

  @override
  Stream<KontrasepsiState> mapEventToState(KontrasepsiState state, KontrasepsiEvent event) async* {
    if (event is GetKontrasepsiEvent) {
      final data = await APIWeb().load(KontrasepsiRepository.getData);
      yield KontrasepsiState(list: data);
    }
  }

}

//event
abstract class KontrasepsiEvent {}

class GetKontrasepsiEvent extends KontrasepsiEvent {}


//state
class KontrasepsiState {
  final List<KontrasepsiModel> list;

  const KontrasepsiState({this.list});

  factory KontrasepsiState.initial() => KontrasepsiState();
}
