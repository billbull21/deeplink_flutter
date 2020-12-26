import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_linksapp/main.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{

  Future checkFirstSeen() async {
    // // Get the latest Uri
    // // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   final uri = await getInitialUri();
    //   if (uri != null) {
    //     redirectHandler(context, uri, () {});
    //   } else {
    //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    //   }
    //   print('initial uri: ${uri?.path}');
    //   print('initial uri query: ${uri?.queryParametersAll}');
    // } on PlatformException {
    //   print('Failed to get initial uri.');
    // } on FormatException {
    //   print('Bad parse the initial link as Uri.');
    // } catch (e) {
    //   print("ERROR $e");
    // }
    //
    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomeApp()));
  }

  @override
  void initState() {
    // final myFcm = MyFirebaseNotifications();
    // myFcm.setUpFirebase();
    // myFcm.getFcmToken();
    Timer(new Duration(milliseconds: 2000), () {
      checkFirstSeen();
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("STATE IS : $state");
    if(state == AppLifecycleState.resumed){
      print("RESUMED");
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF062037),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        alignment: Alignment.center,
        child: Text("SPLASH")
      ),
    );
  }
}
