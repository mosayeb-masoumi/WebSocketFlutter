import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key});

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

// https://www.youtube.com/watch?v=0jqhRBtRWqE

class _SendMessageScreenState extends State<SendMessageScreen> {
  final TextEditingController my_controller = TextEditingController();
  final my_channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));

  @override
  void dispose() {
    my_controller.dispose();
    my_channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
                child: TextFormField(
              controller: my_controller,
              decoration: const InputDecoration(labelText: "Send Message"),
            )),
            const SizedBox(
              height: 24,
            ),
            StreamBuilder(
                stream: my_channel.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? "${snapshot.data}" : "");
                })
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: sendMessage ,
        tooltip: "Send Message",
        child: const Icon(Icons.send),

      ),
      
    );
  }

  void sendMessage(){
    if(my_controller.text.isNotEmpty){
      my_channel.sink.add(my_controller.text);
    }
  }
}
