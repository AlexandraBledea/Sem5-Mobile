import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketInterface {
  static Stream stream = listen();
  static bool isListened = false;
  static Stream listen() {
    final channel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:2325/'),
    );
    print("connected");
    return channel.stream;
  }
}
