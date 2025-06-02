import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';
part 'message_model.mapper.dart';

@MappableClass()
class Message with MessageMappable {
  final String id;
  final String? content;
  final bool markAsRead;
  final String userFrom_id;
  final String userTo_id;
  final DateTime createAt;
  final AttachmentType attachmentType;
  final String? attachmentUrl;
  final String? attachmentName;
  final int? attachmentSize;
  final String? attachmentMimeType;
  Message({
    required this.id,
    required this.content,
    @MappableField(key: 'mark_as_read') required this.markAsRead,
    @MappableField(key: 'user_from') required this.userFrom_id,
    @MappableField(key: 'user_to') required this.userTo_id,
    @MappableField(key: 'created_at') required this.createAt,
    @MappableField(key: 'attachment_type')
    this.attachmentType = AttachmentType.none,
    @MappableField(key: 'attachment_url') this.attachmentUrl,
    @MappableField(key: 'attachment_name') this.attachmentName,
    @MappableField(key: 'attachment_size') this.attachmentSize,
    @MappableField(key: 'attachment_mime_type') this.attachmentMimeType,
  });
}
