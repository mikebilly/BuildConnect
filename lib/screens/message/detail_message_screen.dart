// lib/screens/chat/chat_detail_screen.dart
import 'dart:io';

import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/conversation/providers/conversation_provider.dart';
import 'package:buildconnect/features/message/providers/message_service_provider.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/message/message_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import '../../../features/message/providers/message_provider.dart';

class DetailMessageScreen extends ConsumerStatefulWidget {
  final String conversationPartnerId;
  // final String partnerName;
  const DetailMessageScreen({
    super.key,
    required this.conversationPartnerId,
    // required this.partnerName,
  });

  @override
  ConsumerState<DetailMessageScreen> createState() =>
      _DetailMessageScreenState();
}

class _DetailMessageScreenState extends ConsumerState<DetailMessageScreen> {
  late final TextEditingController messageController;
  late final ScrollController scrollController;
  late final _partnerNameFuture;
  File? _selectedAttachment;
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    scrollController = ScrollController();
    final messageService = ref.read(
      messageServiceProvider,
    ); // Lấy service từ Riverpod
    _partnerNameFuture = messageService.getUserName(
      widget.conversationPartnerId,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref
            .read(
              messageNotifierProvider(widget.conversationPartnerId).notifier,
            )
            .markMessagesAsRead();
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    debugPrint('dispose detailScreen.................');
    super.dispose();
  }

