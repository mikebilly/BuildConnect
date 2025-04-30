import 'package:buildconnect/features/posting/providers/posting_provider.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:buildconnect/models/post/post_model.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  late final PostingNotifier _postingNotifier;

  /// Local states
  JobPostingType _jobPostingType = JobPostingType.values.first;

  ///

  @override
  void initState() {
    super.initState();
    _postingNotifier = ref.read(postingNotifierProvider.notifier);
  }

  bool _initialized = false;
  void _loadData() {
    final profileData = ref.read(profileDataNotifierProvider);
    final data = profileData.valueOrNull;

    if (data != null && !_initialized) {
      debugPrint('Initializing data: $data');
      setState(() {
        /////////////// Load data

        ///////////////
        _initialized = true;
      });
    }
  }

  // Future<void> _createPost() async {
  //   final newPostModel = PostModel(

  //   );

  //   await _postingNotifier.createPost(
  //     postingModel: newPostModel,
  //   );
  // }

  @override
  void dispose() {
    debugPrint('Disposing');
    // Future(() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // _postingNotifier.dumpFromControllers(
      // designStyles: _designStyles.toList(),
      // portfolioLinks: _portfolioLinks,
      // );
    });

    // _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posting = ref.watch(postingNotifierProvider);

    // Bind controller only once when data is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Create a Post')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // heightWidget(widget: headerText(text: "Create a job posting")),
              heightWidget(
                widget: buildDrowndownButtonFormField(
                  selectedValue: _jobPostingType,
                  values: JobPostingType.values,
                  onChanged: (v) {
                    setState(() {
                      _jobPostingType = v!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
