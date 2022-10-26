import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/config/app_color.dart';
import 'package:moneyapp/config/app_format.dart';
import 'package:moneyapp/data/model/history.dart';
import 'package:moneyapp/data/source/source_history.dart';
import 'package:moneyapp/page/auth/controller_history/c_income_outcome.dart';
import 'package:moneyapp/page/auth/history/update_history_page.dart';
import 'package:moneyapp/presentation/controller/c_user.dart';

import '../controller_history/c_history.dart';
import 'detail_history_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final cHistory = Get.put(Chistory());
  final cUser = Get.put(CUser());
  final ControllerSearch = TextEditingController();

  refresh() {
    cHistory.getList(cUser.data.idUser);
  }

  delete(String idHistory) async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Hapus', 'Yakin untuk menghapus history ini?',
        textNo: 'Batal', textYes: 'Ya');
    if (yes!) {
      bool success = await SourceHistory.delete(idHistory!);
      if (success) {
        refresh();
      }
      ;
    }
  }

  @override
  void initState() {
    refresh();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Text('Riwayat'),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(16),
                child: TextField(
                  controller: ControllerSearch,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );
                    if (result != null) {
                      ControllerSearch.text =
                          DateFormat('yyy-MM-dd').format(result);
                    }
                  },
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: AppColor.chart.withOpacity(0.5),
                    suffixIcon: IconButton(
                        onPressed: () {
                          cHistory.search(
                              cUser.data.idUser, ControllerSearch.text);
                        },
                        icon: Icon(Icons.search, color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<Chistory>(builder: (_) {
        if (_.loading) return DView.loadingCircle();
        if (_.list.isEmpty) return DView.empty('kosong');
        return RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
              itemCount: _.list.length,
              itemBuilder: (context, index) {
                History history = _.list[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                      index == _.list.length - 1 ? 16 : 8),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => DetailHistoryPage(
                            date: history.date!,
                            iduser: cUser.data.idUser!,
                          ));
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Row(
                      children: [
                        DView.spaceWidth(),
                        history.type == 'Pemasukan'
                            ? Icon(Icons.south_west, color: Colors.green)
                            : Icon(Icons.north_east, color: Colors.red),
                        DView.spaceWidth(),
                        Text(
                          AppFormat.date(history.date!),
                          style: const TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppFormat.currency(history.total!),
                            style: const TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        IconButton(
                            onPressed: () => delete(history.idHistory!),
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                );
              }),
        );
      }),
    );
  }
}
