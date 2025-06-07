// lib/screens/chat/chat_detail_screen.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:photo_view/photo_view.dart';
import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/conversation/providers/conversation_provider.dart';
import 'package:buildconnect/features/message/providers/message_service_provider.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/message/message_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
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
  String? _pickedFileType; // Lưu loại file đã chọn (image/video/file)
  bool _isVideoPlaying =
      false; // State cục bộ để quản lý trạng thái play/pause của UI icon
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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

                    // Attachment preview + TextField container
                    if (_selectedAttachment != null)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color: Colors.grey.shade200,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child:
                                  _pickedFileType == 'image'
                                      ? Image.file(
                                        _selectedAttachment!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                      : _pickedFileType == 'video'
                                      ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            color: Colors.black12,
                                            child: const Icon(
                                              Icons.videocam,
                                              size: 30,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.play_circle_fill,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                        ],
                                      )
                                      : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.insert_drive_file,
                                            size: 30,
                                            color: Colors.black54,
                                          ),
                                          Text(
                                            _selectedAttachment!.path
                                                .split('/')
                                                .last,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black54,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedAttachment = null;
                                    _pickedFileType = null;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // TextField takes remaining space
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 6,
                            top: 0,
                            bottom: 0,
                          ),
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
                        // Optionally clear attachment here if you want
                        setState(() {
                          _selectedAttachment = null;
                          _pickedFileType = null;
                        });
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

  // Hàm chọn ảnh hoặc video
  Future<void> _pickImageOrVideo() async {
    final ImagePicker picker = ImagePicker();
    // Cho phép chọn cả ảnh và video
    final XFile? pickedFile =
        await picker.pickMedia(); // Hoặc pickImage/pickVideo riêng

    if (pickedFile != null) {
      setState(() {
        _selectedAttachment = File(pickedFile.path);
        _pickedFileType = getTypeFile(
          _selectedAttachment?.path,
        ); // Lấy loại file
        debugPrint('---------------$_pickedFileType');
      });
    }
  }

  // Hàm chọn file bất kỳ
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedAttachment = File(result.files.single.path!);
        _pickedFileType = result.files.single.extension; // Lấy đuôi file
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => FullScreenImageViewer(
                          imageUrl: message.attachmentUrl!,
                        ),
                  ),
                );
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
        return Column(
          children: [
            VideoMessagePlayer(videoUrl: message.attachmentUrl!),
            const SizedBox(height: 6),
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
                    tooltip: 'Tải về',
                    onPressed: () async {
                      final url = message.attachmentUrl;
                      if (url == null || url.isEmpty) return;

                      // Yêu cầu quyền (chỉ Android)
                      if (Platform.isAndroid) {
                        // Với Android 11 trở lên, dùng manageExternalStorage
                        if (await Permission.manageExternalStorage.isGranted ==
                            false) {
                          final status =
                              await Permission.manageExternalStorage.request();
                        }
                      }

                      try {
                        final response = await http.get(Uri.parse(url));
                        if (response.statusCode == 200) {
                          final bytes = response.bodyBytes;

                          // Lấy tên file từ url
                          final fileName = url.split('/').last;

                          // Tìm thư mục Downloads
                          final directory =
                              Platform.isAndroid
                                  ? Directory(
                                    '/storage/emulated/0/Download',
                                  ) // Android Downloads
                                  : await getApplicationDocumentsDirectory(); // iOS fallback

                          final filePath = '${directory.path}/$fileName';
                          final file = File(filePath);

                          await file.writeAsBytes(bytes);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đã tải: ${message.attachmentName}',
                              ),
                            ),
                          );

                          // Tùy chọn: Mở file sau khi tải
                          // await OpenFile.open(filePath);
                        } else {
                          throw Exception(
                            'Lỗi tải file: ${response.statusCode}',
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Không thể tải file: $e')),
                        );
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

  String? getTypeFile(String? path) {
    if (path == null) return null;
    final extension = p.extension(path).toLowerCase();
    if (['.jpg', '.jpeg', '.png', '.gif'].contains(extension)) {
      return 'image';
    } else if (['.mp4', '.mov', '.avi'].contains(extension)) {
      return 'video';
    } else if (['.pdf', '.docx', '.xlsx', '.pptx'].contains(extension)) {
      return 'file';
    }
    return null; // Không phải loại file được hỗ trợ
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

class VideoMessagePlayer extends StatefulWidget {
  final String videoUrl;

  const VideoMessagePlayer({Key? key, required this.videoUrl})
    : super(key: key);

  @override
  State<VideoMessagePlayer> createState() => _VideoMessagePlayerState();
}

class _VideoMessagePlayerState extends State<VideoMessagePlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {}); // Cập nhật lại UI sau khi load xong
    });
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => FullscreenVideoPlayer(
                            controller: _controller,
                            url: widget.videoUrl,
                          ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      Positioned(
                        bottom: 8.0,
                        right: 8.0,
                        child: IconButton(
                          icon: Icon(
                            _isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FullscreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final String url;
  const FullscreenVideoPlayer({
    Key? key,
    required this.controller,
    required this.url,
  }) : super(key: key);

  @override
  _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  double _currentVolume = 1.0;
  @override
  void initState() {
    super.initState();
    if (!widget.controller.value.isInitialized) {
      widget.controller.initialize().then((_) {
        setState(() {}); // Refresh UI after initialization
        widget.controller.play();
      });
    } else {
      widget.controller.play();
    }
  }

  @override
  void dispose() {
    widget.controller.pause();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (widget.controller.value.isPlaying) {
        widget.controller.pause();
      } else {
        widget.controller.play();
      }
    });
  }

  void _onVolumeChanged(double value) {
    setState(() {
      _currentVolume = value;
      widget.controller.setVolume(_currentVolume);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Video Player'),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: AppColors.chatBackground),
            tooltip: 'Tải về',
            onPressed: () async {
              if (widget.url == null || widget.url.isEmpty) return;

              // Yêu cầu quyền (chỉ Android)
              if (Platform.isAndroid) {
                // Với Android 11 trở lên, dùng manageExternalStorage
                if (await Permission.manageExternalStorage.isGranted == false) {
                  final status =
                      await Permission.manageExternalStorage.request();
                }
              }

              try {
                final response = await http.get(Uri.parse(widget.url));
                if (response.statusCode == 200) {
                  final bytes = response.bodyBytes;

                  // Lấy tên file từ url
                  final fileName = widget.url.split('/').last;

                  // Tìm thư mục Downloads
                  final directory =
                      Platform.isAndroid
                          ? Directory(
                            '/storage/emulated/0/Download',
                          ) // Android Downloads
                          : await getApplicationDocumentsDirectory(); // iOS fallback

                  final filePath = '${directory.path}/$fileName';
                  final file = File(filePath);

                  await file.writeAsBytes(bytes);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Video is downloaded successfully')),
                  );

                  // Tùy chọn: Mở file sau khi tải
                  // await OpenFile.open(filePath);
                } else {
                  throw Exception('Error: ${response.statusCode}');
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cannot download file: $e')),
                );
              }
            },
          ),
        ],
      ),
      body:
          widget.controller.value.isInitialized
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hiển thị video đúng tỷ lệ gốc
                  AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: VideoPlayer(widget.controller),
                      ),
                    ),
                  ),

                  // Thanh tiến trình
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: VideoProgressIndicator(
                      widget.controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.red,
                        backgroundColor: Colors.grey.shade700,
                        bufferedColor: Colors.white38,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Điều khiển phát/dừng và âm lượng
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            widget.controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.volume_up, color: Colors.white),
                        Expanded(
                          child: Slider(
                            value: _currentVolume,
                            min: 0,
                            max: 1,
                            divisions: 10,
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            onChanged: _onVolumeChanged,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({Key? key, required this.imageUrl})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Image'),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: AppColors.chatBackground),
            tooltip: 'Tải về',
            onPressed: () async {
              final url = imageUrl;
              if (url == null || url.isEmpty) return;

              // Yêu cầu quyền (chỉ Android)
              if (Platform.isAndroid) {
                // Với Android 11 trở lên, dùng manageExternalStorage
                if (await Permission.manageExternalStorage.isGranted == false) {
                  final status =
                      await Permission.manageExternalStorage.request();
                }
              }

              try {
                final response = await http.get(Uri.parse(url));
                if (response.statusCode == 200) {
                  final bytes = response.bodyBytes;

                  // Lấy tên file từ url
                  final fileName = url.split('/').last;

                  // Tìm thư mục Downloads
                  final directory =
                      Platform.isAndroid
                          ? Directory(
                            '/storage/emulated/0/Download',
                          ) // Android Downloads
                          : await getApplicationDocumentsDirectory(); // iOS fallback

                  final filePath = '${directory.path}/$fileName';
                  final file = File(filePath);

                  await file.writeAsBytes(bytes);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Image is downloaded successfully')),
                  );

                  // Tùy chọn: Mở file sau khi tải
                  // await OpenFile.open(filePath);
                } else {
                  throw Exception('Error: ${response.statusCode}');
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cannot download file: $e')),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          loadingBuilder:
              (context, event) =>
                  const Center(child: CircularProgressIndicator()),
          errorBuilder:
              (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
              ),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
