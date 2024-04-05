import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funfacts/screens/settings_screen.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> facts = [];
  bool isLoading = true;
  @override
  initState() {
    getData();
    super.initState();
  }

  void getData() async {
    try {
      Response response = await Dio().get(
          "https://raw.githubusercontent.com/DhineshKrishnan1206/Flutter_dummy_api/main/funfacts.json");
      facts = jsonDecode(response.data);
      isLoading = false;
      setState(() {});
    } catch (e) {
      print("Error while Fetching");
    }
  }

  // ApiUrl= https://raw.githubusercontent.com/DhineshKrishnan1206/Flutter_dummy_api/main/funfacts.json
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FunFacts"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingsScreen();
                  }));
                },
                child: Icon(Icons.settings)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(
                    child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()),
                  )
                : PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: facts.length,
                    itemBuilder: (BuildContext, int index) {
                      return Container(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            facts[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 35),
                          )));
                    }),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text("Swipe Left or Right"),
            ),
          )
        ],
      ),
    );
  }
}
