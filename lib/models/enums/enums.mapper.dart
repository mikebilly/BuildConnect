// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'enums.dart';

class ProfileTypeMapper extends EnumMapper<ProfileType> {
  ProfileTypeMapper._();

  static ProfileTypeMapper? _instance;
  static ProfileTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileTypeMapper._());
    }
    return _instance!;
  }

  static ProfileType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ProfileType decode(dynamic value) {
    switch (value) {
      case r'architect':
        return ProfileType.architect;
      case r'contractor':
        return ProfileType.contractor;
      case r'constructionTeam':
        return ProfileType.constructionTeam;
      case r'supplier':
        return ProfileType.supplier;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ProfileType self) {
    switch (self) {
      case ProfileType.architect:
        return r'architect';
      case ProfileType.contractor:
        return r'contractor';
      case ProfileType.constructionTeam:
        return r'constructionTeam';
      case ProfileType.supplier:
        return r'supplier';
    }
  }
}

extension ProfileTypeMapperExtension on ProfileType {
  String toValue() {
    ProfileTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ProfileType>(this) as String;
  }
}

class WorkingModeMapper extends EnumMapper<WorkingMode> {
  WorkingModeMapper._();

  static WorkingModeMapper? _instance;
  static WorkingModeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorkingModeMapper._());
    }
    return _instance!;
  }

  static WorkingMode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  WorkingMode decode(dynamic value) {
    switch (value) {
      case r'onsite':
        return WorkingMode.onsite;
      case r'remote':
        return WorkingMode.remote;
      case r'hybrid':
        return WorkingMode.hybrid;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(WorkingMode self) {
    switch (self) {
      case WorkingMode.onsite:
        return r'onsite';
      case WorkingMode.remote:
        return r'remote';
      case WorkingMode.hybrid:
        return r'hybrid';
    }
  }
}

extension WorkingModeMapperExtension on WorkingMode {
  String toValue() {
    WorkingModeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<WorkingMode>(this) as String;
  }
}

class DomainMapper extends EnumMapper<Domain> {
  DomainMapper._();

  static DomainMapper? _instance;
  static DomainMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DomainMapper._());
    }
    return _instance!;
  }

  static Domain fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Domain decode(dynamic value) {
    switch (value) {
      case r'residential':
        return Domain.residential;
      case r'commercial':
        return Domain.commercial;
      case r'industrial':
        return Domain.industrial;
      case r'hospitality':
        return Domain.hospitality;
      case r'urbanPlanning':
        return Domain.urbanPlanning;
      case r'education':
        return Domain.education;
      case r'healthcare':
        return Domain.healthcare;
      case r'cultural':
        return Domain.cultural;
      case r'infrastructure':
        return Domain.infrastructure;
      case r'renovation':
        return Domain.renovation;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Domain self) {
    switch (self) {
      case Domain.residential:
        return r'residential';
      case Domain.commercial:
        return r'commercial';
      case Domain.industrial:
        return r'industrial';
      case Domain.hospitality:
        return r'hospitality';
      case Domain.urbanPlanning:
        return r'urbanPlanning';
      case Domain.education:
        return r'education';
      case Domain.healthcare:
        return r'healthcare';
      case Domain.cultural:
        return r'cultural';
      case Domain.infrastructure:
        return r'infrastructure';
      case Domain.renovation:
        return r'renovation';
    }
  }
}

extension DomainMapperExtension on Domain {
  String toValue() {
    DomainMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Domain>(this) as String;
  }
}

class CityMapper extends EnumMapper<City> {
  CityMapper._();

