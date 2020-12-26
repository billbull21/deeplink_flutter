import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomeApp extends StatefulWidget {
  @override
  _MyHomeAppState createState() => new _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {

  final stream = const EventChannel('events');
  StreamController<String> _stateController = StreamController();
  //Method channel creation
  static const platform = const MethodChannel('channel');

  @override
  initState() {
    super.initState();
    //Checking application start by deep link
    startUri().then(_onRedirected).catchError((e) => print("unavailable link"));
    //Checking broadcast stream, if deep link was clicked in opened appication
    stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
  }

  _onRedirected(String uri) {
    // Here can be any uri analysis, checking tokens etc, if it’s necessary
    // Throw deep link URI into the BloC's stream
    print("URI LAUNCH : $uri");
    final links = Uri.parse(uri);
    print("URI LAUNCH PATH : ${links.path}");
    print("URI LAUNCH PATH SEGMENTS : ${links.pathSegments}");
    print("URI LAUNCH QUERY : ${links.queryParameters}");

    // you can redirect to another page by listen the path segments
    // EG: product/shoes -> then i want to redirect to product screen

    _stateController.sink.add(uri); // ignore this if you wanted to redirect to another page
  }

  Future<String> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      throw(e);
    }
  }

  @override
  dispose() {
    if (_stateController != null) _stateController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plugin example app'),
      ),
      body: StreamBuilder<String>(
        stream: _stateController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                child: Center(
                    child: Text('No deep link was used  ')));
          } else {
            final links = Uri.parse(snapshot.data);
            return Container(
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('Redirected: ${links.path} - ${links.query}'))));
          }
        },
      ),
    );
  }
}