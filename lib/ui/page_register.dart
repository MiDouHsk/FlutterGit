import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/providers/registerviewmodel.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:flutter_application_2/ui/custom_control.dart';
import 'package:flutter_application_2/ui/page_login.dart';

import 'package:provider/provider.dart';

import 'page_main.dart';

class PageRegister extends StatelessWidget {
  PageRegister({super.key});
  static String routename = '/register';
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cpassController = TextEditingController();
  bool agree = true;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<RegisterViewModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    if (profile.token == null) // kiem tra da dang nhap
    {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageMain(),
              ));
        },
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: viewmodel.status == 3 || viewmodel.status == 4
                ? Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/bronya_stick.gif"),
                      ),
                      Text(
                        "dang ki thanh cong",
                        style: AppConstant.textfancyheader,
                      ),
                      viewmodel.status == 3
                          ? Text(
                              "Ban can xac nhan Email de hoang thanh dang ky!")
                          : Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageLogin.routename),
                            child: Text(
                              "Bam vao day ",
                              style: AppConstant.textlink,
                            ),
                          ),
                          Text("de dang nhap")
                        ],
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppLogo(),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Create an account,",
                                style: AppConstant.textfancyheader2,
                              ),
                              Text(
                                " Open the door to your world.",
                                style: AppConstant.textfancyheader2,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                  textController: _emailController,
                                  hintText: 'Email',
                                  obscureText: false),
                              SizedBox(height: 10),
                              CustomTextField(
                                  textController: _usernameController,
                                  hintText: 'Username',
                                  obscureText: false),
                              SizedBox(height: 10),
                              CustomTextField(
                                  textController: _passController,
                                  hintText: 'Password',
                                  obscureText: false),
                              SizedBox(height: 10),
                              CustomTextField(
                                  textController: _cpassController,
                                  hintText: 'Re-password',
                                  obscureText: false),
                              SizedBox(height: 10),
                              Text(
                                viewmodel.errormessage,
                                style: AppConstant.textError,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      value: viewmodel.agree,
                                      onChanged: (value) {
                                        viewmodel.setAgree(value!);
                                      }),
                                  Text("Dong y "),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: Text("quy dinh"),
                                            content: SingleChildScrollView(
                                                child:
                                                    Text(viewmodel.quydinh))),
                                      );
                                    },
                                    child: Text(
                                      'Quy Dinh',
                                      style: AppConstant.textlink,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    final email = _emailController.text.trim();
                                    final username =
                                        _usernameController.text.trim();
                                    final pass = _passController.text.trim();
                                    final cpass = _cpassController.text.trim();

                                    viewmodel.register(
                                        email, username, pass, cpass);
                                  },
                                  child:
                                      ButtonRegister(textButton: 'Register')),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .popAndPushNamed(PageLogin.routename),
                                child: Text(
                                  "<< Dang Nhap",
                                  style: AppConstant.textlink,
                                ),
                              )
                            ]),
                      ),
                      viewmodel.status == 1
                          ? CustomSpinner(size: size)
                          : Container(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
