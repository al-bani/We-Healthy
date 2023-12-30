class WorkoutDayModel {
  final String id;
  final String user_id;
  final String hari;
  final String point;
  final String kalori_terbakar;

  WorkoutDayModel(
      {required this.id,
      required this.user_id,
      required this.hari,
      required this.point,
      required this.kalori_terbakar});

  factory WorkoutDayModel.fromJson(Map data) {
    return WorkoutDayModel(
        id: data['_id'],
        user_id: data['user_id'],
        hari: data['hari'],
        point: data['point'],
        kalori_terbakar: data['kalori_terbakar']);
  }
}
