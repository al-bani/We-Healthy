// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:http/http.dart' as http;

class DataService {
  Future insertUserData(
      String appid,
      String user_id,
      String gender,
      String umur,
      String berat_badan,
      String tinggi_badan,
      String bmi,
      String kalori_perhari,
      String kegiatan,
      String kategori_berat) async {
    String uri = 'https://io.etter.cloud/v4/insert';

    try {
      final response = await http.post(Uri.parse(uri), body: {
        'token': '65740448c735f28b8b45eda9',
        'project': 'db_we_healthy',
        'collection': 'user_data',
        'appid': appid,
        'user_id': user_id,
        'gender': gender,
        'umur': umur,
        'berat_badan': berat_badan,
        'tinggi_badan': tinggi_badan,
        'bmi': bmi,
        'kalori_perhari': kalori_perhari,
        'kegiatan': kegiatan,
        'kategori_berat': kategori_berat
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future insertCarbs(String appid, String user_id, String nama_makanan,
      String jumlah_sajian, String kalori, String hari) async {
    String uri = 'https://io.etter.cloud/v4/insert';

    try {
      final response = await http.post(Uri.parse(uri), body: {
        'token': '65740448c735f28b8b45eda9',
        'project': 'db_we_healthy',
        'collection': 'carbs',
        'appid': appid,
        'user_id': user_id,
        'nama_makanan': nama_makanan,
        'jumlah_sajian': jumlah_sajian,
        'kalori': kalori,
        'hari': hari
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future insertProtein(String appid, String user_id, String nama_makanan,
      String jumlah_sajian, String kalori, String hari) async {
    String uri = 'https://io.etter.cloud/v4/insert';

    try {
      final response = await http.post(Uri.parse(uri), body: {
        'token': '65740448c735f28b8b45eda9',
        'project': 'db_we_healthy',
        'collection': 'protein',
        'appid': appid,
        'user_id': user_id,
        'nama_makanan': nama_makanan,
        'jumlah_sajian': jumlah_sajian,
        'kalori': kalori,
        'hari': hari
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future insertFat(String appid, String user_id, String nama_makanan,
      String jumlah_sajian, String kalori, String hari) async {
    String uri = 'https://io.etter.cloud/v4/insert';

    try {
      final response = await http.post(Uri.parse(uri), body: {
        'token': '65740448c735f28b8b45eda9',
        'project': 'db_we_healthy',
        'collection': 'fat',
        'appid': appid,
        'user_id': user_id,
        'nama_makanan': nama_makanan,
        'jumlah_sajian': jumlah_sajian,
        'kalori': kalori,
        'hari': hari
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future insertListMakanan(
      String appid, String karbohidrat, String protein, String lemak) async {
    String uri = 'https://io.etter.cloud/v4/insert';

    try {
      final response = await http.post(Uri.parse(uri), body: {
        'token': '65740448c735f28b8b45eda9',
        'project': 'db_we_healthy',
        'collection': 'list_makanan',
        'appid': appid,
        'karbohidrat': karbohidrat,
        'protein': protein,
        'lemak': lemak
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future insertListWorkout(String appid, String hari, String nama_workout,
      String repetisi, String kalori) async {
    String uri = 'https://io.etter.cloud/v4/insert';

    try {
      final response = await http.post(Uri.parse(uri), body: {
        'token': '65740448c735f28b8b45eda9',
        'project': 'db_we_healthy',
        'collection': 'list_workout',
        'appid': appid,
        'hari': hari,
        'nama_workout': nama_workout,
        'repetisi': repetisi,
        'kalori': kalori
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future selectAll(
      String token, String project, String collection, String appid) async {
    String uri = 'https://io.etter.cloud/v4/select_all/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future selectId(String token, String project, String collection, String appid,
      String id) async {
    String uri = 'https://io.etter.cloud/v4/select_id/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/id/' +
        id;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future selectWhere(String token, String project, String collection,
      String appid, String where_field, String where_value) async {
    String uri = 'https://io.etter.cloud/v4/select_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/where_field/' +
        where_field +
        '/where_value/' +
        where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future selectOrWhere(String token, String project, String collection,
      String appid, String or_where_field, String or_where_value) async {
    String uri = 'https://io.etter.cloud/v4/select_or_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/or_where_field/' +
        or_where_field +
        '/or_where_value/' +
        or_where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future selectWhereLike(String token, String project, String collection,
      String appid, String wlike_field, String wlike_value) async {
    String uri = 'https://io.etter.cloud/v4/select_where_like/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wlike_field/' +
        wlike_field +
        '/wlike_value/' +
        wlike_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future selectWhereIn(String token, String project, String collection,
      String appid, String win_field, String win_value) async {
    String uri = 'https://io.etter.cloud/v4/select_where_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/win_field/' +
        win_field +
        '/win_value/' +
        win_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future selectWhereNotIn(String token, String project, String collection,
      String appid, String wnotin_field, String wnotin_value) async {
    String uri = 'https://io.etter.cloud/v4/select_where_not_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wnotin_field/' +
        wnotin_field +
        '/wnotin_value/' +
        wnotin_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future removeAll(
      String token, String project, String collection, String appid) async {
    String uri = 'https://io.etter.cloud/v4/remove_all/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid;

    try {
      final response = await http.delete(Uri.parse(uri));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Print error here
      return false;
    }
  }

  Future removeId(String token, String project, String collection, String appid,
      String id) async {
    String uri = 'https://io.etter.cloud/v4/remove_id/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/id/' +
        id;

    try {
      final response = await http.delete(Uri.parse(uri));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Print error here
      return false;
    }
  }

  Future removeWhere(String token, String project, String collection,
      String appid, String where_field, String where_value) async {
    String uri = 'https://io.etter.cloud/v4/remove_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/where_field/' +
        where_field +
        '/where_value/' +
        where_value;

    try {
      final response = await http.delete(Uri.parse(uri));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Print error here
      return false;
    }
  }

  Future removeOrWhere(String token, String project, String collection,
      String appid, String or_where_field, String or_where_value) async {
    String uri = 'https://io.etter.cloud/v4/remove_or_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/or_where_field/' +
        or_where_field +
        '/or_where_value/' +
        or_where_value;

    try {
      final response = await http.delete(Uri.parse(uri));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Print error here
      return false;
    }
  }

  Future removeWhereLike(String token, String project, String collection,
      String appid, String wlike_field, String wlike_value) async {
    String uri = 'https://io.etter.cloud/v4/remove_where_like/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wlike_field/' +
        wlike_field +
        '/wlike_value/' +
        wlike_value;

    try {
      final response = await http.delete(Uri.parse(uri));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Print error here
      return false;
    }
  }

  Future removeWhereIn(String token, String project, String collection,
      String appid, String win_field, String win_value) async {
    String uri = 'https://io.etter.cloud/v4/remove_where_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/win_field/' +
        win_field +
        '/win_value/' +
        win_value;

    try {
      final response = await http.delete(Uri.parse(uri));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Print error here
      return false;
    }
  }

  Future removeWhereNotIn(String token, String project, String collection,
      String appid, String wnotin_field, String wnotin_value) async {
    String uri = 'https://io.etter.cloud/v4/remove_where_not_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wnotin_field/' +
        wnotin_field +
        '/wnotin_value/' +
        wnotin_value;

    try {
      final response = await http.delete(Uri.parse(uri));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Print error here
      return false;
    }
  }

  Future updateAll(String update_field, String update_value, String token,
      String project, String collection, String appid) async {
    String uri = 'https://io.etter.cloud/v4/update_all';

    try {
      final response = await http.put(Uri.parse(uri), body: {
        'update_field': update_field,
        'update_value': update_value,
        'token': token,
        'project': project,
        'collection': collection,
        'appid': appid
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future updateId(String update_field, String update_value, String token,
      String project, String collection, String appid, String id) async {
    String uri = 'https://io.etter.cloud/v4/update_id';

    try {
      final response = await http.put(Uri.parse(uri), body: {
        'update_field': update_field,
        'update_value': update_value,
        'token': token,
        'project': project,
        'collection': collection,
        'appid': appid,
        'id': id
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future updateWhere(
      String where_field,
      String where_value,
      String update_field,
      String update_value,
      String token,
      String project,
      String collection,
      String appid) async {
    String uri = 'https://io.etter.cloud/v4/update_where';

    try {
      final response = await http.put(Uri.parse(uri), body: {
        'where_field': where_field,
        'where_value': where_value,
        'update_field': update_field,
        'update_value': update_value,
        'token': token,
        'project': project,
        'collection': collection,
        'appid': appid
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future updateOrWhere(
      String or_where_field,
      String or_where_value,
      String update_field,
      String update_value,
      String token,
      String project,
      String collection,
      String appid) async {
    String uri = 'https://io.etter.cloud/v4/update_or_where';

    try {
      final response = await http.put(Uri.parse(uri), body: {
        'or_where_field': or_where_field,
        'or_where_value': or_where_value,
        'update_field': update_field,
        'update_value': update_value,
        'token': token,
        'project': project,
        'collection': collection,
        'appid': appid
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future updateWhereLike(
      String wlike_field,
      String wlike_value,
      String update_field,
      String update_value,
      String token,
      String project,
      String collection,
      String appid) async {
    String uri = 'https://io.etter.cloud/v4/update_where_like';

    try {
      final response = await http.put(Uri.parse(uri), body: {
        'wlike_field': wlike_field,
        'wlike_value': wlike_value,
        'update_field': update_field,
        'update_value': update_value,
        'token': token,
        'project': project,
        'collection': collection,
        'appid': appid
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future updateWhereIn(
      String win_field,
      String win_value,
      String update_field,
      String update_value,
      String token,
      String project,
      String collection,
      String appid) async {
    String uri = 'https://io.etter.cloud/v4/update_where_in';

    try {
      final response = await http.put(Uri.parse(uri), body: {
        'win_field': win_field,
        'win_value': win_value,
        'update_field': update_field,
        'update_value': update_value,
        'token': token,
        'project': project,
        'collection': collection,
        'appid': appid
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future updateWhereNotIn(
      String wnotin_field,
      String wnotin_value,
      String update_field,
      String update_value,
      String token,
      String project,
      String collection,
      String appid) async {
    String uri = 'https://io.etter.cloud/v4/update_where_not_in';

    try {
      final response = await http.put(Uri.parse(uri), body: {
        'wnotin_field': wnotin_field,
        'wnotin_value': wnotin_value,
        'update_field': update_field,
        'update_value': update_value,
        'token': token,
        'project': project,
        'collection': collection,
        'appid': appid
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future firstAll(
      String token, String project, String collection, String appid) async {
    String uri = 'https://io.etter.cloud/v4/first_all/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future firstWhere(String token, String project, String collection,
      String appid, String where_field, String where_value) async {
    String uri = 'https://io.etter.cloud/v4/first_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/where_field/' +
        where_field +
        '/where_value/' +
        where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future firstOrWhere(String token, String project, String collection,
      String appid, String or_where_field, String or_where_value) async {
    String uri = 'https://io.etter.cloud/v4/first_or_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/or_where_field/' +
        or_where_field +
        '/or_where_value/' +
        or_where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future firstWhereLike(String token, String project, String collection,
      String appid, String wlike_field, String wlike_value) async {
    String uri = 'https://io.etter.cloud/v4/first_where_like/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wlike_field/' +
        wlike_field +
        '/wlike_value/' +
        wlike_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future firstWhereIn(String token, String project, String collection,
      String appid, String win_field, String win_value) async {
    String uri = 'https://io.etter.cloud/v4/first_where_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/win_field/' +
        win_field +
        '/win_value/' +
        win_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future firstWhereNotIn(String token, String project, String collection,
      String appid, String wnotin_field, String wnotin_value) async {
    String uri = 'https://io.etter.cloud/v4/first_where_not_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wnotin_field/' +
        wnotin_field +
        '/wnotin_value/' +
        wnotin_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future lastAll(
      String token, String project, String collection, String appid) async {
    String uri = 'https://io.etter.cloud/v4/last_all/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future lastWhere(String token, String project, String collection,
      String appid, String where_field, String where_value) async {
    String uri = 'https://io.etter.cloud/v4/last_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/where_field/' +
        where_field +
        '/where_value/' +
        where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future lastOrWhere(String token, String project, String collection,
      String appid, String or_where_field, String or_where_value) async {
    String uri = 'https://io.etter.cloud/v4/last_or_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/or_where_field/' +
        or_where_field +
        '/or_where_value/' +
        or_where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future lastWhereLike(String token, String project, String collection,
      String appid, String wlike_field, String wlike_value) async {
    String uri = 'https://io.etter.cloud/v4/last_where_like/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wlike_field/' +
        wlike_field +
        '/wlike_value/' +
        wlike_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future lastWhereIn(String token, String project, String collection,
      String appid, String win_field, String win_value) async {
    String uri = 'https://io.etter.cloud/v4/last_where_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/win_field/' +
        win_field +
        '/win_value/' +
        win_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future lastWhereNotIn(String token, String project, String collection,
      String appid, String wnotin_field, String wnotin_value) async {
    String uri = 'https://io.etter.cloud/v4/last_where_not_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wnotin_field/' +
        wnotin_field +
        '/wnotin_value/' +
        wnotin_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future randomAll(
      String token, String project, String collection, String appid) async {
    String uri = 'https://io.etter.cloud/v4/random_all/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future randomWhere(String token, String project, String collection,
      String appid, String where_field, String where_value) async {
    String uri = 'https://io.etter.cloud/v4/random_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/where_field/' +
        where_field +
        '/where_value/' +
        where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future randomOrWhere(String token, String project, String collection,
      String appid, String or_where_field, String or_where_value) async {
    String uri = 'https://io.etter.cloud/v4/random_or_where/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/or_where_field/' +
        or_where_field +
        '/or_where_value/' +
        or_where_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future randomWhereLike(String token, String project, String collection,
      String appid, String wlike_field, String wlike_value) async {
    String uri = 'https://io.etter.cloud/v4/random_where_like/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wlike_field/' +
        wlike_field +
        '/wlike_value/' +
        wlike_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future randomWhereIn(String token, String project, String collection,
      String appid, String win_field, String win_value) async {
    String uri = 'https://io.etter.cloud/v4/random_where_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/win_field/' +
        win_field +
        '/win_value/' +
        win_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }

  Future randomWhereNotIn(String token, String project, String collection,
      String appid, String wnotin_field, String wnotin_value) async {
    String uri = 'https://io.etter.cloud/v4/random_where_not_in/token/' +
        token +
        '/project/' +
        project +
        '/collection/' +
        collection +
        '/appid/' +
        appid +
        '/wnotin_field/' +
        wnotin_field +
        '/wnotin_value/' +
        wnotin_value;

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Return an empty array
        return '[]';
      }
    } catch (e) {
      // Print error here
      return '[]';
    }
  }
}
