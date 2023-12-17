class NutriensModel {
  final String id;
  final String user_id;
  final String nama_makanan;
  final String jumlah_sajian;
  final String kalori;
  final String hari;

  NutriensModel(
      {required this.id,
      required this.user_id,
      required this.nama_makanan,
      required this.jumlah_sajian,
      required this.kalori,
      required this.hari});

  factory NutriensModel.fromJson(Map<String, dynamic> data) {
    return NutriensModel(
        id: data['_id'],
        user_id: data['user_id'],
        nama_makanan: data['nama_makanan'],
        jumlah_sajian: data['jumlah_sajian'],
        kalori: data['kalori'],
        hari: data['hari']);
  }
}
