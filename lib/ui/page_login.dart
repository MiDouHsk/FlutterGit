import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/square_title.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:flutter_application_2/ui/page_forgot.dart';
import 'package:flutter_application_2/ui/page_register.dart';
import 'package:provider/provider.dart';

import '../providers/loginviewmodel.dart';
import 'custom_control.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;

    if (viewmodel.status == 3) {
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppLogo(),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Wellcome back",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        "you've been missed!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //user name textfield
                      CustomTextField(
                        hintText: "Username",
                        textController: _emailController,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //password textfield
                      CustomTextField(
                        hintText: "Password",
                        textController: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // forgot password
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .popAndPushNamed(PageForgot.routename),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "forgot password?",
                                style: AppConstant.textlink,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ), // error messege
                      viewmodel.status == 2
                          ? Text(
                              viewmodel.errorMessage,
                              style: const TextStyle(color: Colors.red),
                            )
                          : const Text(" "),
                      const SizedBox(height: 10),
                      // button login
                      GestureDetector(
                        onTap: () {
                          String username = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          viewmodel.login(username, password);
                        },
                        child: const CustomButton(
                          textButton: "Login",
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // or continue with
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: .5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "or continue with",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: .5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      //  google + apple sign in buttons.
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //google button
                          SquareTitle(imagePath: 'assets/images/google.png'),
                          SizedBox(width: 25),
                          // apple button
                          SquareTitle(imagePath: 'assets/images/apple.png'),
                        ],
                      ),

                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Not a member?",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(PageRegister.routename),
                            child: const Text(
                              "register now",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
