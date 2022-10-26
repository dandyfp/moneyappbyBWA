import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/config/app_asset.dart';
import 'package:moneyapp/config/app_color.dart';
import 'package:moneyapp/config/app_format.dart';
import 'package:moneyapp/config/session.dart';
import 'package:moneyapp/page/auth/history/add_history_page.dart';
import 'package:moneyapp/page/auth/history/detail_history_page.dart';
import 'package:moneyapp/page/auth/history/history_page.dart';
import 'package:moneyapp/page/auth/history/income_outcome_page.dart';
import 'package:moneyapp/page/auth/login_page.dart';
import 'package:moneyapp/presentation/controller/c_home.dart';
import 'package:moneyapp/presentation/controller/c_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());
  final cHome = Get.put(CHome());

  @override
  void initState() {
    cHome.getAnalysis(cUser.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawer(),
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
            child: RefreshIndicator(
              onRefresh: (() async {
                cHome.getAnalysis(cUser.data.idUser!);
              }),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                children: [
                  const Text(
                    'Pengeluaran hari ini',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  cardToday(context),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      height: 8,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColor.bg,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Pengeluaran hari ini',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  DView.spaceHeight(30),
                  weekly(),
                  SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Perbandingan bulan ini',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  monthly(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(bottom: 0),
            padding: EdgeInsets.fromLTRB(20, 16, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppAsset.profile),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              cUser.data.name ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            );
                          }),
                          Obx(() {
                            return Text(
                              cUser.data.email ?? '',
                              style: TextStyle(fontSize: 20),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                Material(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Session.clearUser();
                      Get.off(() => const LoginPage());
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 5,
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => AddHistoryPage())?.then((value) {
                if (value ?? false) {
                  cHome.getAnalysis(cUser.data.idUser!);
                }
              });
            },
            leading: Icon(Icons.add),
            horizontalTitleGap: 0,
            title: Text('Tambah baru'),
            trailing: Icon(Icons.navigate_next),
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Get.to(() => IncomeOutcomPage(type: "Pemasukan"));
            },
            leading: Icon(Icons.south_west),
            horizontalTitleGap: 0,
            title: Text('Pemasukan'),
            trailing: Icon(Icons.navigate_next),
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Get.to(() => IncomeOutcomPage(
                    type: 'Pengeluaran',
                  ));
            },
            leading: Icon(Icons.north_east),
            horizontalTitleGap: 0,
            title: Text('Pengeluaran'),
            trailing: Icon(Icons.navigate_next),
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            onTap: () {
              Get.to(() => const HistoryPage());
            },
            leading: Icon(Icons.history),
            horizontalTitleGap: 0,
            title: Text('Riwayat'),
            trailing: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  AspectRatio weekly() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Obx(() {
        return DChartBar(
          data: [
            {
              'id': 'Bar',
              'data': List.generate(7, (index) {
                return {
                  'domain': cHome.weekText()[index],
                  'measure': cHome.week[index]
                };
              })
            },
          ],
          domainLabelPaddingToAxisLine: 8,
          axisLineTick: 2,
          //axisLinePointTick: 2,
          //axisLinePointWidth: 10,
          axisLineColor: AppColor.primary,
          measureLabelPaddingToAxisLine: 16,
          barColor: (barData, index, id) => AppColor.primary,
          showBarValue: true,
        );
      }),
    );
  }

  Row monthly(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Obx(() {
                return DChartPie(
                  data: [
                    {'domain': 'income', 'measure': cHome.monthIncome},
                    {'domain': 'outcome', 'measure': cHome.monthOutcome},
                    if (cHome.monthIncome == 0 && cHome.monthOutcome == 0)
                      {'domain': 'nol', 'measure': 1},
                  ],
                  fillColor: (pieData, index) {
                    switch (pieData['domain']) {
                      case 'income':
                        return AppColor.primary;
                      case 'outcome':
                        return AppColor.chart;

                      default:
                        return AppColor.bg.withOpacity(0.5);
                    }
                  },
                  donutWidth: 20,
                  labelColor: Colors.transparent,
                  showLabelLine: false,
                );
              }),
              Center(
                child: Obx(() {
                  return Text(
                    '${cHome.percentIncome}%',
                    style: TextStyle(fontSize: 34, color: AppColor.primary),
                  );
                }),
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: AppColor.primary,
                ),
                DView.spaceWidth(8),
                Text('Pemasukan'),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: AppColor.chart,
                ),
                DView.spaceWidth(8),
                const Text('Pengeluaran'),
              ],
            ),
            DView.spaceHeight(20),
            Obx(() {
              return Text(cHome.monthPercent);
            }),
            DView.spaceHeight(10),
            const Text('Atau setara'),
            Text(
              AppFormat.currency(cHome.differentMonth.toString()),
              style: const TextStyle(
                fontSize: 18,
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Obx(() {
              return Text(
                AppFormat.currency(cHome.today.toString()),
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondary,
                    ),
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 20, 20),
            child: Obx(() {
              return Text(
                cHome.todayPercent,
                style: TextStyle(color: AppColor.bg, fontSize: 16),
              );
            }),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => DetailHistoryPage(
                  type: 'Pengeluaran',
                  iduser: cUser.data.idUser!,
                  date: DateFormat('yyyy-MM-dd').format(
                    DateTime.now(),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Selengkapnya',
                      style: TextStyle(color: AppColor.primary, fontSize: 16),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: AppColor.primary,
                    ),
                  ]),
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