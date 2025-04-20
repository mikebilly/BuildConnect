  import 'package:flutter/material.dart';

  Widget heightWidget({required Widget widget, double height = 16.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [widget, SizedBox(height: height)],
    );
  }

  Widget buildTextFormField({
    // add validator
    required TextEditingController controller,
    required String labelText,
    String hintText = '',
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
      maxLines: maxLines,
    );
  }

  Widget buildDrowndownButtonFormField<T>({
    required T selectedValue,
    required List<T> values,
    required void Function(T?) onChanged,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<T>(
          value: selectedValue,
          items:
              values.map((v) {
                return DropdownMenuItem<T>(
                  value: v,
                  child: Text((v as dynamic).label),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildSlider({
    required String labelText,
    required int value,
    required ValueChanged<double> onChanged,
    int min = 0,
    int max = 50,
    int? divisions,
    String? unit,
  }) {
    return Row(
      children: [
        Text(labelText),
        const SizedBox(width: 16),
        Expanded(
          child: Slider(
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: divisions,
            // label: '$value${unit != null ? ' $unit' : ''}',
            label: value.toString(),
            onChanged: onChanged,
          ),
        ),
        Text('$value${unit != null ? ' $unit' : ''}'),
      ],
    );
  }

  Widget buildFilterChip<T>({
    double spacing = 5.0,
    required List<T> values,
    required Set<T> selectedValues,
    required void Function(T value, bool selected) onSelected,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: spacing,
          children:
              values.map((v) {
                final bool isSelected = selectedValues.contains(v);
                return FilterChip(
                  label: Text((v as dynamic).label),
                  selected: isSelected,
                  onSelected: (selected) {
                    onSelected(v, selected);
                  },
                );
              }).toList(),
        ),
      ],
    );
  }