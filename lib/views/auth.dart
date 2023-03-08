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
  TextEditingController emailController =
      TextEditingController(text: 'o@o.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 36),
                    child: Text(
                      'AH',
                      style: TextStyle(fontSize: 80, color: Colors.white),
                    ),
                  ),
                  Center(
                      child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: switched == 'login' ? 470 : 520,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            width: 300.0,
                            height: 45.0,
                            toggleBackgroundColor: Colors.white,
                            toggleBorderColor: (Colors.grey[350])!,
                            toggleColor: const Color(0xff3A98B9),
                            activeTextColor: Colors.white,
                            inactiveTextColor: const Color(0xff3A98B9),
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
                            height: 24,
                          ),
                          AuthTextField(
                              hint: 'Enter email or username',
                              controller: emailController),
                          const SizedBox(
                            height: 12,
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
                                  height: 12,
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
                            height: 36,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xff3A98B9),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(24),
                              onTap: () async {
                                ResponseModel userInfo = await AuthServices()
                                    .login(
                                        password: passwordController.text,
                                        email: emailController.text);

                                if (userInfo.data != null && mounted) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (_) => false);
                                } else {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Invalid credentials')));
                                  }
                                }
                              },
                              child: SizedBox(
                                width: 260,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    switched,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text('OR'),
                          const SizedBox(
                            height: 24,
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
