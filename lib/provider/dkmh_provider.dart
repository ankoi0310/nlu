import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:nlu/constant/api.dart';

import '../domain/schedule.dart';
import '../domain/user.dart';

class DKMHProvider with ChangeNotifier {
  late String accessToken;
  late int _statusCode;
  late String errorMessage;
  late User? _user;
  late Schedule? _schedule;

  String get error => errorMessage;

  int get statusCode => _statusCode;

  User? get user => _user;

  Schedule? get schedule => _schedule;

  Future<bool> checkLogin(username, password) async {
    try {
      Response response = await post(
        Uri.parse(apiLogin),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
      );

      _statusCode = response.statusCode;
      if (response.statusCode == 200) {
        accessToken = json.decode(utf8.decode(response.bodyBytes))['access_token'];
        await getUserInfo();
        await getSchedule(
          year: '2022',
          semester: '2',
        );
        return true;
      }

      errorMessage = json.decode(utf8.decode(response.bodyBytes))['message'];
    } catch (_) {}
    return false;
  }

  Future<bool> logout() async {
    try {
      Response response = await post(
        Uri.parse(apiLogout),
      );

      if (response.statusCode == 200) {
        accessToken = '';
        _user = null;
        _schedule = null;
        return true;
      }
      errorMessage = json.decode(utf8.decode(response.bodyBytes));
    } catch (_) {}
    return false;
  }

  Future<void> getUserInfo() async {
    try {
      Response response = await post(
        Uri.parse(apiUserInfo),
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (response.statusCode == 200) {
        _user = User.fromJson(json.decode(utf8.decode(response.bodyBytes))['data']);
      } else {
        throw Exception('Failed to get user info');
      }
    } catch (_) {}
  }

  Future<void> getSchedule({required String year, required String semester}) async {
    try {
      Response response = await post(
        Uri.parse(apiSchedule),
        headers: {"Authorization": "Bearer $accessToken", 'Content-Type': 'application/json'},
        body: json.encode({
          'hoc_ky': year + semester,
          'id_du_lieu': null,
          'loai_doi_tuong': 1,
        }),
      );

      if (response.statusCode == 200) {
        _schedule = Schedule.fromJson(json.decode(utf8.decode(response.bodyBytes))['data']);
      } else {
        throw Exception('Failed to get schedule');
      }
    } catch (_) {}
  }
}