  static CityMapper? _instance;
  static CityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CityMapper._());
    }
    return _instance!;
  }

  static City fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  City decode(dynamic value) {
    switch (value) {
      case r'hanoi':
        return City.hanoi;
      case r'hoChiMinh':
        return City.hoChiMinh;
      case r'daNang':
        return City.daNang;
      case r'ninhBinh':
        return City.ninhBinh;
      case r'haiPhong':
        return City.haiPhong;
      case r'canTho':
        return City.canTho;
      case r'hue':
        return City.hue;
      case r'daLat':
        return City.daLat;
      case r'bienHoa':
        return City.bienHoa;
      case r'nhaTrang':
        return City.nhaTrang;
      case r'haLong':
        return City.haLong;
      case r'quyNhon':
        return City.quyNhon;
      case r'phanThiet':
        return City.phanThiet;
      case r'vungTau':
        return City.vungTau;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(City self) {
    switch (self) {
      case City.hanoi:
        return r'hanoi';
      case City.hoChiMinh:
        return r'hoChiMinh';
      case City.daNang:
        return r'daNang';
      case City.ninhBinh:
        return r'ninhBinh';
      case City.haiPhong:
        return r'haiPhong';
      case City.canTho:
        return r'canTho';
      case City.hue:
        return r'hue';
      case City.daLat:
        return r'daLat';
      case City.bienHoa:
        return r'bienHoa';
      case City.nhaTrang:
        return r'nhaTrang';
      case City.haLong:
        return r'haLong';
      case City.quyNhon:
        return r'quyNhon';
      case City.phanThiet:
        return r'phanThiet';
      case City.vungTau:
        return r'vungTau';
    }
  }
}

extension CityMapperExtension on City {
  String toValue() {
    CityMapper.ensureInitialized();
    return MapperContainer.globals.toValue<City>(this) as String;
  }
}

class ProjectRoleMapper extends EnumMapper<ProjectRole> {
  ProjectRoleMapper._();

  static ProjectRoleMapper? _instance;
  static ProjectRoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProjectRoleMapper._());
    }
    return _instance!;
  }

  static ProjectRole fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ProjectRole decode(dynamic value) {
    switch (value) {
      case r'design':
        return ProjectRole.design;
      case r'construction':
        return ProjectRole.construction;
      case r'supervision':
        return ProjectRole.supervision;
      case r'supply':
        return ProjectRole.supply;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ProjectRole self) {
    switch (self) {
      case ProjectRole.design:
        return r'design';
      case ProjectRole.construction:
        return r'construction';
      case ProjectRole.supervision:
        return r'supervision';
      case ProjectRole.supply:
        return r'supply';
    }
  }
}

extension ProjectRoleMapperExtension on ProjectRole {
  String toValue() {
    ProjectRoleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ProjectRole>(this) as String;
  }
}

class ProjectStatusMapper extends EnumMapper<ProjectStatus> {
  ProjectStatusMapper._();

  static ProjectStatusMapper? _instance;
  static ProjectStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProjectStatusMapper._());
    }
    return _instance!;
  }

  static ProjectStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ProjectStatus decode(dynamic value) {
    switch (value) {
      case r'ongoing':
        return ProjectStatus.ongoing;
      case r'completed':
        return ProjectStatus.completed;
      case r'cancelled':
        return ProjectStatus.cancelled;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ProjectStatus self) {
    switch (self) {
      case ProjectStatus.ongoing:
        return r'ongoing';
      case ProjectStatus.completed:
        return r'completed';
      case ProjectStatus.cancelled:
        return r'cancelled';
    }
  }
}

extension ProjectStatusMapperExtension on ProjectStatus {
  String toValue() {
    ProjectStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ProjectStatus>(this) as String;
  }
}

class AvailabilityStatusMapper extends EnumMapper<AvailabilityStatus> {
  AvailabilityStatusMapper._();

  static AvailabilityStatusMapper? _instance;
  static AvailabilityStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AvailabilityStatusMapper._());
    }
    return _instance!;
  }

  static AvailabilityStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AvailabilityStatus decode(dynamic value) {
    switch (value) {
      case r'available':
        return AvailabilityStatus.available;
      case r'unavailable':
        return AvailabilityStatus.unavailable;
      case r'busy':
        return AvailabilityStatus.busy;
      case r'onLeave':
        return AvailabilityStatus.onLeave;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AvailabilityStatus self) {
    switch (self) {
      case AvailabilityStatus.available:
        return r'available';
      case AvailabilityStatus.unavailable:
        return r'unavailable';
      case AvailabilityStatus.busy:
        return r'busy';
      case AvailabilityStatus.onLeave:
        return r'onLeave';
    }
  }
}

