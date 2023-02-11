import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models/company.dart';
import 'package:flutter_chat/models/message.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/services/user_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final channel = WebSocketChannel.connect(Uri.parse(
      'wss://mulurequa.beget.app:8090/?token=ff52a8241959c3ce2b5bbf014a62dcf2838e92f9d0cea82138a9978315f2600e'));
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();
  // late Future<Company?> futureCompany;
  // late Future<List<Message>?> futureMessages;
  Company? company;
  List<Message>? apiMessages;

  @override
  void initState() {
    super.initState();

    loadData();

    // messages.add(Message(
    //     messageId: 123,
    //     forUserGuid: 'AzatGUID',
    //     userGuid: "userGuid",
    //     message: "message",
    //     createdOn: DateTime.now(),
    //     userFirstName: "userFirstName",
    //     userLastName: "userLastName",
    //     userType: "userType",
    //     userProfile: "userProfile"));
  }

  void loadData() async {
    company = await UserService.init(const User(
        firstName: "Azat",
        lastName: "Gimosyan",
        email: "info@dfd.com",
        phone: "+79145465454",
        fcmToken: "fcmToken",
        userProfile: "images/1.jpg"));

    apiMessages = await UserService.getMessages();
    if (apiMessages != null) {
      for (Message m in apiMessages!) {
        messages.add(m);
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    channel.sink.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Чат с поддержкой',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      messages.add(Message.fromJson(jsonDecode(
                          snapshot.hasData ? '${snapshot.data}' : '')));
                    }

                    if (messages.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            int reverseIndex = messages.length - 1 - index;

                            return Padding(
                              padding: reverseIndex == messages.length - 1
                                  ? const EdgeInsets.only(bottom: 8.0)
                                  : const EdgeInsets.only(bottom: 0),
                              child: Row(
                                children: [
                                  Visibility(
                                      visible: messages[reverseIndex]
                                                  .userFirstName ==
                                              'Azat'
                                          ? true
                                          : false,
                                      child: const SizedBox(width: 50)),
                                  Expanded(
                                    child: Card(
                                      elevation: 0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      color: messages[reverseIndex]
                                                  .userFirstName ==
                                              'Azat'
                                          ? Colors.blue.shade200
                                          : Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${messages[reverseIndex].message} ${messages[reverseIndex].createdOn.hour}:${messages[reverseIndex].createdOn.minute}'),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: messages[reverseIndex]
                                                  .userFirstName ==
                                              'Azat'
                                          ? false
                                          : true,
                                      child: const SizedBox(width: 50)),
                                ],
                              ),
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
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: (() {}),
                            color: Colors.grey.shade400,
                            icon: const Icon(Icons.emoji_emotions_outlined)),
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Введите сообщение',
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                            controller: messageController,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          color: Colors.blue,
                          onPressed: (() {
                            if (messageController.text.isNotEmpty) {
                              channel.sink.add(
                                  '{"userGuid":"d567b3ff-edbd-464f-8cb2-869a83ea6d2f","forUserGuid":"d567b3ff-edbd-464f-8cb2-869a83ea6d2f","message":"${messageController.text}"}');

                              messageController.text = '';
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
