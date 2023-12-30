  class MakananDayModel {
    final String id;
    final String user_id;
    final String point;
    final String hari;
    final String total_kalori;

    MakananDayModel(
        {required this.id,
        required this.user_id,
        required this.point,
        required this.hari,
        required this.total_kalori});

    factory MakananDayModel.fromJson(Map data) {
      return MakananDayModel(
          id: data['_id'],
          user_id: data['user_id'],
          point: data['point'],
          hari: data['hari'],
          total_kalori: data['total_kalori']);
    }
  }