extension AvailabilityStatusMapperExtension on AvailabilityStatus {
  String toValue() {
    AvailabilityStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AvailabilityStatus>(this) as String;
  }
}

class ArchitectRoleMapper extends EnumMapper<ArchitectRole> {
  ArchitectRoleMapper._();

  static ArchitectRoleMapper? _instance;
  static ArchitectRoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArchitectRoleMapper._());
    }
    return _instance!;
  }

  static ArchitectRole fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ArchitectRole decode(dynamic value) {
    switch (value) {
      case r'seniorArchitect':
        return ArchitectRole.seniorArchitect;
      case r'designConsultant':
        return ArchitectRole.designConsultant;
      case r'interiorArchitect':
        return ArchitectRole.interiorArchitect;
      case r'projectArchitect':
        return ArchitectRole.projectArchitect;
      case r'landscapeArchitect':
        return ArchitectRole.landscapeArchitect;
      case r'urbanPlanner':
        return ArchitectRole.urbanPlanner;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ArchitectRole self) {
    switch (self) {
      case ArchitectRole.seniorArchitect:
        return r'seniorArchitect';
      case ArchitectRole.designConsultant:
        return r'designConsultant';
      case ArchitectRole.interiorArchitect:
        return r'interiorArchitect';
      case ArchitectRole.projectArchitect:
        return r'projectArchitect';
      case ArchitectRole.landscapeArchitect:
        return r'landscapeArchitect';
      case ArchitectRole.urbanPlanner:
        return r'urbanPlanner';
    }
  }
}

extension ArchitectRoleMapperExtension on ArchitectRole {
  String toValue() {
    ArchitectRoleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ArchitectRole>(this) as String;
  }
}

class DesignStyleMapper extends EnumMapper<DesignStyle> {
  DesignStyleMapper._();

  static DesignStyleMapper? _instance;
  static DesignStyleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DesignStyleMapper._());
    }
    return _instance!;
  }

  static DesignStyle fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DesignStyle decode(dynamic value) {
    switch (value) {
      case r'minimalism':
        return DesignStyle.minimalism;
      case r'modern':
        return DesignStyle.modern;
      case r'classical':
        return DesignStyle.classical;
      case r'tropical':
        return DesignStyle.tropical;
      case r'neoclassical':
        return DesignStyle.neoclassical;
      case r'scandinavian':
        return DesignStyle.scandinavian;
      case r'traditional':
        return DesignStyle.traditional;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DesignStyle self) {
    switch (self) {
      case DesignStyle.minimalism:
        return r'minimalism';
      case DesignStyle.modern:
        return r'modern';
      case DesignStyle.classical:
        return r'classical';
      case DesignStyle.tropical:
        return r'tropical';
      case DesignStyle.neoclassical:
        return r'neoclassical';
      case DesignStyle.scandinavian:
        return r'scandinavian';
      case DesignStyle.traditional:
        return r'traditional';
    }
  }
}

extension DesignStyleMapperExtension on DesignStyle {
  String toValue() {
    DesignStyleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DesignStyle>(this) as String;
  }
}

class ServiceTypeMapper extends EnumMapper<ServiceType> {
  ServiceTypeMapper._();

