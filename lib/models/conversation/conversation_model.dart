import 'package:buildconnect/models/message/message_model.dart';
import 'package:dart_mappable/dart_mappable.dart';
part 'conversation_model.mapper.dart';

@MappableClass()
class ConversationModel with ConversationModelMappable {
  final String partnerId;
  final String partnerDisplayName; // Tên hiển thị của người chat cùng
  final String? partnerAvatarUrl;
  final Message lastMessage;
  final int unreadCount;

  ConversationModel({
    required this.partnerId,
    required this.partnerDisplayName,
    this.partnerAvatarUrl,
    required this.lastMessage,
    required this.unreadCount,
  });
}
