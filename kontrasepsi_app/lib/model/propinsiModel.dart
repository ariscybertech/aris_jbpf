class PropinsiModel {
  final int idPropinsi;
  final String namaPropinsi;

  PropinsiModel.fromJSON(Map<String, dynamic> jsonMap) :
    idPropinsi = jsonMap['Id_Propinsi'],
    namaPropinsi = jsonMap['Nama_Propinsi'];
}