class UserWeekModel {
  final String id;
  final String user_id;
  final String berat_badan;
  final String week;

  UserWeekModel(
      {required this.id,
      required this.user_id,
      required this.berat_badan,
      required this.week});

  factory UserWeekModel.fromJson(Map data) {
    return UserWeekModel(
        id: data['_id'],
        user_id: data['user_id'],
        berat_badan: data['berat_badan'],
        week: data['week']);
  }
}
