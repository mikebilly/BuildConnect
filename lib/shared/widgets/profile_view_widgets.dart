import 'package:flutter/material.dart';
import 'package:buildconnect/core/theme/theme.dart';  

Widget buildInfoRows({required List<dynamic> list}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        list.map((item) {
          return buildInfoRow(title: item.title, value: item.label);
        }).toList(),
  );
}

Widget buildInfoRow({required String title, required String value}) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('$title:', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(width: 8),
      Text(value),
      // Expanded(child: Text(value, textAlign: TextAlign.end)),
    ],
  );
}

Widget buildBoxContainer({required Widget widget}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      // color: const Color.fromARGB(107, 227, 244, 223),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.grey, width: 1),
      // boxShadow: [
      //   BoxShadow(
      //     color: const Color.fromARGB(
      //       255,
      //       185,
      //       212,
      //       186,
      //     ).withValues(alpha: 0.2),
      //     blurRadius: 4.0,
      //     offset: const Offset(0, 2),
      //   ),
      // ],
    ),
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.only(top: 16),
    child: widget,
  );
}

Widget displayFilterChip<T>({
  double spacing = 5.0,
  double runSpacing = 3.0,
  required List<T> values,
  required String title,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title.isNotEmpty)
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),

      Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children:
            values.map((v) {
              return FilterChip(
                label: Text((v as dynamic).label),
                onSelected: (selected) {},
              );
            }).toList(),
      ),
    ],
  );
}

// Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 Domain.values.first.title,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Wrap(
//                 spacing: 5,
//                 runSpacing: 3,
//                 children:
//                     profileData.profile.domains.map((v) {
//                       return FilterChip(
//                         label: Text(v.label),
//                         mouseCursor: MouseCursor.defer,
//                         onSelected: (selected) {},
//                       );
//                     }).toList(),
//               ),
//             ],
//           ),
//         )
