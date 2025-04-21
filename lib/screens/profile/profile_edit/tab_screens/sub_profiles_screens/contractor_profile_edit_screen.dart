import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/scheduler.dart';

class ContractorProfileEditScreen extends ConsumerStatefulWidget {
  const ContractorProfileEditScreen({super.key});

  @override
  ConsumerState<ContractorProfileEditScreen> createState() =>
      _ContractorProfileEditScreenState();
}

class _ContractorProfileEditScreenState
    extends ConsumerState<ContractorProfileEditScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  /// Local states
  List<ServiceType> _services = [];
  final Set<ServiceType> _servicesSet = {};

  ///

  @override
  void initState() {
    super.initState();
    _profileDataNotifier = ref.read(profileDataNotifierProvider.notifier);
  }

  bool _initialized = false;
  void _loadData() {
    final profileData = ref.read(profileDataNotifierProvider);
    final data = profileData.valueOrNull;

    if (data != null && !_initialized) {
      debugPrint('Initializing data: $data');
      setState(() {
        /////////////// Load data

        ///////////////
        _initialized = true;
      });
    }
  }

  @override
  void dispose() {
    debugPrint('Disposing');
    // Future(() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _profileDataNotifier.dumpFromControllers(
        // designStyles: _designStyles.toList(),
        // portfolioLinks: _portfolioLinks,
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
            heightWidget(widget: headerText(text: "Contractor Profile")),

            heightWidget(
              widget: buildFilterChip(values: ServiceType.values, selectedValues: _servicesSet, onSelected: (v, selected) {
                setState(() {
                  if (selected) {
                    _servicesSet.add(v);
                  } else {
                    _servicesSet.remove(v);
                  }
                });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
