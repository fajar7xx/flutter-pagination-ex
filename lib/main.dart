import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pagination Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;

  List<User> users = [];

  // fetching api
  Future<bool> getUserData() async {
    final Uri uri =
        Uri.parse("https://reqres.in/api/users?page=$currentPage&per_page=5");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = userFromJson(response.body);
      users = result.data;
      currentPage++;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("infinite List pagination"),
    ));
  }
}
