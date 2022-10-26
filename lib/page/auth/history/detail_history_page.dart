import 'dart:convert';

import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/config/app_color.dart';
import 'package:moneyapp/presentation/controller/c_user.dart';

import '../../../config/app_format.dart';
import '../controller_history/c_detail_history.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage(
      {Key? key, required this.iduser, required this.date, required this.type})
      : super(key: key);
  final String iduser;
  final String date;
  final String type;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHistory = Get.put(CDetailHistory());
  final cUser = Get.put(CUser());

  @override
  void initState() {
    cDetailHistory.getData(widget.iduser, widget.date, widget.type);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(() {
          if (cDetailHistory.data.date == null) return DView.nothing();

          return Row(
            children: [
              Expanded(
                child: Text(
                  AppFormat.date(cDetailHistory.data.date!),
                ),
              ),
              cDetailHistory.data.type == 'Pemasukan'
                  ? Icon(
                      Icons.south_west,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.north_east,
                      color: Colors.red,
                    ),
              DView.spaceWidth(),
            ],
          );
        }),
      ),
      body: GetBuilder<CDetailHistory>(builder: (_) {
        if (_.data.date == null) {
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          if (widget.date == today && widget.type == 'Pengeluaran') {
            return DView.empty('Belum ada data');
          }
          return DView.nothing();
        }
        List details = jsonDecode(_.data.detail!);

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Total',
                style: TextStyle(
                  color: AppColor.primary.withOpacity(0.6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Text(
              AppFormat.currency(_.data.total!),
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: AppColor.primary),
            ),
          ),
          DView.spaceHeight(20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.bg,
                borderRadius: BorderRadius.circular(30),
              ),
              height: 8,
              width: 90,
            ),
          ),
          DView.spaceHeight(20),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      thickness: 0.6,
                    ),
                itemCount: details.length,
                itemBuilder: (context, index) {
                  Map item = details[index];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}.',
                          style: TextStyle(fontSize: 20),
                        ),
                        DView.spaceWidth(8),
                        Expanded(
                          child: Text(item['name'],
                              style: TextStyle(fontSize: 20)),
                        ),
                        Text(
                          AppFormat.currency(item['price']),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ]);
      }),
    );
  }
}
