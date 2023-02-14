import 'package:flutter/material.dart';
import 'package:ott/Componets/netflix.dart';
import 'package:ott/source/globlas.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.redAccent,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.lightBlue),
        onRefresh: () async {
          await inAppWebViewController?.reload();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("OTT"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...display
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${e['name']}",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const netflix(),
                                  settings: RouteSettings(arguments: e),
                                ),
                              );
                            },
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red,
                                image: DecorationImage(
                                    image: AssetImage(
                                      "${e['img']}",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
