import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MyEnum {
  one,
  two,
  three;

  String get label {
    switch (this) {
      case MyEnum.one:
        return '1';
      case MyEnum.two:
        return '2';
      case MyEnum.three:
        return '3';
    }
  }
}

class BasicInfoTabScreen extends ConsumerStatefulWidget {
  final String displayText;

  const BasicInfoTabScreen({super.key, required this.displayText});

  @override
  ConsumerState<BasicInfoTabScreen> createState() => _BasicInfoTabScreenState();
}

class _BasicInfoTabScreenState extends ConsumerState<BasicInfoTabScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  final _email = TextEditingController();

  final displayName = TextEditingController();
  // logo
  final _displayText = TextEditingController();

  MyEnum? _selectedMyEnum;

  final Set<MyEnum> _selectedMyEnums = {};

  int _sliderVal = 1;

  @override
  void initState() {
    super.initState();
    _profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);
  }

  @override
  void dispose() {
    Future(() {
      _profileDataNotifier.dumpFromControllers(email: _email.text);
    });

    _email.dispose();
    super.dispose();
  }

  Widget _heightWidget({required Widget widget, double height = 16.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [widget, SizedBox(height: height)],
    );
  }

  Widget _buildTextFormField({
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

  Widget _buildDrowndownButtonFormField<T>({
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

  Widget _buildSlider({
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

  Widget _buildFilterChip<T>({
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

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileDataNotifierProvider);

    // Bind controller only once when data is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = profileData.valueOrNull;
      if (data != null) {
        _email.text = data.email;
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heightWidget(widget: const Text('Hi')),
            _heightWidget(
              widget: _buildTextFormField(
                controller: _displayText,
                labelText: "Text form",
                hintText: 'hintttt',
              ),
            ),
            _heightWidget(
              widget: _buildDrowndownButtonFormField(
                selectedValue: _selectedMyEnum,
                values: MyEnum.values.toList(),
                title: "Title",
                onChanged:
                    ((newValue) => {
                      setState(() {
                        _selectedMyEnum = newValue;
                      }),
                    }),
              ),
            ),
            _heightWidget(
              widget: _buildSlider(
                labelText: 'Years of experience',
                value: _sliderVal,
                min: 1,
                max: 50,
                divisions: 49,
                unit: 'years',
                onChanged: (val) {
                  setState(() {
                    _sliderVal = val.round();
                  });
                },
              ),
            ),
            _heightWidget(
              widget: _buildFilterChip(
                values: MyEnum.values,
                selectedValues: _selectedMyEnums,
                title: "title",
                onSelected: (v, selected) {
                  setState(() {
                    if (selected) {
                      _selectedMyEnums.add(v);
                    } else {
                      _selectedMyEnums.remove(v);
                    }
                  });
                },
              ),
            ),
            _heightWidget(
              widget: _buildTextFormField(
                controller: _email,
                labelText: "Email",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
