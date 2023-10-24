import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: ourStyle(
              color: blackColor,
              family: bold,
              size: 32,
            ),
          ),
        ),
        body: const Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/robot.png'),
              radius: 60,
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('FLutter Mapp'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('info@fluttermapp.com'),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('FLutterMapp.com'),
            ),
          ],
        ));
  }
}
