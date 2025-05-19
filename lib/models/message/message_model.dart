import 'package:dart_mappable/dart_mappable.dart';
part 'message_model.mapper.dart';

@MappableClass()
class Message with MessageMappable {
  final String id;
  final String content;
  final bool markAsRead;
  final String userFrom_id;
  final String userTo_id;
  final DateTime createAt;
  final bool isMine;

  Message({
    required this.id,
    required this.content,
    required this.markAsRead,
    required this.userFrom_id,
    required this.userTo_id,
    required this.createAt,
    required this.isMine,
  });
}
