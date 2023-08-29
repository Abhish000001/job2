
import 'package:flutter/material.dart';
import 'package:job2/constants.dart';



import '../../../job_seeker/model/chat_model.dart';
import '../messages/message_screen.dart';

import 'components/chat_card.dart';

class ChatsScreenR extends StatefulWidget {
  const ChatsScreenR({super.key});

  @override
  _ChatsScreenRState createState() => _ChatsScreenRState();
}

class _ChatsScreenRState extends State<ChatsScreenR> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chat'),
      backgroundColor: kSilverColor,
      elevation: 0,
      ),
   
      body: Column(
      children: [
        // Container(
        //   padding: EdgeInsets.fromLTRB(
        //       kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
        //   color: kSilverColor,
        //   child: Row(
        //     children: [
        //       FillOutlineButton(press: () {}, text: "Recent Message"),
        //       SizedBox(width: kDefaultPadding),
        //       FillOutlineButton(
        //         press: () {},
        //         text: "Active",
        //         isFilled: false,
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCardR(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreenR(),
                ),
              ),
            ),
          ),
        ),
      ],
    )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: kPrimaryColor,
      //   child: Icon(
      //     Icons.person_add_alt_1,
      //     color: Colors.white,
      //   ),
      // ),
      
    );
  }

  

  // AppBar buildAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     title: Text("Chats"),
  //     actions: [
  //       IconButton(
  //         icon: Icon(Icons.search),
  //         onPressed: () {},
  //       ),
  //     ],
  //   );
  // }
}
