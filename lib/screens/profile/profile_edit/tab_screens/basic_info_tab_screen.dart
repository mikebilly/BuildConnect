import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/scheduler.dart';

import 'package:buildconnect/models/profile/profile_model.dart';

class BasicInfoTabScreen extends ConsumerStatefulWidget {
  const BasicInfoTabScreen({super.key});

  @override
  ConsumerState<BasicInfoTabScreen> createState() => BasicInfoTabScreenState();
}

class BasicInfoTabScreenState extends ConsumerState<BasicInfoTabScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  ////
  final _displayName = TextEditingController();
  ProfileType _profileType = ProfileType.values.first;
  final _bio = TextEditingController();
  AvailabilityStatus _availabilityStatus = AvailabilityStatus.values.first;

  int _yearsOfExperience = 1;
  final _yearsOfExperienceController = TextEditingController(text: '1');

  WorkingMode _workingMode = WorkingMode.values.first;
  final Set<Domain> _domains = {};
  final Set<PaymentMethod> _paymentMethods = {};
  BusinessEntityType _businessEntityType = BusinessEntityType.values.first;

  ///

  @override
  void initState() {
    super.initState();
    _profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);
  }

  bool _initialized = false;
  void _loadData() {
    final profileData = ref.read(profileDataNotifierProvider);
    final _data = profileData.valueOrNull;

    if (_data != null && !_initialized) {
      final data = _data.profile;
      debugPrint('Initializing data: $data');
      setState(() {
        /////////////// Load data
        _displayName.text = data.displayName;
        _profileType = data.profileType;
        _bio.text = data.bio;
        _availabilityStatus = data.availabilityStatus;
        _yearsOfExperience = data.yearsOfExperience;
        _yearsOfExperienceController.text = data.yearsOfExperience.toString();
        _workingMode = data.workingMode;
        _domains.addAll(data.domains);
        _paymentMethods.addAll(data.paymentMethods);
        _businessEntityType = data.businessEntityType;

        ///////////////
        _initialized = true;
      });
    } else {
      if (_data == null) {
        debugPrint('Error at load to basic info: ProfileData is null');
      }
    }
  }

  Future<void> dumpFromControllers() async {
    // Future(() {
    Profile newProfile = Profile(
      displayName: _displayName.text,
      profileType: _profileType,
      bio: _bio.text,
      availabilityStatus: _availabilityStatus,
      yearsOfExperience: _yearsOfExperience,
      workingMode: _workingMode,
      domains: _domains.toList(),
      paymentMethods: _paymentMethods.toList(),
      businessEntityType: _businessEntityType,
      contacts: [],
    );
    debugPrint('Right before dumping at basic info: $newProfile');
    await Future.microtask(() async {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
      await _profileDataNotifier.dumpFromControllers(
        // designStyles: _designStyles.toList(),
        // portfolioLinks: _portfolioLinks,
        profile: newProfile,
      );
    });
  }

  @override
  void dispose() {
    debugPrint('Disposing');
    dumpFromControllers();

    // _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileDataNotifierProvider);

    // Bind controller only once when data is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
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
                    _profileType = v!;
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
                  _availabilityStatus = v!;
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
                  _workingMode = v!;
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
                  _businessEntityType = v!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
