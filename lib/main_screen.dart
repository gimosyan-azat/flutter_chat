import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final channel =
      WebSocketChannel.connect(Uri.parse('wss://mulurequa.beget.app:8090/'));
  List<String> messages = [];

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
            ElevatedButton(
                onPressed: (() {
                  channel.sink
                      .add('{"userId":"23","msg":"hello from flutter"}');
                }),
                child: const Text('Send')),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                messages.add(snapshot.hasData ? '${snapshot.data}' : '');

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Text(messages[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
