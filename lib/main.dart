import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "OBS Stream Indicator",
      home: FirebaseConnection(),
    );
  }
}

class FirebaseConnection extends StatefulWidget {
  const FirebaseConnection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FirebaseState();
  }
}

class _FirebaseState extends State<FirebaseConnection> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const _ErrorWidget(
                'There was a problem connecting to the server. Please try again later.');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const HomePage();
          }

          return const _LoadingWidget();
        });
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
  // Obs Status
  bool isOnline = false;
  Color _backgroundColor = Colors.red;
  String _message = 'Offline';

  // TODO: Add firebase logic
  void _changeStatus() {
    setState(() {
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

// Widgets
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget(this._message);

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
        ),
        Center(
          child: Text(
            _message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
