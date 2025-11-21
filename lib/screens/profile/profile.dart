import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_guessing_v2/components/Provider/statusmodel.dart';
import 'package:pokemon_guessing_v2/utility/constants.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Status>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: light_blue,
        appBar: AppBar(
          title: const Text(
            "P R O F I L E",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            const Text(
              "Y O U   G U E S S E D",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            Text("${value.guessed.length} / 721   P O K E M O N",
                style: const TextStyle(color: Colors.white, fontSize: 17)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSwitch(
                  value: value.isEasyMode,
                  onChanged: (bool newValue) => value.changeMode(),
                  thumbColor: blue,
                  activeColor: Colors.white,
                  trackColor: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "E A S Y   M O D E",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () {},
              onLongPress: () {
                Provider.of<Status>(context, listen: false).clearIds();
              },
              icon: const Icon(
                CupertinoIcons.trash,
                color: red,
              ),
              label: const Text(
                "D E L E T E",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
