import 'package:bloc/bloc.dart';
import 'package:kontrasepsi_app/model/propinsiModel.dart';
import 'package:kontrasepsi_app/repositories/propinsiRepository.dart';
import 'package:kontrasepsi_app/services/APIService.dart';

class PropinsiBloc extends Bloc<PropinsiEvent, PropinsiState> {
  void onGetData() {
    dispatch(GetPropinsiEvent());
  }

  @override
  PropinsiState get initialState => PropinsiState.initial();

  @override
  Stream<PropinsiState> mapEventToState(PropinsiState state, PropinsiEvent event) async* {
    if (event is GetPropinsiEvent) {
      final data = await APIWeb().load(PropinsiRepository.getData);
      yield PropinsiState(list: data);
    }
  }

}

//event
abstract class PropinsiEvent {}

class GetPropinsiEvent extends PropinsiEvent {}

class GetPropinsiByID extends PropinsiEvent {
  final int id;

  GetPropinsiByID(this.id);
}


//state
class PropinsiState {
  final List<PropinsiModel> list;

  const PropinsiState({this.list});

  factory PropinsiState.initial() => PropinsiState();
}
