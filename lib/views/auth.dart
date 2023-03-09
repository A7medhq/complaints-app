import 'package:flutter/material.dart';

import '../components/auth_textfield.dart';
import '../components/toggle_button.dart';
import '../constants.dart';
import '../models/response_model.dart';
import '../services/auth_services.dart';

class AuthScreen extends StatefulWidget {
  static const id = '/authScreen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String switched = 'login';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =
      TextEditingController(text: 'o@o.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffbf8),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -200,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          //  const BackgroundCurve(),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 32.0, right: 32.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 36),
                    child: Image.asset(
                      'assets/image.png',
                      width: 200,
                    ),
                  ),
                  Center(
                      child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    duration: const Duration(milliseconds: 400),
                    height: switched == 'login' ? 410 : 515,
                    decoration: BoxDecoration(
                      color: Color(0xfffcf7ee),
                      borderRadius: BorderRadius.circular(36),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 36, horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ToggleButton(
                            width: 250.0,
                            height: 40.0,
                            toggleBackgroundColor: Color(0xfffcf7ee),
                            toggleBorderColor: (Colors.grey[350])!,
                            toggleColor: kPrimaryColor,
                            activeTextColor: Color(0xfffcf7ee),
                            inactiveTextColor: kPrimaryColor,
                            leftDescription: 'Login',
                            rightDescription: 'Register',
                            onLeftToggleActive: () {
                              setState(() {
                                switched = 'login';
                              });
                            },
                            onRightToggleActive: () {
                              setState(() {
                                switched = 'register';
                              });
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 400),
                            reverseDuration: const Duration(milliseconds: 200),
                            firstChild: Container(),
                            secondChild: Column(
                              children: [
                                AuthTextField(
                                    hint: 'Name', controller: nameController),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            crossFadeState: switched == 'login'
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          ),
                          AuthTextField(
                              hint: 'Enter email or username',
                              controller: emailController),
                          const SizedBox(
                            height: 8,
                          ),
                          AuthTextField(
                              hint: 'Enter password',
                              controller: passwordController),
                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 400),
                            reverseDuration: const Duration(milliseconds: 200),
                            firstChild: Container(),
                            secondChild: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                AuthTextField(
                                    hint: 'Confirm password',
                                    controller: passwordConfirmationController),
                              ],
                            ),
                            crossFadeState: switched == 'login'
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(24),
                            color: kPrimaryColor,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: switched == 'login'
                                  ? () async {
                                      ResponseModel userInfo =
                                          await AuthServices.login(
                                              password: passwordController.text,
                                              email: emailController.text);

                                      if (userInfo.data != null && mounted) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/', (_) => false);
                                      } else {
                                        if (mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Invalid credentials')));
                                        }
                                      }
                                    }
                                  : () async {
                                      AuthServices.register(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            passwordConfirmationController.text,
                                        context: context,
                                      );
                                    },
                              child: SizedBox(
                                width: 260,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    switched.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text('OR'),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {}, icon: const Icon(Icons.add))
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
