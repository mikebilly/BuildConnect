import 'dart:async';
import 'dart:io';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:path/path.dart' as p; // Để lấy extension file
import 'package:mime/mime.dart'; // Để lấy MIME type (cần thêm package: mime)
import 'package:buildconnect/features/conversation/providers/conversation_service_provider.dart';
import 'package:buildconnect/models/conversation/conversation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../../models/message/message_model.dart';
import '../../../models/profile/profile_model.dart';

class MessageService {
  final SupabaseClient _supabaseClient;

  MessageService(this._supabaseClient);
  final String _attachmentBucket = 'message.attachments';

  Future<Message> sendMessage({
    // ... (giữ nguyên) ...
    required String userFromId,
    required String userToId,
    String? content,
    File? attachmentFile,
  }) async {
    debugPrint(
      'sending message with content is: ${content} and file attachment is: ${attachmentFile.toString()}',
    );
    // try {
    //   final response =
    //       await _supabaseClient
    //           .from(SupabaseConstants.messagesTable)
    //           .insert({
    //             'content': content,
    //             'user_from': userFromId,
    //             'user_to': userToId,
    //           })
    //           .select()
    //           .single();

    //   final currentUser = _supabaseClient.auth.currentUser;
    //   final bool isMine = currentUser?.id == userFromId;

    //   return Message(
    //     id: response['id'] as String,
    //     content: response['content'] as String,
    //     markAsRead: response['mark_as_read'] as bool,
    //     userFrom_id: response['user_from'] as String,
    //     userTo_id: response['user_to'] as String,
    //     createAt: DateTime.parse(response['created_at'] as String),
    //   );
    // } on PostgrestException catch (error) {
    //   debugPrint('Supabase Error (sendMessage): ${error.message}');
    //   throw Exception('Failed to send message: ${error.message}');
    // } catch (e) {
    //   debugPrint('Unexpected error (sendMessage): $e');
    //   throw Exception('Unexpected error: ${e.toString()}');
    // }
    String? uploadedAttachmentUrl;
    String? attachmentName;
    int? attachmentSize;
    String? attachmentMimeType;
    AttachmentType attachmentType = AttachmentType.none;

    try {
      // 1. Tải file lên Supabase Storage nếu có
      if (attachmentFile != null) {
        final fileName =
            '${userFromId}/${DateTime.now().millisecondsSinceEpoch}_${p.basename(attachmentFile.path)}';
        attachmentName = p.basename(attachmentFile.path);
        attachmentSize = await attachmentFile.length();
        attachmentMimeType = lookupMimeType(
          attachmentFile.path,
        ); // Lấy MIME type

        debugPrint(
          'Uploading attachment: $fileName to bucket: $_attachmentBucket',
        );

        // Xác định AttachmentType dựa trên MIME type
        if (attachmentMimeType?.startsWith('image/') == true) {
          attachmentType = AttachmentType.image;
        } else if (attachmentMimeType?.startsWith('video/') == true) {
          attachmentType = AttachmentType.video;
        } else {
          attachmentType = AttachmentType.file;
        }

        // Tải file lên
        await _supabaseClient.storage
            .from(_attachmentBucket)
            .upload(
              fileName,
              attachmentFile,
              fileOptions: FileOptions(
                // contentType: attachmentMimeType // Tùy chọn: chỉ định content type
              ),
            );

        // Lấy URL công khai của file đã tải lên
        uploadedAttachmentUrl = _supabaseClient.storage
            .from(_attachmentBucket)
            .getPublicUrl(fileName);
        debugPrint('Attachment uploaded. URL: $uploadedAttachmentUrl');
      }

      // 2. Chèn tin nhắn vào database
      final Map<String, dynamic> messageData = {
        'content': content, // Có thể null
        'user_from': userFromId,
        'user_to': userToId,
        'attachment_type': attachmentType.name, // Lưu tên enum
        'attachment_url': uploadedAttachmentUrl,
        'attachment_name': attachmentName,
        'attachment_size': attachmentSize,
        'attachment_mime_type': attachmentMimeType,
        // 'mark_as_read' và 'created_at' sẽ có giá trị mặc định từ database
      };

      final response =
          await _supabaseClient
              .from(SupabaseConstants.messagesTable)
              .insert(messageData)
              .select() // Yêu cầu trả về hàng vừa được chèn
              .single();

      debugPrint('Message sent successfully to DB: ${response['id']}');

      final currentUser = _supabaseClient.auth.currentUser;
      final bool isMine = currentUser?.id == userFromId;

      // Sử dụng MessageMapper.fromMap nếu đã cấu hình đúng cho các trường mới
      // hoặc tạo thủ công
      return Message(
        id: response['id'] as String,
        content: (response['content'] as String?) ?? '',
        markAsRead: response['mark_as_read'] as bool,
        userFrom_id: response['user_from'] as String,
        userTo_id: response['user_to'] as String,
        createAt: DateTime.parse(response['created_at'] as String),
        attachmentType: AttachmentTypeMapper.fromValue(
          response['attachment_type'] ?? AttachmentType.none.name,
        ),
        attachmentUrl: response['attachment_url'] as String?,
        attachmentName: response['attachment_name'] as String?,
        attachmentSize: response['attachment_size'] as int?,
        attachmentMimeType: response['attachment_mime_type'] as String?,
      );
      // Hoặc: return MessageMapper.fromMap(response as Map<String, dynamic>).copyWith(isMine: isMine);
      // (Đảm bảo fromMap của MessageMapper xử lý đúng các trường attachment)
    } on StorageException catch (e) {
      debugPrint('Supabase Storage Error (sendMessage): ${e.message}');
      throw Exception('Failed to upload attachment: ${e.message}');
    } on PostgrestException catch (error) {
      debugPrint('Supabase Postgrest Error (sendMessage): ${error.message}');
      throw Exception('Failed to send message to DB: ${error.message}');
    } catch (e) {
      debugPrint('Unexpected error (sendMessage): $e');
      throw Exception('Unexpected error sending message: ${e.toString()}');
    }
  }

