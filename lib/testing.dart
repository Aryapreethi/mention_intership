import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';

class Mention extends StatefulWidget {
  const Mention({Key? key});

  @override
  State<Mention> createState() => _MentionState();
}

class _MentionState extends State<Mention> {
  TextEditingController controller = TextEditingController();
  List<String> names = ["arya", "ammu", "kunju", "kanna", "muthu"];

  String? _mention;
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        final text = controller.text;
        final mentionIndex = text.lastIndexOf('@');
        if (mentionIndex >= 0) {
          _mention = text.substring(mentionIndex + 1);
          print('------------------$_mention');
          _filteredSuggestions =
              names.where((name) => name.contains(_mention!)).toList();
          print("...............$_filteredSuggestions");
        } else {
          _mention = null;
          _filteredSuggestions.clear();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "@_Mention",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: CommentBox(
        labelText: 'Write a comment...',
        errorText: 'Comment cannot be blank',
        sendButtonMethod: () {
          setState(() {
            var data = controller.text;
            // names.add(data);
            controller.clear();
          });
        },
        withBorder: false,
        commentController: controller,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        sendWidget: const Icon(Icons.send_sharp, size: 30, color: Colors.white),
        child: commentslist(),
      ),
    );
  }

  Widget commentslist() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: _filteredSuggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_filteredSuggestions[index]),
           onTap: () {
              if (_mention != null) {
                final text = controller.text;
                final mentionIndex = text.lastIndexOf('@');
                final newText = '${text.substring(0, mentionIndex)}@${_filteredSuggestions[index]} ${text.substring(mentionIndex + _mention!.length + 1)}';
                controller.text = newText;
                _mention = null;
                _filteredSuggestions.clear();
              }}
          );
        },
      ),
    );
  }
}
