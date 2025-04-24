import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/models/sub_profiles/construction_team_profile/construction_team_profile_model.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class ConstructionTeamProfileEditScreen extends ConsumerStatefulWidget {
  const ConstructionTeamProfileEditScreen({super.key});

  @override
  ConsumerState<ConstructionTeamProfileEditScreen> createState() =>
      _ConstructionTeamProfileEditScreenState();
}

class _ConstructionTeamProfileEditScreenState
    extends ConsumerState<ConstructionTeamProfileEditScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  /// Local states
  int _teamSize = 1;
  final _teamSizeController = TextEditingController(text: '1');

  List<ServiceType> _services = [];
  Set<ServiceType> _servicesSet = {};

  String _representativeName = '';
  final _representativeNameController = TextEditingController();

  String _reprensentativePhone = '';
  final _representativePhoneController = TextEditingController();

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

    if (_data != null &&
        !_initialized &&
        _data.constructionTeamProfile != null) {
      final data = _data.constructionTeamProfile!;
      debugPrint('Initializing data: $data');
      setState(() {
        /////////////// Load data
        _representativeNameController.text = data.representativeName;
        _representativeName = data.representativeName;

        _representativePhoneController.text = data.representativePhone;
        _reprensentativePhone = data.representativePhone;

        _servicesSet = data.services.toSet();
        _teamSizeController.text = data.teamSize.toString();
        _teamSize = data.teamSize;

        ///////////////
        _initialized = true;
      });
    }
  }

  @override
  void dispose() {
    debugPrint('Disposing');
    final newConstructionTeamProfile = ConstructionTeamProfile(
      representativeName: _representativeNameController.text,
      representativePhone: _representativePhoneController.text,
      services: _servicesSet.toList(),
      teamSize: _teamSize,
    );
    // Future(() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _profileDataNotifier.dumpFromControllers(
        // designStyles: _designStyles.toList(),
        // portfolioLinks: _portfolioLinks,
        constructionTeamProfile: newConstructionTeamProfile,
      );
    });

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
            heightWidget(widget: headerText(text: "Construction Team Profile")),

            heightWidget(
              widget: buildTextFormField(
                controller: _representativeNameController,
                labelText: 'Representative Name',
                // hintText: 'Enter representative name',
              ),
            ),

            heightWidget(
              widget: buildTextFormField(
                controller: _representativePhoneController,
                labelText: 'Representative Phone',
                hintText: '0123456789',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
            ),

            heightWidget(
              widget: buildFilterChip(
                values: ServiceType.values,
                selectedValues: _servicesSet,
                onSelected: (v, selected) {
                  setState(() {
                    if (selected) {
                      _servicesSet.add(v);
                    } else {
                      _servicesSet.remove(v);
                    }
                  });
                },
              ),
            ),

            heightWidget(
              widget: buildSlider(
                labelText: 'Team size',
                value: _teamSize,
                controller: _teamSizeController,
                min: 1,
                max: 100,
                unit: 'people',
                onChanged: (v) {
                  setState(() {
                    _teamSize = v.round();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
