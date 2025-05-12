import 'package:flutter/material.dart';
import 'package:buildconnect/core/theme/theme.dart';

class SkillInputField extends StatefulWidget {
  final String title;
  final String hintText;
  final Color backgroundColor;
  final Color chipTextColor;
  final Color chipBackgroundColor;
  final Color buttonColor;
  final void Function(List<String>)? onSkillListChanged;

  const SkillInputField({
    super.key,
    this.title = 'Required Skills (Optional)',
    this.hintText = 'Add a required skill',
    this.backgroundColor = AppColors.background, // Colors.grey[100]
    this.chipTextColor = AppColors.text,
    this.chipBackgroundColor = AppColors.accent, // AppColors.primary with alpha
    this.buttonColor = AppColors.primary,
    this.onSkillListChanged,
  });

  @override
  State<SkillInputField> createState() => _SkillInputFieldState();
}

class _SkillInputFieldState extends State<SkillInputField> {
  final TextEditingController _skillController = TextEditingController();
  final List<String> _skills = [];

  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
      });
      _skillController.clear();
      widget.onSkillListChanged?.call(_skills);
    }
  }

  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
    widget.onSkillListChanged?.call(_skills);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _skillController,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  filled: true,
                  fillColor: widget.backgroundColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => _addSkill(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addSkill,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _skills.asMap().entries.map((entry) {
                final index = entry.key;
                final skill = entry.value;
                return Chip(
                  label: Text(skill),
                  // backgroundColor: widget.chipBackgroundColor,
                  // labelStyle: TextStyle(color: widget.chipTextColor),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () => _removeSkill(index),
                );
              }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

//use:
// SkillInputField(
//   title: 'Required Skills (Optional)',
//   buttonColor: AppColors.primary,
//   chipTextColor: AppColors.text,
//   chipBackgroundColor: AppColors.primary.withOpacity(0.1),
//   onSkillListChanged: (skills) {
//     print('Danh sách kỹ năng: $skills');
//     // Có thể setState hay truyền vào model nếu cần
//   },
// )
