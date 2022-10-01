import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:moneyapp/config/app_asset.dart';
import 'package:moneyapp/config/app_color.dart';
import 'package:moneyapp/page/auth/home_page.dart';

import '../../data/source/source_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  register() async {
    if (formKey.currentState!.validate()) {
      await SourceUser.register(
          controllerName.text, controllerEmail.text, controllerPassword.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DView.nothing(),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Image.asset(AppAsset.logo),
                        DView.spaceHeight(40),
                        TextFormField(
                          controller: controllerName,
                          validator: (value) =>
                              value == '' ? 'jangan kosong' : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            fillColor: AppColor.primary.withOpacity(0.5),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'name',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                        DView.spaceHeight(16),

                        TextFormField(
                          controller: controllerEmail,
                          validator: (value) =>
                              value == '' ? 'jangan kosong' : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            fillColor: AppColor.primary.withOpacity(0.5),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'email',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                        DView.spaceHeight(16),

                        //keterangan bila textfield tidak di isi
                        TextFormField(
                          controller: controllerPassword,
                          validator: (value) =>
                              value == '' ? 'jangan kosong' : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            fillColor: AppColor.primary.withOpacity(0.5),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'password',
                            isDense:
                                true, // agar tulisan di kolom password menjadi ***
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                        DView.spaceHeight(30),
                        Material(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () => register(),
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 16),
                              child: Text(
                                'REGISTER',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
