

import 'package:chat3/Screens/chat%20list%20screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constans/Const.dart';
import '../MODELS/MODELS.dart';
import '../Widgets/chatBuble.dart';

class chatscreen extends StatelessWidget {
  static String id = 'ChatPage';


  final _controller = ScrollController();

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    var email  = ModalRoute.of(context)!.settings.arguments ;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar:
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title:
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        // الانتقال إلى الصفحة الثانية
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatListScreen()),
                        );
                      },
                      child: Container(
                        width: 40, // عرض الدائرة
                        height: 40, // ارتفاع الدائرة
                        decoration: BoxDecoration(
                          color: Colors.white, // لون الدائرة
                          shape: BoxShape.circle, // شكل الدائرة
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back, // رمز السهم
                            color: Colors.blueGrey[900], // لون السهم
                            size: 25, // حجم السهم
                          ),
                        ),

                      )
                  ),
                  SizedBox(width: 75,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://raw.githubusercontent.com/Fadysamy55/ppro/refs/heads/main/scholar.png',
                        height: 60,

                      ),

                      Text('chat',style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),),
                    ],
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].message == email ?  ChatBuble(
                          message: messagesList[index],
                        ) : ChatBubleForFriend(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {kMessage: data, kCreatedAt: DateTime.now(), 'id' : email },

                      );
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}