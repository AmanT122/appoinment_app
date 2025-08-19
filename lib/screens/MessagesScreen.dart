import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MessagesScreen(),
  ));
}

// Global in-memory message store (name => list of messages)
Map<String, List<String>> globalMessageStore = {
  'Alice': ['Hey, how are you?'],
  'Bob': ['Let\'s catch up tomorrow!'],
  'Charlie': ['Check out this cool app!'],
};

class MessagesScreen extends StatelessWidget {
  final List<String> names = ['Alice', 'Bob', 'Charlie'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          final name = names[index];
          final lastMessage = globalMessageStore[name]!.last;

          return ListTile(
            leading: CircleAvatar(
              child: Text(name[0]),
              backgroundColor: Colors.deepPurple.shade200,
            ),
            title: Text(name),
            subtitle: Text(lastMessage),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(name: name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String name;

  ChatDetailScreen({required this.name});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  List<String> get messages => globalMessageStore[widget.name]!;

  void sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(text); // Add to global store
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerLeft, // All messages left
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.deepPurple),
                    onPressed: sendMessage,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
