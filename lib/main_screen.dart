import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final channel =
      WebSocketChannel.connect(Uri.parse('wss://mulurequa.beget.app:8090/'));
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    channel.sink.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    messages.add(Message.fromJson(jsonDecode(
                        snapshot.hasData ? '${snapshot.data}' : '')));

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          int reverseIndex = messages.length - 1 - index;

                          return Row(
                            children: [
                              Visibility(
                                  visible: messages[reverseIndex].from == 'Me'
                                      ? true
                                      : false,
                                  child: const SizedBox(width: 50)),
                              Expanded(
                                child: Card(
                                  color: messages[reverseIndex].from == 'Me'
                                      ? Colors.green.shade100
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(messages[reverseIndex].msg),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: messages[reverseIndex].from == 'Me'
                                      ? false
                                      : true,
                                  child: const SizedBox(width: 50)),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: messageController,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (() {
                          channel.sink.add(
                              '{"userId":"23","msg":"${messageController.text}"}');
                        }),
                        child: const Text('Send')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