  static ServiceTypeMapper? _instance;
  static ServiceTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServiceTypeMapper._());
    }
    return _instance!;
  }

  static ServiceType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ServiceType decode(dynamic value) {
    switch (value) {
      case r'fullConstruction':
        return ServiceType.fullConstruction;
      case r'interiorFitOut':
        return ServiceType.interiorFitOut;
      case r'electricalInstallation':
        return ServiceType.electricalInstallation;
      case r'plumbing':
        return ServiceType.plumbing;
      case r'finishingWorks':
        return ServiceType.finishingWorks;
      case r'roofing':
        return ServiceType.roofing;
      case r'steelStructure':
        return ServiceType.steelStructure;
      case r'bricklaying':
        return ServiceType.bricklaying;
      case r'tiling':
        return ServiceType.tiling;
      case r'painting':
        return ServiceType.painting;
      case r'scaffolding':
        return ServiceType.scaffolding;
      case r'concreteWorks':
        return ServiceType.concreteWorks;
      case r'welding':
        return ServiceType.welding;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ServiceType self) {
    switch (self) {
      case ServiceType.fullConstruction:
        return r'fullConstruction';
      case ServiceType.interiorFitOut:
        return r'interiorFitOut';
      case ServiceType.electricalInstallation:
        return r'electricalInstallation';
      case ServiceType.plumbing:
        return r'plumbing';
      case ServiceType.finishingWorks:
        return r'finishingWorks';
      case ServiceType.roofing:
        return r'roofing';
      case ServiceType.steelStructure:
        return r'steelStructure';
      case ServiceType.bricklaying:
        return r'bricklaying';
      case ServiceType.tiling:
        return r'tiling';
      case ServiceType.painting:
        return r'painting';
      case ServiceType.scaffolding:
        return r'scaffolding';
      case ServiceType.concreteWorks:
        return r'concreteWorks';
      case ServiceType.welding:
        return r'welding';
    }
  }
}

extension ServiceTypeMapperExtension on ServiceType {
  String toValue() {
    ServiceTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ServiceType>(this) as String;
  }
}

class SupplierTypeMapper extends EnumMapper<SupplierType> {
  SupplierTypeMapper._();

  static SupplierTypeMapper? _instance;
  static SupplierTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SupplierTypeMapper._());
    }
    return _instance!;
  }

  static SupplierType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SupplierType decode(dynamic value) {
    switch (value) {
      case r'enterprise':
        return SupplierType.enterprise;
      case r'distributor':
        return SupplierType.distributor;
      case r'retailStore':
        return SupplierType.retailStore;
      case r'individual':
        return SupplierType.individual;
      case r'reseller':
        return SupplierType.reseller;
      case r'manufacturer':
        return SupplierType.manufacturer;
      case r'brand':
        return SupplierType.brand;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SupplierType self) {
    switch (self) {
      case SupplierType.enterprise:
        return r'enterprise';
      case SupplierType.distributor:
        return r'distributor';
      case SupplierType.retailStore:
        return r'retailStore';
      case SupplierType.individual:
        return r'individual';
      case SupplierType.reseller:
        return r'reseller';
      case SupplierType.manufacturer:
        return r'manufacturer';
      case SupplierType.brand:
        return r'brand';
    }
  }
}

extension SupplierTypeMapperExtension on SupplierType {
  String toValue() {
    SupplierTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SupplierType>(this) as String;
  }
}

class MaterialCategoryMapper extends EnumMapper<MaterialCategory> {
  MaterialCategoryMapper._();

  static MaterialCategoryMapper? _instance;
  static MaterialCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MaterialCategoryMapper._());
    }
    return _instance!;
  }

  static MaterialCategory fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MaterialCategory decode(dynamic value) {
    switch (value) {
      case r'cement':
        return MaterialCategory.cement;
      case r'bricks':
        return MaterialCategory.bricks;
      case r'sandAndGravel':
        return MaterialCategory.sandAndGravel;
      case r'steel':
        return MaterialCategory.steel;
      case r'electricalEquipment':
        return MaterialCategory.electricalEquipment;
      case r'lighting':
        return MaterialCategory.lighting;
      case r'plumbingEquipment':
        return MaterialCategory.plumbingEquipment;
      case r'tiles':
        return MaterialCategory.tiles;
      case r'paint':
        return MaterialCategory.paint;
      case r'doorsAndWindows':
        return MaterialCategory.doorsAndWindows;
      case r'waterproofing':
        return MaterialCategory.waterproofing;
      case r'wood':
        return MaterialCategory.wood;
      case r'interiorFurniture':
        return MaterialCategory.interiorFurniture;
      case r'safetyEquipment':
        return MaterialCategory.safetyEquipment;
      case r'toolsAndHardware':
        return MaterialCategory.toolsAndHardware;
      case r'roofing':
        return MaterialCategory.roofing;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MaterialCategory self) {
    switch (self) {
      case MaterialCategory.cement:
        return r'cement';
      case MaterialCategory.bricks:
        return r'bricks';
      case MaterialCategory.sandAndGravel:
        return r'sandAndGravel';
      case MaterialCategory.steel:
        return r'steel';
      case MaterialCategory.electricalEquipment:
        return r'electricalEquipment';
      case MaterialCategory.lighting:
        return r'lighting';
      case MaterialCategory.plumbingEquipment:
        return r'plumbingEquipment';
      case MaterialCategory.tiles:
        return r'tiles';
      case MaterialCategory.paint:
        return r'paint';
      case MaterialCategory.doorsAndWindows:
        return r'doorsAndWindows';
      case MaterialCategory.waterproofing:
        return r'waterproofing';
      case MaterialCategory.wood:
        return r'wood';
      case MaterialCategory.interiorFurniture:
        return r'interiorFurniture';
      case MaterialCategory.safetyEquipment:
        return r'safetyEquipment';
      case MaterialCategory.toolsAndHardware:
        return r'toolsAndHardware';
      case MaterialCategory.roofing:
        return r'roofing';
    }
  }
}

