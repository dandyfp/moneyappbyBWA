import 'package:d_info/d_info.dart';
import 'package:moneyapp/config/api.dart';
import 'package:moneyapp/config/app_request.dart';
import 'package:moneyapp/config/session.dart';
import 'package:moneyapp/data/model/user.dart';

class SourceUser {
  static Future<bool> login(String email, String password) async {
    String url = '${Api.user}login.php';
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });

    if (responseBody == null) {
      return false;
    }

    if (responseBody['success']) {
      var mapUser = responseBody['data'];
      Session.saveUser(User.fromJson(mapUser));
    }

    return responseBody['success'];
  }

  static Future<bool> register(
      String namne, String email, String password) async {
    String url = '${Api.user}register.php';
    Map? responseBody = await AppRequest.post(url, {
      'name': namne,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (responseBody == null) {
      return false;
    }

    if (responseBody['success']) {
      var mapUser = responseBody['data'];

      DInfo.dialogSuccess('berhasil Register');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'email') {
        DInfo.dialogError('email sudah terdaftar');
      } else {
        DInfo.dialogError('gagal register');
      }
      DInfo.closeDialog();
    }

    return responseBody['success'];
  }
}
