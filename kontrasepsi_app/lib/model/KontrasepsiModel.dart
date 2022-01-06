class KontrasepsiModel {
  final int idKontrasepsi;
  final String namaKontrasepsi;

  KontrasepsiModel.fromJSON(Map<String, dynamic> jsonMap) :
    idKontrasepsi = jsonMap['Id_Kontrasepsi'],
    namaKontrasepsi = jsonMap['Nama_Kontrasepsi'];
}