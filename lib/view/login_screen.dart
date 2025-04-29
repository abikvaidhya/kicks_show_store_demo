import 'package:demo_task/controller/login_controller.dart';
import 'package:demo_task/view/dashboard_screen.dart';
import 'package:demo_task/view/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.find<LoginController>();

  @override
  initState() {
    super.initState();
  }

  loadAsset() async {
    await rootBundle.loadString('assets/images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Welcome,',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Please login to continue.'),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
              ),
              Form(
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      controller: loginController.username.value,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      controller: loginController.passcode.value,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Forgot password? '),
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Reset here.',
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the radius as needed
                      ),
                    ),
                    onPressed: () => Get.offAll(const DashboardScreen()),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
              ),
              Column(
                spacing: 5,
                children: [
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                        endIndent: 10,
                        indent: 10,
                      )),
                      Text('Or, login using'),
                      Expanded(
                          child: Divider(
                        endIndent: 10,
                        indent: 10,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Image.asset(
                        'assets/images/gmail.png',
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Don't have an account yet? "),
                  GestureDetector(
                      onTap: () => Get.to(() => const RegistrationScreen()),
                      child: const Text(
                        'Sign up here.',
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              ),
              const SizedBox.shrink(),
            ],
          ),
        ));
  }
}
