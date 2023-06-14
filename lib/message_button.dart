import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'message.dart';

class MessageButton extends StatelessWidget {
  final String jsonFilePath;

  // ignore: use_key_in_widget_constructors
  const MessageButton({Key? key, required this.jsonFilePath});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String jsonString = await rootBundle.loadString('messages.json');
        List<dynamic> jsonMessages = jsonDecode(jsonString);

        List<Message> messages = jsonMessages
            .map((jsonMessage) => Message.fromJson(jsonMessage))
            .toList();

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesScreen(messages: messages),
          ),
        );
      },
      child: const Text('Messages'),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  final List<Message> messages;

  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          Message message = messages[index];
          return ListTile(
            title: Text(message.subject),
            subtitle: Text(message.message),
            trailing: Text(message.display),
          );
        },
      ),
    );
  }
}




// import 'package:flutter/material.dart';

// class MessageButton extends StatelessWidget {
//   final String jsonMessages;

//   const MessageButton({super.key, required this.jsonMessages});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         // Redirect to messages screen with the provided JSON
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MessagesScreen(jsonMessages: jsonMessages),
//           ),
//         );
//       },
//       child: const Text('Messages'),
//     );
//   }
// }

// class MessagesScreen extends StatelessWidget {
//   final String jsonMessages;

//   const MessagesScreen({super.key, required this.jsonMessages});

//   @override
//   Widget build(BuildContext context) {
//     // Parse the JSON and display the messages
//     // Here, you can use a ListView.builder or any other widget to display the messages
//     // You can decode the JSON using the `jsonDecode` function from the `dart:convert` package
//     // Example:
//     // final messages = jsonDecode(jsonMessages);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Messages'),
//       ),
//       body: const Center(
//         child: Text('Messages Screen'),
//       ),
//     );
//   }
// }
