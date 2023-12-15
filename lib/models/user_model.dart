class UserDataModel {
  final String id;
  final String user_id;
  final String gender;
  final String umur;
  final String berat_badan;
  final String tinggi_badan;
  final String bmi;
  final String kalori_perhari;
  final String kegiatan;
  final String kategori_berat;

  UserDataModel(
      {required this.id,
      required this.user_id,
      required this.gender,
      required this.umur,
      required this.berat_badan,
      required this.tinggi_badan,
      required this.bmi,
      required this.kalori_perhari,
      required this.kegiatan,
      required this.kategori_berat});

  factory UserDataModel.fromJson(Map<String, dynamic> data) {
    return UserDataModel(
        id: data['_id'],
        user_id: data['user_id'],
        gender: data['gender'],
        umur: data['umur'],
        berat_badan: data['berat_badan'],
        tinggi_badan: data['tinggi_badan'],
        bmi: data['bmi'],
        kalori_perhari: data['kalori_perhari'],
        kegiatan: data['kegiatan'],
        kategori_berat: data['kategori_berat']);
  }
}
