import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "OBS Stream Indicator",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  // Internet Status
  bool isConnected = true;
  // Obs Status
  bool isOnline = false;
  Color _backgroundColor = Colors.red;
  String _message = 'Offline';

  // TODO: Add firebase logic
  void _changeStatus() {
    setState(() {
      if (isConnected) {
        if (isOnline) {
          // Online
          _backgroundColor = Colors.green;
          _message = 'Live';

          // For Testing Purposes
          isOnline = false;
        } else {
          // Offline
          _backgroundColor = Colors.red;
          _message = 'Offline';

          // For Testing Purposes
          isOnline = true;
        }
      } else {
        _backgroundColor = Colors.black;
        _message = 'error';
      }
    });
  }

  @override
  Widget build(Object context) {
    double _fontSize = MediaQuery.of(super.context).size.width / 5;

    return Scaffold(
      body: Stack(
        children: [
          // Replace with Firebase
          GestureDetector(
            onTap: _changeStatus,
            child: Container(
              height: MediaQuery.of(super.context).size.height,
              width: MediaQuery.of(super.context).size.width,
              color: _backgroundColor,
            ),
          ),
          Center(
            child: Text(
              _message.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: _fontSize,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