  @override
  void deactivate() {
    ref
        .read(messageNotifierProvider(widget.conversationPartnerId).notifier)
        .markMessagesAsRead();
    ref.invalidate(conversationNotifierProvider);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(
      messageNotifierProvider(widget.conversationPartnerId),
    );
    final currentUserId =
        ref
            .read(
              messageNotifierProvider(widget.conversationPartnerId).notifier,
            )
            .currentUserId();

    return FutureBuilder<String>(
      future: _partnerNameFuture,
      builder: (context, snapshot) {
        final title = snapshot.data ?? '...';
        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Column(
            children: [
              Expanded(
                child: messagesAsync.when(
                  data: (messages) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scrollController.hasClients) {
                        scrollController.jumpTo(
                          scrollController.position.maxScrollExtent,
                        );
                        // Hoặc animateTo nếu bạn muốn cuộn mượt:
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    });
                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return _buildMessageBubble(
                          msg,
                          context,
                          msg.userFrom_id == currentUserId,
                        );
                      },
                    );
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: () {
                        _pickFile();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () {
                        _pickImageOrVideo();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        _sendMessageWithOptionalAttachment();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo or Video'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageOrVideo();
                },
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text('Document/File'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Hàm chọn ảnh hoặc video
  Future<void> _pickImageOrVideo() async {
    final ImagePicker picker = ImagePicker();
    // Cho phép chọn cả ảnh và video
    final XFile? pickedFile =
        await picker.pickMedia(); // Hoặc pickImage/pickVideo riêng

    if (pickedFile != null) {
      setState(() {
        _selectedAttachment = File(pickedFile.path);
      });
      // TODO: Hiển thị preview file đã chọn gần ô nhập liệu
      // Có thể hiển thị tên file hoặc thumbnail
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected: ${p.basename(pickedFile.path)}')),
      );
    }
  }

  // Hàm chọn file bất kỳ
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedAttachment = File(result.files.single.path!);
      });
      // TODO: Hiển thị preview file đã chọn
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected: ${result.files.single.name}')),
      );
    }
  }

  // Hàm gửi tin nhắn (đã sửa để xử lý attachment)
  void _sendMessageWithOptionalAttachment() {
    final content = messageController.text.trim();

    if (content.isEmpty && _selectedAttachment == null) {
      // Không gửi nếu cả text và file đều rỗng
      return;
    }

    // Gọi sendMessage từ MessageNotifier
    ref
        .read(messageNotifierProvider(widget.conversationPartnerId).notifier)
        .sendMessage(
          content.isEmpty ? null : content, // Gửi null nếu content rỗng
          attachmentFile: _selectedAttachment,
        );

    // Xóa text và reset file đã chọn sau khi gửi
    messageController.clear();
    setState(() {
      _selectedAttachment = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessageBubble(
    Message message,
    BuildContext context,
    bool isMine,
  ) {
    return Container(
      // ...
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (message.attachmentType != AttachmentType.none &&
              message.attachmentUrl != null)
            _buildAttachmentView(message, context, isMine),

          if (message.content != null && message.content!.isNotEmpty)
            Container(
              padding: ChatTheme.messagePadding,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color:
                    isMine
                        ? AppColors.myMessageBackground
                        : AppColors.otherMessageBackground,
                borderRadius:
                    isMine
                        ? ChatTheme.myMessageBorderRadius
                        : ChatTheme.otherMessageBorderRadius,
              ),
              child: Column(
                crossAxisAlignment:
                    isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content!,
                    style: TextStyle(
                      color:
                          isMine
                              ? AppColors.myMessageText
                              : AppColors.otherMessageText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.Hm().format(message.createAt),
                    style: ChatTheme.timestampStyle,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Hàm mới để hiển thị các loại attachment khác nhau
  Widget _buildAttachmentView(
    Message message,
    BuildContext context,
    bool isMine,
  ) {
    final bubbleColor =
        isMine
            ? Theme.of(context).primaryColor.withOpacity(0.8)
            : Colors.grey.shade200;
    final textColor = isMine ? Colors.white : Colors.black87;

    // TODO: Sử dụng cache_network_image hoặc video_player cho hiệu suất tốt hơn
    switch (message.attachmentType) {
      case AttachmentType.image:
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                /* TODO: Mở ảnh full screen */
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                  maxHeight: 250,
                ),
                margin: EdgeInsets.only(
                  bottom:
                      message.content != null && message.content!.isNotEmpty
                          ? 4.0
                          : 0,
                ),
                decoration: BoxDecoration(
                  color: bubbleColor, // Màu nền cho attachment
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    11.0,
                  ), // Hơi nhỏ hơn để thấy background
                  child: Image.network(
                    message.attachmentUrl!,
                    fit: BoxFit.cover,
                    // TODO: Thêm loadingBuilder và errorBuilder cho Image.network
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                        ),
                      );
                    },
                    errorBuilder:
                        (context, error, stackTrace) => const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 6),
          ],
        );
      case AttachmentType.video:
        // Hiển thị thumbnail với nút Play ở giữa, khi ấn thì mở video bằng url_launcher
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(
                bottom:
                    message.content != null && message.content!.isNotEmpty
                        ? 4.0
                        : 0,
              ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Thumbnail (có thể dùng ảnh đại diện hoặc icon video)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: Colors.black12,
                      child: Icon(Icons.videocam, color: textColor, size: 60),
                    ),
                  ),
                  // Nút Play ở giữa
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () async {
                        final url = message.attachmentUrl;
                        if (url != null) {
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not open video'),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  // Tên video ở dưới
                  Positioned(
                    left: 8,
                    right: 8,
                    bottom: 8,
                    child: Container(
                      color: Colors.black45,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: Text(
                        message.attachmentName ?? 'Video',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
          ],
        );
      case AttachmentType.file:
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.only(
                bottom:
                    message.content != null && message.content!.isNotEmpty
                        ? 4.0
                        : 0,
              ),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.insert_drive_file, color: textColor, size: 30),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      message.attachmentName ?? 'File',
                      style: TextStyle(color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.download, color: textColor),
                    tooltip: 'Download/Open',
                    onPressed: () async {
                      // Mở file bằng url (trình duyệt hoặc app tương ứng)
                      final url = message.attachmentUrl;
                      if (url != null) {
                        // Sử dụng url_launcher để mở file
                        // Cần thêm package url_launcher vào pubspec.yaml
                        // import 'package:url_launcher/url_launcher.dart';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not open file'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
          ],
        );
      case AttachmentType.none:
      default:
        return const SizedBox.shrink(); // Không hiển thị gì
    }
  }
}

Widget _buildMessageBubble({
  required String text,
  required String timestamp,
  required bool isMine,
}) {
  return Align(
    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: ChatTheme.messagePadding,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color:
            isMine
                ? AppColors.myMessageBackground
                : AppColors.otherMessageBackground,
        borderRadius:
            isMine
                ? ChatTheme.myMessageBorderRadius
                : ChatTheme.otherMessageBorderRadius,
      ),
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color:
                  isMine ? AppColors.myMessageText : AppColors.otherMessageText,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(timestamp, style: ChatTheme.timestampStyle),
        ],
      ),
    ),
  );
}
