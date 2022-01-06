class TransactionModel {
  final int idList;
  final int idPropinsi;
  final int idKontrasepsi;
  final int jumlahPemakaian;
  final String namaPropinsi;
  final String namaKontrasepsi;

  TransactionModel.fromJSON(Map<String, dynamic> jsonMap) :
    idList = jsonMap['idList'],
    idPropinsi = jsonMap['idPropinsi'],
    idKontrasepsi = jsonMap['idKontrasepsi'],
    jumlahPemakaian = jsonMap['jumlahPemakaian'],
    namaPropinsi = jsonMap['namaPropinsi'],
    namaKontrasepsi = jsonMap['namaKontrasepsi'];
}

class TransactionReportModel {
  final int rowNumber;
  final String namaPropinsi;
  final int pil;
  final int kondom;
  final int iud;
  final int jumlah;

  TransactionReportModel.fromJSON(Map<String, dynamic> jsonMap) :
    rowNumber = jsonMap['row_number'],
    namaPropinsi = jsonMap['nama_propinsi'],
    pil = int.parse(jsonMap['pil']),
    kondom = int.parse(jsonMap['kondom']),
    iud = int.parse(jsonMap['iud']),
    jumlah = int.parse(jsonMap['jumlah']);
}