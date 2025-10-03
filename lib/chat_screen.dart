import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"sender": "ai", "text": "Hello, there"},
    {"sender": "ai", "text": "How can I help you today?"},
    {
      "sender": "ai",
      "text":
      "I'm an AI preview, so I'm still learning. Sometimes I might say something weird. Don't get mad at me, I'm just trying to get better!"
    },
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({"sender": "user", "text": _controller.text});
        // You would add your AI response logic here
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.grey[400],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'AI Assistant',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUserMessage = message['sender'] == 'user';
                  return _buildChatBubble(message['text']!, isUserMessage, themeColor);
                },
              ),
            ),
            _buildMessageInput(themeColor),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isUserMessage, Color themeColor) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isUserMessage ? themeColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: isUserMessage ? const Radius.circular(5) : const Radius.circular(20),
            bottomLeft: isUserMessage ? const Radius.circular(20) : const Radius.circular(5),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: isUserMessage ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput(Color themeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: themeColor),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
