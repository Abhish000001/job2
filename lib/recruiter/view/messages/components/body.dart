
import 'package:flutter/material.dart';
import '../../../../job_seeker/model/msg_model.dart';
import 'chat_input_field.dart';
import 'message.dart';

class BodyR extends StatelessWidget {
  const BodyR({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
         
          child:  ListView.builder(
            shrinkWrap: true,
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  MessageR(message: demeChatMessages[index]),
            ),
        ),
        ChatInputFieldR(),
      ],
    );
  }
}
