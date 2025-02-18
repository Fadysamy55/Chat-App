import 'package:flutter/material.dart';
import '../Constans/Const.dart';
import 'ChatScreen.dart';

class Chat {
  final String name;
  final String lastMessage;

  Chat({required this.name, required this.lastMessage});
}

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Chat> chats = [
    Chat(name: "Alice", lastMessage: "Hey! How are you?"),
    Chat(name: "Bob", lastMessage: "Let's meet tomorrow."),
    Chat(name: "Charlie", lastMessage: "Did you finish the project?"),
    Chat(name: "David", lastMessage: "Happy Birthday!"),
    Chat(name: "Foda", lastMessage: "Let's meet tomorrow."),
    Chat(name: "Boba", lastMessage: "Happy Birthday!"),
    Chat(name: "Mona", lastMessage: "Did you finish the project?"),
  ];

  List<Chat> filteredChats = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredChats = chats; // Initially show all chats
  }

  void filterChats(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredChats = chats;
      } else {
        filteredChats = chats.where((chat) {
          return chat.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void clearSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      filteredChats = chats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: filterChats,
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/Fadysamy55/ppro/refs/heads/main/scholar.png',
              height: 50,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text(
              'Chat',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          isSearching
              ? IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: clearSearch,
          )
              : IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
          ),
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredChats.length,
        itemBuilder: (context, index) {
          return ChatTile(chat: filteredChats[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to start a new chat
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.message, color: Colors.white),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(chat.name, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Text(
          chat.name[0].toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => chatscreen()),
        );
      },
    );
  }
}
