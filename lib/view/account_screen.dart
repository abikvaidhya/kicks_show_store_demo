import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import 'ui_helpers.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UIUtils uiUtils = UIUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: uiUtils.customAppBar(title: 'Profile', showAction: false),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/backgrounds/dark_green.jpg',
                ),
                opacity: 0.8,
                fit: BoxFit.cover,
              ),
            ),
            child: BlurryContainer(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox.shrink(),
                  Center(
                      child: Image.asset(
                    'assets/images/man.png',
                    height: 100,
                  )),
                  const Column(
                    spacing: 5,
                    children: [
                      Text(
                        'Abik Vaidhya',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'abikvaidhya@gmail.com',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      Text(
                        '+977-(986)-908-0265',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