extension MaterialCategoryMapperExtension on MaterialCategory {
  String toValue() {
    MaterialCategoryMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MaterialCategory>(this) as String;
  }
}

class BusinessEntityTypeMapper extends EnumMapper<BusinessEntityType> {
  BusinessEntityTypeMapper._();

  static BusinessEntityTypeMapper? _instance;
  static BusinessEntityTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BusinessEntityTypeMapper._());
    }
    return _instance!;
  }

  static BusinessEntityType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BusinessEntityType decode(dynamic value) {
    switch (value) {
      case r'individual':
        return BusinessEntityType.individual;
      case r'partnership':
        return BusinessEntityType.partnership;
      case r'limitedCompany':
        return BusinessEntityType.limitedCompany;
      case r'corporation':
        return BusinessEntityType.corporation;
      case r'cooperative':
        return BusinessEntityType.cooperative;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BusinessEntityType self) {
    switch (self) {
      case BusinessEntityType.individual:
        return r'individual';
      case BusinessEntityType.partnership:
        return r'partnership';
      case BusinessEntityType.limitedCompany:
        return r'limitedCompany';
      case BusinessEntityType.corporation:
        return r'corporation';
      case BusinessEntityType.cooperative:
        return r'cooperative';
    }
  }
}

extension BusinessEntityTypeMapperExtension on BusinessEntityType {
  String toValue() {
    BusinessEntityTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BusinessEntityType>(this) as String;
  }
}

class PaymentMethodMapper extends EnumMapper<PaymentMethod> {
  PaymentMethodMapper._();

  static PaymentMethodMapper? _instance;
  static PaymentMethodMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaymentMethodMapper._());
    }
    return _instance!;
  }

  static PaymentMethod fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PaymentMethod decode(dynamic value) {
    switch (value) {
      case r'cash':
        return PaymentMethod.cash;
      case r'bankTransfer':
        return PaymentMethod.bankTransfer;
      case r'creditCard':
        return PaymentMethod.creditCard;
      case r'mobileBanking':
        return PaymentMethod.mobileBanking;
      case r'eWallet':
        return PaymentMethod.eWallet;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PaymentMethod self) {
    switch (self) {
      case PaymentMethod.cash:
        return r'cash';
      case PaymentMethod.bankTransfer:
        return r'bankTransfer';
      case PaymentMethod.creditCard:
        return r'creditCard';
      case PaymentMethod.mobileBanking:
        return r'mobileBanking';
      case PaymentMethod.eWallet:
        return r'eWallet';
    }
  }
}

extension PaymentMethodMapperExtension on PaymentMethod {
  String toValue() {
    PaymentMethodMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PaymentMethod>(this) as String;
  }
}

class MediaTypeMapper extends EnumMapper<MediaType> {
  MediaTypeMapper._();

  static MediaTypeMapper? _instance;
  static MediaTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MediaTypeMapper._());
    }
    return _instance!;
  }

  static MediaType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MediaType decode(dynamic value) {
    switch (value) {
      case r'image':
        return MediaType.image;
      case r'video':
        return MediaType.video;
      case r'document':
        return MediaType.document;
      case r'model3D':
        return MediaType.model3D;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MediaType self) {
    switch (self) {
      case MediaType.image:
        return r'image';
      case MediaType.video:
        return r'video';
      case MediaType.document:
        return r'document';
      case MediaType.model3D:
        return r'model3D';
    }
  }
}

