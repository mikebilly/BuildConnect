import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/features/auth/providers/auth_service_provider.dart';
import 'package:buildconnect/features/auth/services/auth_service.dart';
import 'package:buildconnect/features/posting/providers/posting_provider.dart';
import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:buildconnect/shared/widgets/add_chips_widget.dart';

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
  late final AuthService _authService = ref.read(authServiceProvider);

  /// Local states
  JobPostingType _jobPostingType = JobPostingType.values.first;
  String _jobTitle = "";
  final _jobTitleController = TextEditingController();

  // final City _location = "";
  // City _location = City.values.first;
  // final _locationController = TextEditingController();
  City _mainCity = City.values.first;
  // final _mainAddress = TextEditingController();
  // final Set<City> _operatingAreasSet = {};
  WorkingMode _workingMode = WorkingMode.values.first;
  String _description = "";
  final _descriptionController = TextEditingController();

  DateTime? _deadline;
  final _deadlineController = TextEditingController();

  // final TextEditingController _requiredSkillsController =
  //     TextEditingController();
  final Set<Domain> _requiredSkillsList = {};

  // List<String> _requiredSkillsList = [];

  // double _budget = 1;
  final _budgetController = TextEditingController(text: "1");

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

  Future<void> _submit() async {
    final newPostModel = PostModel(
      authorId: _authService.currentUserId ?? 'unknown',
      // authorId: "vanhID",
      title: _jobTitleController.text,
      location: _mainCity,
      description: _descriptionController.text,
      budget:
          _budgetController.text.isEmpty
              ? 0
              : double.tryParse(_budgetController.text) ?? 0,
      deadline: _deadline ?? DateTime.now(),
      requiredSkills: _requiredSkillsList.toList(),
      jobPostingType: _jobPostingType,
      workingMode: _workingMode,
    );
    debugPrint(newPostModel.toString());

    try {
      await _postingNotifier.createNewPost(newPostModel);
      debugPrint(newPostModel.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created successfully')),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to create post: $e')));
      }
    }
  }

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
      appBar: AppBar(title: const Text('Create a post')),
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

              heightWidget(
                widget: buildTextFormField(
                  controller: _jobTitleController,
                  labelText: 'Job Title',
                  maxLines: 1,
                  hintText: 'Enter the title of the job posting',
                ),
              ),
              // heightWidget(
              //   widget: buildTextFormField(
              //     controller: _locationController,
              //     labelText: 'Job Location',
              //     maxLines: 1,
              //     hintText: 'Enter the Location of the job ',
              //   ),
              // ),
              heightWidget(
                widget: buildDropdownSearch(
                  title: '',
                  boldTitle: false,
                  selectedValue: _mainCity,
                  values: City.values,
                  onChanged: (v) {
                    setState(() {
                      _mainCity = v!;
                    });
                  },
                ),
                height: 8,
              ),
              heightWidget(
                widget: buildTextFormField(
                  controller: _descriptionController,
                  labelText: 'Job Description',
                  maxLines: 3,
                  hintText: 'Enter the Description of the job posting',
                ),
              ),

              // heightWidget(
              //   widget: buildSlider(
              //     controller: _budgetController,
              //     labelText: 'Job Budget',
              //     value: 1000,
              //     min: 1000,
              //     max: 10000000000,
              //     unit: "VND",
              //     onChanged: (val) {
              //       setState(() {
              //         _budget = val.round();
              //       });
              //     },
              //   ),
              // ),
              heightWidget(
                widget: buildTextFormField(
                  controller: _budgetController,
                  labelText: 'Job Budget',
                  maxLines: 1,
                  hintText: 'Enter the budget of the job posting',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
              ),
              heightWidget(
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Job Deadline',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // const Text('Job Deadline'),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _deadline ?? now,
                          firstDate: now,
                          lastDate: DateTime(now.year + 10),
                        );
                        if (picked != null) {
                          setState(() {
                            _deadline = picked;
                            _deadlineController.text =
                                "${picked.day}/${picked.month}/${picked.year}";
                          });
                        }
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: _deadlineController,
                          decoration: const InputDecoration(
                            hintText: 'Pick a deadline',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // heightWidget(
              //   widget: buildTextFormField(
              //     controller: _requiredSkillsController,
              //     labelText: 'Job skill',
              //     maxLines: 1,
              //     hintText: 'Enter the Job skill of the job posting',
              //   ),
              // ),
              // heightWidget(
              //   widget: SkillInputField(
              //     title: 'Required Skills (Optional)',
              //     buttonColor: AppColors.primary,
              //     chipTextColor: AppColors.grey,
              //     chipBackgroundColor: const Color.fromARGB(
              //       255,
              //       247,
              //       251,
              //       241,
              //     ).withAlpha((0.6 * 255).round()),
              //     onSkillListChanged: (skills) {
              //       setState(() {
              //         _requiredSkillsList = skills;
              //       });
              //       debugPrint('Danh sách kỹ năng: $_requiredSkillsList');
              //     },
              //   ),
              // ),
              heightWidget(
                widget: buildFilterChip(
                  values: Domain.values,
                  selectedValues: _requiredSkillsList,
                  onSelected: (v, selected) {
                    setState(() {
                      if (selected) {
                        _requiredSkillsList.add(v);
                      } else {
                        _requiredSkillsList.remove(v);
                      }
                    });
                  },
                ),
              ),
              heightWidget(
                widget: buildDropdownSearch(
                  title: 'Working Mode',
                  boldTitle: false,
                  selectedValue: _workingMode,
                  values: WorkingMode.values,
                  onChanged: (v) {
                    setState(() {
                      _workingMode = v!;
                    });
                  },
                ),
                height: 8,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              _submit();
            },
            child: const Text("Save Post"),
          ),
        ),
      ),
    );
  }
}
