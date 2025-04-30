import 'package:dart_mappable/dart_mappable.dart';
import 'package:buildconnect/models/enums/enums.dart';

part 'supplier_profile_model.mapper.dart';

@MappableClass()
class SupplierProfile with SupplierProfileMappable {
  final String? profileId;

  final SupplierType supplierType;
  final List<MaterialCategory> materialCategories;
  // final String supplyCapacity;
  final int deliveryRadius;
  // final List<Location> warehouseLocations;
  // final List<Media> catalogs;

  const SupplierProfile({
    this.profileId,
    required this.supplierType,
    required this.materialCategories,
    // required this.supplyCapacity,
    required this.deliveryRadius,
    // required this.warehouseLocations,
    // required this.catalogs,
  });

  factory SupplierProfile.empty() {
    return SupplierProfile(
      supplierType: SupplierType.values.first,
      materialCategories: [],
      deliveryRadius: 0,
    );
  }
}