extension MediaTypeMapperExtension on MediaType {
  String toValue() {
    MediaTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MediaType>(this) as String;
  }
}

class JobStatusMapper extends EnumMapper<JobStatus> {
  JobStatusMapper._();

  static JobStatusMapper? _instance;
  static JobStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JobStatusMapper._());
    }
    return _instance!;
  }

  static JobStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  JobStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return JobStatus.pending;
      case r'active':
        return JobStatus.active;
      case r'closed':
        return JobStatus.closed;
      case r'cancelled':
        return JobStatus.cancelled;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(JobStatus self) {
    switch (self) {
      case JobStatus.pending:
        return r'pending';
      case JobStatus.active:
        return r'active';
      case JobStatus.closed:
        return r'closed';
      case JobStatus.cancelled:
        return r'cancelled';
    }
  }
}

extension JobStatusMapperExtension on JobStatus {
  String toValue() {
    JobStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<JobStatus>(this) as String;
  }
}

class ApplicationStatusMapper extends EnumMapper<ApplicationStatus> {
  ApplicationStatusMapper._();

  static ApplicationStatusMapper? _instance;
  static ApplicationStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ApplicationStatusMapper._());
    }
    return _instance!;
  }

  static ApplicationStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ApplicationStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return ApplicationStatus.pending;
      case r'accepted':
        return ApplicationStatus.accepted;
      case r'rejected':
        return ApplicationStatus.rejected;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ApplicationStatus self) {
    switch (self) {
      case ApplicationStatus.pending:
        return r'pending';
      case ApplicationStatus.accepted:
        return r'accepted';
      case ApplicationStatus.rejected:
        return r'rejected';
    }
  }
}

extension ApplicationStatusMapperExtension on ApplicationStatus {
  String toValue() {
    ApplicationStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ApplicationStatus>(this) as String;
  }
}

class JobPostingTypeMapper extends EnumMapper<JobPostingType> {
  JobPostingTypeMapper._();

  static JobPostingTypeMapper? _instance;
  static JobPostingTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = JobPostingTypeMapper._());
    }
    return _instance!;
  }

  static JobPostingType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  JobPostingType decode(dynamic value) {
    switch (value) {
      case r'hiring':
        return JobPostingType.hiring;
      case r'partnership':
        return JobPostingType.partnership;
      case r'materials':
        return JobPostingType.materials;
      case r'other':
        return JobPostingType.other;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(JobPostingType self) {
    switch (self) {
      case JobPostingType.hiring:
        return r'hiring';
      case JobPostingType.partnership:
        return r'partnership';
      case JobPostingType.materials:
        return r'materials';
      case JobPostingType.other:
        return r'other';
    }
  }
}

extension JobPostingTypeMapperExtension on JobPostingType {
  String toValue() {
    JobPostingTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<JobPostingType>(this) as String;
  }
}

class ContactTypeMapper extends EnumMapper<ContactType> {
  ContactTypeMapper._();

  static ContactTypeMapper? _instance;
  static ContactTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactTypeMapper._());
    }
    return _instance!;
  }

  static ContactType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ContactType decode(dynamic value) {
    switch (value) {
      case r'email':
        return ContactType.email;
      case r'phone':
        return ContactType.phone;
      case r'website':
        return ContactType.website;
      case r'github':
        return ContactType.github;
      case r'linkedin':
        return ContactType.linkedin;
      case r'twitter':
        return ContactType.twitter;
      case r'facebook':
        return ContactType.facebook;
      case r'instagram':
        return ContactType.instagram;
      case r'youtube':
        return ContactType.youtube;
      case r'tiktok':
        return ContactType.tiktok;
      case r'other':
        return ContactType.other;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ContactType self) {
    switch (self) {
      case ContactType.email:
        return r'email';
      case ContactType.phone:
        return r'phone';
      case ContactType.website:
        return r'website';
      case ContactType.github:
        return r'github';
      case ContactType.linkedin:
        return r'linkedin';
      case ContactType.twitter:
        return r'twitter';
      case ContactType.facebook:
        return r'facebook';
      case ContactType.instagram:
        return r'instagram';
      case ContactType.youtube:
        return r'youtube';
      case ContactType.tiktok:
        return r'tiktok';
      case ContactType.other:
        return r'other';
    }
  }
}