  Future<List<Message>> fetchMessages({
    required String userReceive,
    required String userSend,
    int limit = 100,
  }) async {
    final response = await Supabase.instance.client.rpc(
      'fetch_and_mark_messages',
      params: {'p_user_from': userSend, 'p_user_to': userReceive},
    );

    final messages =
        (response as List)
            .map((e) => MessageMapper.fromMap(e as Map<String, dynamic>))
            .toList();
    return messages;
  }

  Future<void> markMessagesAsRead({
    required String userReceive,
    required String userSend,
  }) async {
    debugPrint('mark as read for msg from ${userSend} to ${userReceive}');
    try {
      await _supabaseClient
          .from(SupabaseConstants.messagesTable)
          .update({'mark_as_read': true})
          .eq('user_to', userReceive)
          .eq('user_from', userSend)
          .eq('mark_as_read', false);
    } catch (e) {
      debugPrint('Error marking messages as read: $e');
      throw Exception('Failed to mark messages as read.');
    }
  }

  Stream<Message> subscribeToNewMessages({
    required String userId1,
    required String userId2,
  }) {
    final currentUser = _supabaseClient.auth.currentUser;
    if (currentUser == null) {
      return Stream.error(Exception("User not logged in"));
    }

    final ids = [userId1, userId2]..sort();
    final channelName = 'chat:${ids[0]}-${ids[1]}';
    final controller = StreamController<Message>();

    final channel =
        _supabaseClient
            .channel(channelName)
            .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: SupabaseConstants.messagesTable,
              callback: (payload) async {
                final newMessageMap = payload.newRecord;

                if (newMessageMap != null) {
                  final msgUserFrom = newMessageMap['user_from'] as String;
                  final msgUserTo = newMessageMap['user_to'] as String;
                  if ((msgUserFrom == userId1 && msgUserTo == userId2) ||
                      (msgUserFrom == userId2 && msgUserTo == userId1)) {
                    final message = Message(
                      id: newMessageMap['id'] as String,
                      content: (newMessageMap['content'] as String?) ?? '',
                      markAsRead: newMessageMap['mark_as_read'] as bool,
                      userFrom_id: msgUserFrom,
                      userTo_id: msgUserTo,
                      createAt: DateTime.parse(
                        newMessageMap['created_at'] as String,
                      ),
                      attachmentType: AttachmentTypeMapper.fromValue(
                        newMessageMap['attachment_type'] ??
                            AttachmentType.none.name,
                      ),
                      attachmentUrl: newMessageMap['attachment_url'] as String?,
                      attachmentName:
                          newMessageMap['attachment_name'] as String?,
                      attachmentSize: newMessageMap['attachment_size'] as int?,
                      attachmentMimeType:
                          newMessageMap['attachment_mime_type'] as String?,
                    );

                    if (!controller.isClosed) {
                      controller.add(message);
                    }
                  }
                }
              },
            )
            .subscribe();

    controller.onCancel = () {
      // markMessagesAsRead(userReceive: userId1, userSend: userId2);
      debugPrint('Cancelling message subscription for channel: $channelName');
      _supabaseClient.removeChannel(channel);
      controller.close();
    };

    return controller.stream;
  }

  // subcribe to userlist message tương tự như subcribe to

  Future<String> getUserName(String id) async {
    // Giữ nguyên hàm này nếu cần
    try {
      final response =
          await _supabaseClient
              .from(SupabaseConstants.profilesTable)
              .select('display_name')
              .eq('user_id', id)
              .single();
      debugPrint('--------------- display name in message screen');
      debugPrint(response['display_name']);
      return response['display_name'] as String? ?? 'Unknown User';
    } on PostgrestException catch (e) {
      debugPrint('Error fetching user name: ${e.message}');
      return 'Unknown User';
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return 'Unknown User';
    }
  }

  Stream<void> onMessagesChanged() {
    final controller = StreamController<void>();

    final channel = Supabase.instance.client.channel('public:messages');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: 'messages',
      callback: (payload) {
        final oldRow = payload.oldRecord;
        final newRow = payload.newRecord;

        if (oldRow['mark_as_read'] == false && newRow['mark_as_read'] == true) {
          if (!controller.isClosed) {
            controller.add(null);
          }
        }
      },
    );
    // Lắng nghe sự kiện INSERT
    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      callback: (_) {
        if (!controller.isClosed) {
          controller.add(null);
        }
      },
    );

    // Lắng nghe sự kiện UPDATE mark_as_read = true

    channel.subscribe();

    controller.onCancel = () {
      Supabase.instance.client.removeChannel(channel);
      controller.close();
    };

    return controller.stream;
  }
}
