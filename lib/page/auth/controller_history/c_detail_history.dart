import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/data/model/history.dart';

import '../../../data/source/source_history.dart';

class CDetailHistory extends GetxController {
  final _data = History().obs;
  History get data => _data.value;

  getData(idUser, date, type) async {
    History? history = await SourceHistory.detail(idUser, date, type);
    _data.value = history ?? History();
    update();
  }
}
