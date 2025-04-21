import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:buildconnect/models/enums/enums.dart';

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
  ////
  final _displayName = TextEditingController();
  ProfileType? _profileType = ProfileType.values.first;
  final _bio = TextEditingController();
  AvailabilityStatus? _availabilityStatus = AvailabilityStatus.values.first;
  
  int _yearsOfExperience = 1;
  final _yearsOfExperienceController = TextEditingController(text: '1');

  WorkingMode? _workingMode = WorkingMode.values.first;
  final Set<Domain> _domains = {};
  final Set<PaymentMethod> _paymentMethods = {};
  BusinessEntityType? _businessEntityType = BusinessEntityType.values.first;

  ///

  late final ProfileDataNotifier _profileDataNotifier;

  final _jobPosting = TextEditingController();

  final _email = TextEditingController();

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
      debugPrint('ProfileDataNotifier dispose called');
      debugPrint('ProfileType: $_profileType');

      _profileDataNotifier.dumpFromControllers(
        displayName: _displayName.text,
        profileType: _profileType,
      );
    });

    _email.dispose();
    super.dispose();
  }

  bool _initialized = false;
  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileDataNotifierProvider);

    // Bind controller only once when data is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = profileData.valueOrNull;
      if (data != null && !_initialized) {
        debugPrint('Initializing data: $data');
        setState(() {
          _displayName.text = data.displayName;
          _profileType = data.profileType;
          _initialized = true;
        });
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightWidget(widget: headerText(text: 'Basic Info')),
            heightWidget(
              widget: buildTextFormField(
                controller: _displayName,
                labelText: "Display name",
                // hintText: 'Type your display name',
              ),
            ),
            heightWidget(
              widget: buildDrowndownButtonFormField(
                selectedValue: _profileType,
                values: ProfileType.values.toList(),
                onChanged: (v) {
                  setState(() {
                    _profileType = v;
                    debugPrint(_profileType?.toString());
                  });
                },
              ),
            ),
            heightWidget(
              widget: buildTextFormField(
                controller: _bio,
                labelText: "Bio",
                maxLines: 3,
              ),
            ),
            heightWidget(
              widget: buildDrowndownButtonFormField(
                selectedValue: _availabilityStatus,
                values: AvailabilityStatus.values,
                onChanged: (v) {
                  _availabilityStatus = v;
                },
              ),
            ),
            heightWidget(
              widget: buildSlider(
                labelText: 'Years of experience',
                value: _yearsOfExperience,
                controller: _yearsOfExperienceController,
                min: 1,
                max: 50,
                unit: 'years',
                onChanged: (val) {
                  setState(() {
                    _yearsOfExperience = val.round();
                  });
                },
              ),
            ),
            heightWidget(
              widget: buildDrowndownButtonFormField(
                selectedValue: _workingMode,
                values: WorkingMode.values,
                onChanged: (v) {
                  _workingMode = v;
                },
              ),
            ),
            heightWidget(
              widget: buildFilterChip(
                values: Domain.values,
                selectedValues: _domains,
                onSelected: (v, selected) {
                  setState(() {
                    if (selected) {
                      _domains.add(v);
                    } else {
                      _domains.remove(v);
                    }
                  });
                },
              ),
            ),
            heightWidget(
              widget: buildFilterChip(
                values: PaymentMethod.values,
                selectedValues: _paymentMethods,
                onSelected: (v, selected) {
                  setState(() {
                    if (selected) {
                      _paymentMethods.add(v);
                    } else {
                      _paymentMethods.remove(v);
                    }
                  });
                },
              ),
            ),
            heightWidget(
              widget: buildDrowndownButtonFormField(
                selectedValue: _businessEntityType,
                values: BusinessEntityType.values,
                onChanged: (v) {
                  _businessEntityType = v;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
