import 'package:buildconnect/core/theme/theme.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:buildconnect/models/post/post_model.dart';
import 'package:flutter/material.dart';
export 'package:buildconnect/shared/widgets/form_widgets.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/services.dart';

class EditPostDialog extends StatefulWidget {
  final PostModel post;
  final void Function(PostModel updatedPost) onSave;

  const EditPostDialog({super.key, required this.post, required this.onSave});

  @override
  State<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  late JobPostingType _jobPostingType;
  late TextEditingController _jobTitleController;
  late TextEditingController _descriptionController;
  late WorkingMode _workingMode;
  late ProfileType _profileType;
  late TextEditingController _budgetController;
  late City _mainCity;
  DateTime? _deadline;
  late TextEditingController _deadlineController;
  late Set<Domain> _requiredSkillsList = {};

  // Các state khác như _profileType, _mainCity, _requiredSkillsList,...

  @override
  void initState() {
    super.initState();

    _jobPostingType = widget.post.jobPostingType;
    _jobTitleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(
      text: widget.post.description,
    );
    _workingMode = widget.post.workingMode!;
    _profileType = widget.post.profileType!;
    _mainCity = widget.post.location;
    _budgetController = TextEditingController(
      text: widget.post.budget != null ? widget.post.budget!.toString() : "",
    );
    _deadline = widget.post.deadline;

    _deadlineController = TextEditingController(
      text:
          widget.post.deadline != null
              ? "${widget.post.deadline!.day}/${widget.post.deadline!.month}/${widget.post.deadline!.year}"
              : "",
    );

    _requiredSkillsList =
        widget.post.requiredSkills != null
            ? widget.post.requiredSkills!.toSet()
            : <Domain>{};
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Post'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            heightWidget(
              widget: buildDrowndownButtonFormField(
                gap: 4,
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
              widget: buildDrowndownButtonFormField(
                gap: 4,
                selectedValue: _profileType,
                values: ProfileType.values,
                onChanged: (v) {
                  setState(() {
                    _profileType = v!;
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
            heightWidget(
              widget: buildDrowndownButtonFormField(
                gap: 4,
                title: 'City',
                // boldTitle: true,
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
                hintText: 'Enter the description of the job posting',
              ),
            ),
            heightWidget(
              widget: buildTextFormField(
                controller: _budgetController,
                labelText: 'Job Budget (VNĐ)',
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
              widget: buildDrowndownButtonFormField(
                gap: 4,
                title: 'Working Mode',
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
            // Tiếp tục các widget khác như profileType, location, skills,... theo cách tương tự
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Thu thập dữ liệu từ controller + biến trạng thái
            final updatedPost = widget.post.copyWith(
              jobPostingType: _jobPostingType,
              title: _jobTitleController.text,
              description: _descriptionController.text,
              budget:
                  _budgetController.text.isEmpty
                      ? 0
                      : double.tryParse(_budgetController.text) ?? 0,
              deadline: _deadline ?? DateTime.now(),
              requiredSkills: _requiredSkillsList.toList(),
              workingMode: _workingMode,
              profileType: _profileType,
              // các field khác
            );
            widget.onSave(updatedPost);
            Navigator.of(context).pop(true);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
