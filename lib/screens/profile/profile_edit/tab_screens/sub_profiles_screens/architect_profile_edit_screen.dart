import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/models/sub_profiles/architect_profile/architect_profile_model.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/scheduler.dart';

class ArchitectProfileEditScreen extends ConsumerStatefulWidget {
  const ArchitectProfileEditScreen({super.key});

  @override
  ConsumerState<ArchitectProfileEditScreen> createState() =>
      _ArchitectProfileEditScreenState();
}

class _ArchitectProfileEditScreenState
    extends ConsumerState<ArchitectProfileEditScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  ///
  ArchitectRole? _architectRole = ArchitectRole.values.first;

  String _designPhilosophy = '';
  final _designPhilosophyController = TextEditingController();

  List<DesignStyle> _designStyles = [];
  Set<DesignStyle> _designStylesSet = {};

  final List<String> _portfolioLinks = [];
  final List<TextEditingController> _portfolioLinksControllers = [];

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

    if (_data != null && !_initialized && _data.architectProfile != null) {
      final data = _data.architectProfile!;
      debugPrint('Initializing data: $data');
      setState(() {
        ///////////////
        //
        _architectRole = data.architectRole;
        _designPhilosophyController.text = data.designPhilosophy;
        _designPhilosophy = data.designPhilosophy;
        _designStylesSet = data.designStyles.toSet();

        for (final portfolioLink in data.portfolioLinks) {
          _portfolioLinksControllers.add(
            TextEditingController(text: portfolioLink),
          );
        }

        ///////////////
        _initialized = true;
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _portfolioLinksControllers) {
      debugPrint('Disposing controller: ${controller.text}');
      if (controller.text.isNotEmpty) {
        _portfolioLinks.add(controller.text);
      }
      controller.dispose();
    }
    _portfolioLinksControllers.clear();

    _designStyles = _designStylesSet.toList();
    _designPhilosophy = _designPhilosophyController.text;

    debugPrint('Disposing');
    // Future(() {
    final newArchitectProfile = ArchitectProfile(
      architectRole: _architectRole!,
      designPhilosophy: _designPhilosophy,
      designStyles: _designStyles,
      portfolioLinks: _portfolioLinks,
    );
    
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _profileDataNotifier.dumpFromControllers(
        architectProfile: newArchitectProfile,
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
            heightWidget(widget: headerText(text: "Architect Profile")),

            heightWidget(
              widget: buildDrowndownButtonFormField(
                selectedValue: _architectRole,
                values: ArchitectRole.values,
                onChanged: (v) {
                  setState(() {
                    _architectRole = v;
                  });
                },
              ),
            ),

            heightWidget(
              widget: buildTextFormField(
                controller: _designPhilosophyController,
                labelText: 'Design Philosophy',
                maxLines: 3,
              ),
            ),

            heightWidget(
              widget: buildFilterChip(
                values: DesignStyle.values,
                selectedValues: _designStylesSet,
                onSelected: (v, selected) {
                  setState(() {
                    if (selected) {
                      _designStylesSet.add(v);
                    } else {
                      _designStylesSet.remove(v);
                    }
                  });
                },
              ),
            ),

            heightWidget(
              widget: buildControllerList(
                title: "Portfolio Links",
                type: 'Link',
                hintText: 'https://...',
                controllers: _portfolioLinksControllers,
                onAdd: () {
                  setState(() {
                    _portfolioLinksControllers.add(TextEditingController());
                  });
                },
                onRemove: (index) {
                  setState(() {
                    _portfolioLinksControllers.removeAt(index);
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
