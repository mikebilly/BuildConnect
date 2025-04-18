import 'package:dart_mappable/dart_mappable.dart';

part 'enum.mapper.dart';

@MappableEnum()
enum ProfileType {
  architect,
  contractor,
  constructionTeam,
  supplier
}

@MappableEnum()
enum WorkingMode {
  onsite,
  remote,
  hybrid
}

@MappableEnum()
enum Domain {
  residential,
  commercial,
  industrial,
  hospitality,
  urbanPlanning,
  education,
  healthcare,
  cultural,
  infrastructure,
  renovation
}

@MappableEnum()
enum ProjectRole {
  design,
  construction,
  supervision,
  supply
}

@MappableEnum()
enum ProjectStatus {
  ongoing,
  completed,
  cancelled
}

@MappableEnum()
enum ArchitectRole {
  seniorArchitect,
  designConsultant,
  interiorArchitect,
  projectArchitect,
  landscapeArchitect,
  urbanPlanner
}

@MappableEnum()
enum DesignStyle {
  minimalism,
  modern,
  classical,
  tropical,
  neoclassical,
  scandinavian,
  traditional
}

@MappableEnum()
enum ServiceType {
  fullConstruction,
  interiorFitOut,
  electricalInstallation,
  plumbing,
  finishingWorks,
  roofing,
  steelStructure,
  bricklaying,
  tiling,
  painting,
  scaffolding,
  concreteWorks,
  welding
}

@MappableEnum()
enum SupplierType {
  enterprise,
  distributor,
  retailStore,
  individual,
  reseller,
  manufacturer,
  brand
}

@MappableEnum()
enum MaterialCategory {
  cement,
  bricks,
  sandAndGravel,
  steel,
  electricalEquipment,
  lighting,
  plumbingEquipment,
  tiles,
  paint,
  doorsAndWindows,
  waterproofing,
  wood,
  interiorFurniture,
  safetyEquipment,
  toolsAndHardware,
  roofing
}

@MappableEnum()
enum BusinessEntityType {
  individual,
  partnership,
  limitedCompany,
  corporation,
  cooperative
}

@MappableEnum()
enum PaymentMethod {
  cash,
  bankTransfer,
  creditCard,
  mobileBanking,
  eWallet
}

@MappableEnum()
enum MediaType {
  image,
  video,
  document,
  model3D
}

@MappableEnum()
enum JobStatus {
  pending,
  active,
  closed,
  cancelled
}

@MappableEnum()
enum ApplicationStatus {
  pending,
  accepted,
  rejected
}
