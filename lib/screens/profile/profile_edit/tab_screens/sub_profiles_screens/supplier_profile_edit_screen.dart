import 'package:buildconnect/features/profile_data/providers/profile_data_provider.dart';
import 'package:buildconnect/models/sub_profiles/supplier_profile/supplier_profile_model.dart';
import 'package:buildconnect/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:buildconnect/models/enums/enums.dart';
import 'package:flutter/scheduler.dart';

class SupplierProfileEditScreen extends ConsumerStatefulWidget {
  const SupplierProfileEditScreen({super.key});

  @override
  ConsumerState<SupplierProfileEditScreen> createState() =>
      SupplierProfileEditScreenState();
}

class SupplierProfileEditScreenState
    extends ConsumerState<SupplierProfileEditScreen> {
  late final ProfileDataNotifier _profileDataNotifier;

  /// Local states
  SupplierType? _supplierType = SupplierType.values.first;

  List<MaterialCategory> _materialCategories = [];
  Set<MaterialCategory> _materialCategoriesSet = {};

  int _deliveryRadius = 1;
  final _deliveryRadiusController = TextEditingController(text: '1');

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

    if (_data != null && !_initialized && _data.supplierProfile != null) {
      final data = _data.supplierProfile!;
      debugPrint('Initializing data: $data');
      setState(() {
        /////////////// Load data
        _supplierType = data.supplierType;
        _materialCategoriesSet = data.materialCategories.toSet();
        _deliveryRadius = data.deliveryRadius;
        _deliveryRadiusController.text = data.deliveryRadius.toString();
        ///////////////
        _initialized = true;
      });
    }
  }

  Future<void> dumpFromControllers() async {
    final newSupplierProfile = SupplierProfile(
      supplierType: _supplierType!,
      materialCategories: _materialCategoriesSet.toList(),
      deliveryRadius:
          _deliveryRadiusController.text.isNotEmpty
              ? int.parse(_deliveryRadiusController.text)
              : 1,
    );
    debugPrint('Disposing');
    // Future(() {
    debugPrint('Right before dumping at supplier: $newSupplierProfile');
    await Future.microtask(() async {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
      _profileDataNotifier.dumpFromControllers(
        supplierProfile: newSupplierProfile,
        // designStyles: _designStyles.toList(),
        // portfolioLinks: _portfolioLinks,
      );
    });
  }

  @override
  void dispose() {
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
            heightWidget(widget: headerText(text: "Supplier Profile")),

            heightWidget(
              widget: buildDrowndownButtonFormField(
                selectedValue: _supplierType,
                values: SupplierType.values,
                onChanged: (v) {
                  setState(() {
                    _supplierType = v;
                  });
                },
              ),
            ),

            heightWidget(
              widget: buildFilterChip(
                values: MaterialCategory.values,
                selectedValues: _materialCategoriesSet,
                onSelected: (v, selected) {
                  setState(() {
                    if (selected) {
                      _materialCategoriesSet.add(v);
                    } else {
                      _materialCategoriesSet.remove(v);
                    }
                  });
                },
              ),
            ),

            heightWidget(
              widget: buildSlider(
                labelText: 'Delivery Radius',
                value: _deliveryRadius,
                controller: _deliveryRadiusController,
                min: 1,
                max: 500,
                unit: 'km',
                onChanged: (v) {
                  setState(() {
                    _deliveryRadius = v.toInt();
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
