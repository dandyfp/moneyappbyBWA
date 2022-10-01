import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/config/app_asset.dart';
import 'package:moneyapp/config/app_color.dart';
import 'package:moneyapp/config/session.dart';
import 'package:moneyapp/page/auth/login_page.dart';
import 'package:moneyapp/presentation/controller/c_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Row(
              children: [
                Image.asset(AppAsset.profile),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Obx(() {
                        return Text(
                          cUser.data.name ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        );
                      }),
                    ],
                  ),
                ),
                Builder(builder: (ctx) {
                  return Material(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.chart,
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(ctx).openEndDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.menu,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
// Center(
//         child: Row(
//           children: [
//             Text(
//               'Home Page',
//             ),
//             IconButton(
//               onPressed: () {
//                 Session.clearUser();
//                 Get.off(() => const LoginPage());
//               },
//               icon: Icon(Icons.login_outlined),
//             ),
//           ],
//         ),
//       ),