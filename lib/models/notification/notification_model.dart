import 'package:buildconnect/models/enums/enums.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'notification_model.mapper.dart';

// Enum cho các loại thông báo (đồng bộ với giá trị 'type' trong DB)
// Có thể đặt ở file enums.dart chung

@MappableClass(caseStyle: CaseStyle.snakeCase)
class NotificationModel with NotificationModelMappable {
  final String id;
  final String userId; // Người nhận
  final NotificationType type;
  final String? title;
  final String body;
  final RelatedEntityType? relatedEntityType;
  final String? relatedEntityId;
  final String? actorId;
  final String? actorDisplayName;
  final String? actorAvatarUrl;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    this.title,
    required this.body,
    this.relatedEntityType,
    this.relatedEntityId,
    this.actorId,
    this.actorDisplayName,
    this.actorAvatarUrl,
    required this.isRead,
    required this.createdAt,
  });
}
