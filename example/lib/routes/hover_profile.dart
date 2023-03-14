import 'package:flutter/material.dart';
import 'package:avatar_hover/avatar_hover.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool online = true;
  final GlobalKey _avatarKey = GlobalKey();
  void _cambioOnline() {
    setState(() {
      online = !online;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 3,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarHover(
                url: 'https://avatars.githubusercontent.com/u/62195353?s=90',
                context: context,
                hoverMenu: true,
                online: online,
                widgetKey: _avatarKey,
                colors: const [
                  Color(0xFF0400FF),
                  Color(0xFFFF0026),
                  Color(0xFFFFBF00),
                  Color(0xFF00FF0C),
                ]
            ),
            const SizedBox(
              width: 16
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "User",
                  style: TextStyle(
                    fontSize: 24
                  ),
                )
              ]
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _cambioOnline,
        tooltip: 'TEST',
        mouseCursor: SystemMouseCursors.basic,
        child: const Icon(Icons.add),
      ),
    );
  }
}
