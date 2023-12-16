class ListMakananModel {
  final String id;
  final String karbohidrat;
  final String protein;
  final String lemak;

  ListMakananModel(
      {required this.id,
      required this.karbohidrat,
      required this.protein,
      required this.lemak});

  factory ListMakananModel.fromJson(Map<String, dynamic> data) {
    return ListMakananModel(
        id: data['_id'],
        karbohidrat: data['karbohidrat'],
        protein: data['protein'],
        lemak: data['lemak']);
  }
}
