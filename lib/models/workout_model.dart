class WorkoutModel {
   final String id;
   final String hari;
   final String nama_workout;
   final String repetisi;
   final String kalori;

   WorkoutModel({
      required this.id,
      required this.hari,
      required this.nama_workout,
      required this.repetisi,
      required this.kalori
   });

   factory WorkoutModel.fromJson(Map data) {
      return WorkoutModel(
         id: data['_id'],
         hari: data['hari'],
         nama_workout: data['nama_workout'],
         repetisi: data['repetisi'],
         kalori: data['kalori']
      );
   }
}