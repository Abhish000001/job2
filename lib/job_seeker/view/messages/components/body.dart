
import 'package:flutter/material.dart';


import '../../../model/msg_model.dart';
import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
         
          child:  ListView.builder(
            shrinkWrap: true,
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index]),
            ),
        ),
        ChatInputField(),
      ],
    );
  }
}
