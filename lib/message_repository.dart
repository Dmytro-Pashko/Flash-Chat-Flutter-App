import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepository {
  final _firestore = FirebaseFirestore.instance;
  static String _database = 'conversations';

  Stream<List<Message>> observeMessages() {
    return _firestore.collection(_database).snapshots().map((snapshot) {
      final documents = snapshot.docs;
      List<Message> messages = [];
      for (var doc in documents) {
        messages.add(Message(doc['msg_data'], doc['from'], doc['timestamp']));
      }
      return messages.reversed.toList(growable: false);
    });
  }

  Future<void> addMessage(String messageData, String sender) async {
    int timestamp = new DateTime.now().microsecondsSinceEpoch;
    var id = await _firestore.collection(_database).add(
      {'msg_data': messageData, 'from': sender, 'timestamp': timestamp},
    );
    print('Message added with id=${id.id}.');
  }
}

class Message {
  final String data;
  final String sender;
  final int timestamp;

  Message(this.data, this.sender, this.timestamp);
}
