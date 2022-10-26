import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:moneyapp/config/app_color.dart';
import 'package:moneyapp/presentation/controller/c_user.dart';

import '../../../config/app_format.dart';
import '../controller_history/c_detail_history.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage({Key? key, required this.iduser, required this.date})
      : super(key: key);
  final String iduser;
  final String date;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final cDetailHistory = Get.put(CDetailHistory());
  final cUser = Get.put(CUser());

  @override
  void initState() {
    cDetailHistory.getData(widget.iduser, widget.date);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.south_west, color: Colors.black),
        ],
        title: Obx(() {
          return Text(
            cDetailHistory.data.date == null
                ? ''
                : AppFormat.date(cDetailHistory.data.date!),
          );
        }),
        titleSpacing: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Total'),
        DView.spaceHeight(8),
        Text('Rp. 300.000,00'),
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
                    ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text('${index + 1}.'),
                        DView.spaceWidth(8),
                        Expanded(child: Text('Bakso')),
                        Text('Rp. 10.000')
                      ],
                    ),
                  );
                }))
      ]),
    );
  }
}