extension ContactTypeMapperExtension on ContactType {
  String toValue() {
    ContactTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ContactType>(this) as String;
  }
}

class NotificationTypeMapper extends EnumMapper<NotificationType> {
  NotificationTypeMapper._();

  static NotificationTypeMapper? _instance;
  static NotificationTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NotificationTypeMapper._());
    }
    return _instance!;
  }

  static NotificationType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  NotificationType decode(dynamic value) {
    switch (value) {
      case r'unknown':
        return NotificationType.unknown;
      case r'newPostMatch':
        return NotificationType.newPostMatch;
      case r'newMessage':
        return NotificationType.newMessage;
      case r'applicationUpdate':
        return NotificationType.applicationUpdate;
      case r'profileUpdate':
        return NotificationType.profileUpdate;
      case r'newComment':
        return NotificationType.newComment;
      case r'system':
        return NotificationType.system;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(NotificationType self) {
    switch (self) {
      case NotificationType.unknown:
        return r'unknown';
      case NotificationType.newPostMatch:
        return r'newPostMatch';
      case NotificationType.newMessage:
        return r'newMessage';
      case NotificationType.applicationUpdate:
        return r'applicationUpdate';
      case NotificationType.profileUpdate:
        return r'profileUpdate';
      case NotificationType.newComment:
        return r'newComment';
      case NotificationType.system:
        return r'system';
    }
  }
}

extension NotificationTypeMapperExtension on NotificationType {
  String toValue() {
    NotificationTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<NotificationType>(this) as String;
  }
}

class RelatedEntityTypeMapper extends EnumMapper<RelatedEntityType> {
  RelatedEntityTypeMapper._();

  static RelatedEntityTypeMapper? _instance;
  static RelatedEntityTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RelatedEntityTypeMapper._());
    }
    return _instance!;
  }

  static RelatedEntityType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  RelatedEntityType decode(dynamic value) {
    switch (value) {
      case r'unknown':
        return RelatedEntityType.unknown;
      case r'post':
        return RelatedEntityType.post;
      case r'profile':
        return RelatedEntityType.profile;
      case r'messageThread':
        return RelatedEntityType.messageThread;
      case r'application':
        return RelatedEntityType.application;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(RelatedEntityType self) {
    switch (self) {
      case RelatedEntityType.unknown:
        return r'unknown';
      case RelatedEntityType.post:
        return r'post';
      case RelatedEntityType.profile:
        return r'profile';
      case RelatedEntityType.messageThread:
        return r'messageThread';
      case RelatedEntityType.application:
        return r'application';
    }
  }
}

extension RelatedEntityTypeMapperExtension on RelatedEntityType {
  String toValue() {
    RelatedEntityTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<RelatedEntityType>(this) as String;
  }
}

class AttachmentTypeMapper extends EnumMapper<AttachmentType> {
  AttachmentTypeMapper._();

  static AttachmentTypeMapper? _instance;
  static AttachmentTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AttachmentTypeMapper._());
    }
    return _instance!;
  }

  static AttachmentType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AttachmentType decode(dynamic value) {
    switch (value) {
      case r'none':
        return AttachmentType.none;
      case r'image':
        return AttachmentType.image;
      case r'video':
        return AttachmentType.video;
      case r'file':
        return AttachmentType.file;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AttachmentType self) {
    switch (self) {
      case AttachmentType.none:
        return r'none';
      case AttachmentType.image:
        return r'image';
      case AttachmentType.video:
        return r'video';
      case AttachmentType.file:
        return r'file';
    }
  }
}

extension AttachmentTypeMapperExtension on AttachmentType {
  String toValue() {
    AttachmentTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AttachmentType>(this) as String;
  }
}
