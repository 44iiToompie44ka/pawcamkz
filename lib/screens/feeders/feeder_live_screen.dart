import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcamkz/screens/registrationNLogin/login_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeederLiveScreen extends StatefulWidget {
  final String url;
  final String title;
  final int feederId;

  const FeederLiveScreen({
    required this.url,
    required this.title,
    required this.feederId,
  });

  @override
  _FeederLiveScreenState createState() => _FeederLiveScreenState();
}

class _FeederLiveScreenState extends State<FeederLiveScreen> {
  late YoutubePlayerController streamController;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  late String _currentUserUid = '';
  late String _currentUsername = '';

  @override 
  void initState() {
    super.initState();
    streamController = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: const YoutubePlayerFlags(
        isLive: false,
        hideControls: false,
        startAt: 600,
        autoPlay: true,
      ),
    );
    _fetchMessages();
    _initializeCurrentUser();
  }

  void _initializeCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _currentUserUid = user.uid;
      _getUsername(_currentUserUid);
    }
  }

  void _getUsername(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      setState(() {
        _currentUsername = userSnapshot.data()?['username'] ?? '';
      });
    } catch (error) {
      print('Error fetching username: $error');
    }
  }

  void _fetchMessages() async {
    setState(() {
      _isLoading = true;
    });
    try {
      FirebaseFirestore.instance
          .collection('feeders')
          .doc('feeder${widget.feederId}')
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
        List<ChatMessage> chatMessages = snapshot.docs.map((doc) {
          return ChatMessage(
            text: doc['text'],
            uid: doc['uid'],
            username: doc['username'],
          );
        }).toList();
        setState(() {
          _messages.clear();
          _messages.addAll(chatMessages);
          _isLoading = false;
        });
      });
    } catch (error) {
      print('Error fetching messages: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    
        
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          SizedBox(height: 20,),
          YoutubePlayer(
            controller: streamController,
            liveUIColor: Theme.of(context).colorScheme.primary,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              reverse: true,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) {
                return _messages[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: _buildTextComposer(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return;
    }

    // User is logged in, continue with sending the message
    _textController.clear();

    await FirebaseFirestore.instance
        .collection('feeders')
        .doc('feeder${widget.feederId}')
        .collection('messages')
        .add({
      'text': text,
      'timestamp': Timestamp.now(),
      'username': _currentUsername,
      'uid': _currentUserUid,
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 50.0,
            width: 200.0,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              controller: _textController,
              style: TextStyle(color: Colors.grey[400]), // Grey[400] text color
              decoration: const InputDecoration(
                hintText: "Сообщение в чат",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration:
            BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                String text = _textController.text.trim();
                if (text.isNotEmpty) {
                  _handleSubmitted(text);
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration:
            BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              icon: const Icon(CupertinoIcons.paw, color: Colors.amberAccent),
              onPressed: () {
                String text = _textController.text.trim();
                if (text.isNotEmpty) {
                  _handleSubmitted(text);
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration:
            BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              icon: const Icon(Icons.mobile_screen_share_rounded, color: Colors.greenAccent),
              onPressed: () {
                String text = _textController.text.trim();
                if (text.isNotEmpty) {
                  _handleSubmitted(text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String? uid;
  final String? username;

  const ChatMessage({required this.text, this.uid, this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration:
              BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      username ?? "",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Text(
                    ":",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
