
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/waste_list_screen.dart';
import 'screens/waste_detail_screen.dart';
import 'screens/waste_new_post.dart';
import 'services/shared_location.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class App extends StatefulWidget {
  const App({Key? key,}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

    final routes = {
    WasteList.routeName: (context) => WasteList(),
    WasteDetail.routeName: (context) => WasteDetail(),
    WasteNewPost.routeName: (context) => WasteNewPost( analytics: analytics,),
    };

    return MaterialApp(
      navigatorObservers: [observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark
      ),
      routes: routes
    );
  }

}