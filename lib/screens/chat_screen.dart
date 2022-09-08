import 'package:flash_chat_flutter/components/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/auth.dart';
import 'login_screen.dart';

class ChatScreen extends StatefulWidget {
  static const String screenId = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static final timestampFormat = DateFormat('HH:mm a');
  final MessageRepository messageRepository = MessageRepository();
  final AuthManager auth = AuthManager();
  final controller = TextEditingController();

  bool isSendingInProgress = false;
  late String userEmail;
  String message = '';

  @override
  void initState() {
    super.initState();
    checkUserSession();
  }

  void checkUserSession() {
    var user = auth.getCurrentUser();
    if (user != null && user.email != null) {
      userEmail = user.email!;
      print('Current user email =[$userEmail].');
    } else {
      print('User session is invalid.');
      Navigator.pushReplacementNamed(context, LoginScreen.screenId);
    }
  }

  Future<void> sendMessage() async {
    setState(() {
      isSendingInProgress = true;
    });
    try {
      await messageRepository.addMessage(message, userEmail);
      setState(() {
        message = '';
        controller.clear();
        isSendingInProgress = false;
      });
    } catch (e) {
      setState(() {
        isSendingInProgress = false;
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General conversation'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: messageRepository.observeMessages(),
            builder: (context, snapshot) {
              return getMessageList(context, snapshot);
            },
          ),
          getSendText(),
        ],
      ),
    );
  }

  Widget getMessageList(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      final messages = snapshot.data;
      if (messages != null && messages.isNotEmpty) {
        List<Widget> messageWidgets = [];
        for (var message in messages) {
          messageWidgets.add(getMessageWidget(message));
        }
        return Expanded(child: ListView(children: messageWidgets));
      }
    }
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'No messages yet.',
          style: TextStyle(
            color: Colors.grey.shade900,
          ),
        ),
      ),
    );
  }

  Widget getMessageWidget(Message message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: isMyMessage(message)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${message.sender}',
            style: TextStyle(color: Colors.grey[800]),
          ),
          Container(
            decoration: BoxDecoration(
              color: isMyMessage(message)
                  ? Colors.blue.shade200
                  : Color(0xFFEBEBEB),
              border: Border.all(
                  color: isMyMessage(message)
                      ? Colors.blue.shade200
                      : Color(0xFFEBEBEB),
                  width: 3.0),
              borderRadius: isMyMessage(message)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message.data,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Text(
            convertTimeStamp(message.timestamp),
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

  String convertTimeStamp(int timestamp) {
    return timestampFormat.format(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }

  bool isMyMessage(Message message) {
    return message.sender == userEmail;
  }

  Widget getSendText() {
    return Theme(
      data: ThemeData(
        focusColor: Colors.grey[900],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 5,
        autocorrect: true,
        onChanged: (value) {
          setState(() {
            message = value;
          });
        },
        decoration: InputDecoration(
          enabled: !isSendingInProgress,
          labelText: 'Message...',
          filled: true,
          suffixIcon: message.isNotEmpty
              ? GestureDetector(
                  onTap: () async {
                    sendMessage();
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
