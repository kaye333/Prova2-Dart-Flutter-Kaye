import 'package:flutter/material.dart';
import 'components/backButton.dart';
import 'components/title.dart';

class User extends StatefulWidget {
  const User(this.name, {Key? key}) : super(key: key);
  final String name;
  @override
  State<StatefulWidget> createState() {
    return UserState();
  }
}

class UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff03befc), Color(0xff000000)])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const TitleBanner(),
                const SizedBox(
                  height: 80,
                ),
                Text(
                  'Bem vindo \n ${widget.name}!',
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const Positioned(top: 40, left: 0, child: BackB()),
      ],
    )));
  }
}
