import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/shared/common_widgets.dart';

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
  const BasicInfoTabScreen({super.key});

  @override
  ConsumerState<BasicInfoTabScreen> createState() => _BasicInfoTabScreenState();
}

class _BasicInfoTabScreenState extends ConsumerState<BasicInfoTabScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  final _jobPosting = TextEditingController();

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
            heightWidget(widget: const Text('Hi')),
            heightWidget(
              widget: buildTextFormField(
                controller: _displayText,
                labelText: "Text form",
                hintText: 'hintttt',
              ),
            ),
            heightWidget(
              widget: buildDrowndownButtonFormField(
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
            heightWidget(
              widget: buildSlider(
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
            heightWidget(
              widget: buildFilterChip(
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
            heightWidget(
              widget: buildTextFormField(
                controller: _email,
                labelText: "Email",
              ),
            ),
            heightWidget(
              widget: buildTextFormField(
                controller: _jobPosting,
                labelText: "Job posting",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
