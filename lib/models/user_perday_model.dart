class UserPerdayModel {
  final String id;
  final String user_id;
  final String bmi;
  final String total_calories;
  final String weight_categories;
  final String day;

  UserPerdayModel(
      {required this.id,
      required this.user_id,
      required this.bmi,
      required this.total_calories,
      required this.weight_categories,
      required this.day});

  factory UserPerdayModel.fromJson(Map data) {
    return UserPerdayModel(
        id: data['_id'],
        user_id: data['user_id'],
        bmi: data['bmi'],
        total_calories: data['total_calories'],
        weight_categories: data['weight_categories'],
        day: data['day']);
  }
}
