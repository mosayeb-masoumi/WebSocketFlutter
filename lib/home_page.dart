
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final channel = IOWebSocketChannel.connect("wss://stream.binance.com:9443/ws/btcusdt@trade");

  String btsUsdPrice = "0";

  @override
  void initState() {
    super.initState();

    // streamListener();
    latestVersion();
  }

  latestVersion() async {
    final wsUrl = Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade');
    var channel = WebSocketChannel.connect(wsUrl);

    channel.stream.listen((event) {
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);

          Map getData = jsonDecode(event);

          setState(() {
            btsUsdPrice = getData["p"];
          });
          print(getData["p"]);

    });
  }

  // streamListener(){
  //   channel.stream.listen((event) {
  //     // channel.sink.add("received!");
  //     // channel.sink.close(status.goingAway);
  //     Map getData = jsonDecode(event);
  //
  //     setState(() {
  //       btsUsdPrice = getData["p"];
  //     });
  //     print(getData["p"]);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BTC/USDT Price" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text(btsUsdPrice , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  }
}
