import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/data/source/source_history.dart';
import 'package:moneyapp/presentation/controller/c_user.dart';

import '../../../config/app_color.dart';
import '../../../config/app_format.dart';
import '../controller_history/c_update_history.dart';

class UpdateHistoryPage extends StatefulWidget {
  const UpdateHistoryPage(
      {Key? key, required this.date, required this.idHistory})
      : super(key: key);
  final String date;
  final String idHistory;
  @override
  State<UpdateHistoryPage> createState() => _UpdateHistoryPageState();
}

class _UpdateHistoryPageState extends State<UpdateHistoryPage> {
  final cUpdateHistory = Get.put(CUpdateHistory());
  final controllerPrice = TextEditingController();
  final controllerName = TextEditingController();
  final cUser = Get.put(CUser());

  updateHistory() async {
    bool success = await SourceHistory.update(
      widget.idHistory,
      cUser.data.idUser!,
      cUpdateHistory.date,
      cUpdateHistory.type,
      jsonEncode(cUpdateHistory.items),
      cUpdateHistory.total.toString(),
    );

    if (success) {
      Future.delayed(Duration(milliseconds: 3000), () {
        Get.back(result: true);
      });
    }
  }

  @override
  void initState() {
    cUpdateHistory.init(cUser.data.idUser, widget.date);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cHome;
    return Scaffold(
      appBar: DView.appBarLeft('Update'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Tanggal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Obx(() {
                return Text(cUpdateHistory.date);
              }),
              DView.spaceWidth(16),
              ElevatedButton.icon(
                onPressed: () async {
                  DateTime? result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022, 01, 01),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (result != null) {
                    cUpdateHistory
                        .setDate(DateFormat('yyyy-MM-dd').format(result));
                  }
                },
                icon: Icon(Icons.event),
                label: Text('Pilih'),
              ),
            ],
          ),
          DView.spaceHeight(),
          Text(
            'Tipe',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Obx(() {
            return DropdownButtonFormField(
              value: cUpdateHistory.type,
              items: ['Pemasukan', 'Pengeluaran'].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                cUpdateHistory.setType(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
            );
          }),
          DView.spaceHeight(),
          DInput(
              controller: controllerName,
              hint: 'Jualan',
              title: 'Sumber/Objek pengeluaran'),
          DView.spaceHeight(),
          DInput(
              controller: controllerPrice,
              hint: '3000',
              title: 'Harga',
              inputType: TextInputType.number),
          DView.spaceHeight(),
          ElevatedButton(
            onPressed: () {
              cUpdateHistory.addItem(
                {'name': controllerName.text, 'price': controllerPrice.text},
              );
              controllerName.clear();
              controllerPrice.clear();
            },
            child: const Text('Tamabah ke items'),
          ),
          DView.spaceHeight(),
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
            ),
          ),
          DView.spaceHeight(),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GetBuilder<CUpdateHistory>(builder: (_) {
              return Wrap(
                spacing: 8,
                runSpacing: 0,
                children: List.generate(_.items.length, (index) {
                  return Chip(
                    label: Text(_.items[index]['name']),
                    deleteIcon: Icon(Icons.clear),
                    onDeleted: () => _.deleteItems(index),
                  );
                }),
              );
            }),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              Text(
                'Total :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DView.spaceWidth(8),
              Obx(() {
                return Text(
                  AppFormat.currency(cUpdateHistory.total.toString()),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                );
              })
            ],
          ),
          DView.spaceHeight(30),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () => updateHistory(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
