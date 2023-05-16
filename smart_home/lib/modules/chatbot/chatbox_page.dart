import 'package:flutter/material.dart';
import 'package:smart_home/data/socket.dart';
import 'package:smart_home/modules/chatbot/models/message.dart';
import 'package:smart_home/themes/app_colors.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/theme_data.dart';
import 'package:smart_home/utils/local_storage.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatBot extends StatefulWidget {

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  ValueNotifier<List<ChatMessage>> listChart = ValueNotifier([]);

  final TextEditingController _textController = TextEditingController();
  String userId = LocalStorage.getString(LocalStorageKey.userId);

  @override
  void initState() {
    print("initState chat bot");
    super.initState();
    _speech = stt.SpeechToText();
    try {
      SocketServer.on('sendChat', (data) {
        String user = data['user'];
        String msg = data['message'];
        String userId = data['userId'];
        print("a1: $data");
        ChatMessage message = ChatMessage(
          text: msg,
          name: 'Bot',
          type: false,
        );
        listChart.value = [message,...listChart.value];

      });
      SocketServer.emit('event', 'Hello from Flutter!');
    } catch (e) {
      print("Connect failed!!");
    }
  }
  @override
  void dispose(){
    super.dispose();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: () => _listen),
            ),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                InputDecoration.collapsed(hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void response(query)  {
    var newMess = Message(
        isMe: false, userId: userId, user: "Tinh", message: query);
    SocketServer.emit('sendChat', newMess);
  }

  void _handleSubmitted(String text) {
    if(text.length!=0){
      _textController.clear();
      ChatMessage message = ChatMessage(
        text: text,
        name: 'Me',
        type: true,
      );
      listChart.value = [message,...listChart.value];
      response(text);
    }else{
      print('khong duoc de ki tu trong~~');
    }
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<List<ChatMessage>>(
        valueListenable: listChart,
        builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Chat Bot"),
              backgroundColor: CustomColors.menuBackgroundColor,
            ),
            backgroundColor: CustomColors.pageBackgroundColor,
            body: Column(children: <Widget>[
              Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) => value[index],
                    itemCount: value.length,
                  )),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
            ),
          );
        });
  }
  Widget _widgetCircleLoading({
    required double height,
    required double width,
    Color? backgroudColor,
    double? strokeWidth,
  }) {
    return SizedBox(
        width: height,
        height: width,
        child: CircularProgressIndicator(
          color: backgroudColor ?? Colors.white,
          strokeWidth: 4.0.r,
        ));
  }

}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.name, required this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(backgroundImage: AssetImage("assets/png/logo.png"),),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.primaryTextColor
                )
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                  text,
                  style: TextStyle(
                      color: CustomColors.primaryTextColor
                  )
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
                this.name,
                style: TextStyle(
                    color: CustomColors.primaryTextColor
                )
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                style: TextStyle(
                    color: CustomColors.primaryTextColor
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(backgroundImage: AssetImage("assets/images/ngotruongan.jpg",)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }


}