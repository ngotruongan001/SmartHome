import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket SocketServer = IO.io('https://demo-ws.onrender.com/', <String, dynamic>{
  'transports': ['websocket'],
});