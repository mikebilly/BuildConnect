import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget heightWidget({required Widget widget, double height = 16.0}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [widget, SizedBox(height: height)],
  );
}

Widget headerText({required String text}) {
  return Text(
    text,
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  );
}

Widget buildTextFormField({
  // add validator
  required TextEditingController controller,
  required String labelText,
  String hintText = '',
  int maxLines = 1,
  Widget? suffixIcon,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      suffixIcon: suffixIcon,
    ),
    maxLines: maxLines,
    inputFormatters: inputFormatters,
  );
}

Widget buildDrowndownButtonFormField<T>({
  required T selectedValue,
  required List<T> values,
  required void Function(T?) onChanged,
  String? title,
  String? labelText,
  double gap = 0,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title ?? ((selectedValue as dynamic).title),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: gap),
      DropdownButtonFormField<T>(
        value: selectedValue,
        decoration: InputDecoration(labelText: labelText),
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

// Widget buildSlider({
//   required String labelText,
//   required int value,
//   required ValueChanged<double> onChanged,
//   int min = 0,
//   int max = 50,
//   String? unit,
// }) {
//   return Row(
//     children: [
//       Text(labelText),
//       const SizedBox(width: 16),
//       Expanded(
//         child: Slider(
//           value: value.toDouble(),
//           min: min.toDouble(),
//           max: max.toDouble(),
//           divisions: max - min,
//           // label: '$value${unit != null ? ' $unit' : ''}',
//           label: value.toString(),
//           onChanged: onChanged,
//         ),
//       ),
//       Text('$value${unit != null ? ' $unit' : ''}'),
//     ],
//   );
// }

Widget buildSlider({
  required String labelText,
  required int value,
  required ValueChanged<int> onChanged,
  required TextEditingController controller,
  int min = 0,
  int max = 100,
  String? unit,
}) {
  return Row(
    children: [
      Text(labelText),
      const SizedBox(width: 16),

      /// Slider
      Expanded(
        child: Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          label: value.toString(),
          onChanged: (newValue) {
            final int rounded = newValue.round();
            controller.text = rounded.toString(); // sync text field
            onChanged(rounded); // update state
          },
        ),
      ),

      /// Number Input with clamping
      SizedBox(
        width: 60,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (text) {
            final newValue = int.tryParse(text);
            if (newValue != null) {
              final clamped = newValue.clamp(min, max);
              controller.text = clamped.toString(); // enforce boundary
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
              onChanged(clamped); // update slider
            }
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
          ),
        ),
      ),

      if (unit != null) Text(' $unit'),
    ],
  );
}

Widget buildFilterChip<T>({
  double spacing = 5.0,
  double runSpacing = 3.0,
  required List<T> values,
  required Set<T> selectedValues,
  required void Function(T value, bool selected) onSelected,
  String? title,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title ?? (values as dynamic).first.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
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

Widget buildControllerList({
  required List<TextEditingController> controllers,
  required VoidCallback onAdd,
  required void Function(int index) onRemove,
  required String title,
  required String hintText,
  required String type,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      ...controllers.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: buildTextFormField(
            controller: entry.value,
            labelText: '$type ${entry.key + 1}',
            hintText: hintText,
            suffixIcon:
                entry.key >= 0
                    ? IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => onRemove(entry.key),
                    )
                    : null,
          ),
        );
      }),
      const SizedBox(height: 8),
      ElevatedButton.icon(
        onPressed: onAdd,
        icon: const Icon(Icons.add),
        label: const Text('Add More'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    ],
  );
}
