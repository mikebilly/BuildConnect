import 'package:dart_mappable/dart_mappable.dart';

part 'enums.mapper.dart';

@MappableEnum()
enum ProfileType {
  architect,
  contractor,
  constructionTeam,
  supplier;

  String get label {
    switch (this) {
      case ProfileType.architect:
        return 'Architect';
      case ProfileType.contractor:
        return 'Contractor';
      case ProfileType.constructionTeam:
        return 'Construction Team';
      case ProfileType.supplier:
        return 'Supplier';
    }
  }
}

@MappableEnum()
enum WorkingMode {
  onsite,
  remote,
  hybrid;

  String get label {
    switch (this) {
      case WorkingMode.onsite:
        return 'Onsite';
      case WorkingMode.remote:
        return 'Remote';
      case WorkingMode.hybrid:
        return 'Hybrid';
    }
  }
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
  renovation;

  String get label {
    switch (this) {
      case Domain.residential:
        return 'Residential';
      case Domain.commercial:
        return 'Commercial';
      case Domain.industrial:
        return 'Industrial';
      case Domain.hospitality:
        return 'Hospitality';
      case Domain.urbanPlanning:
        return 'Urban Planning';
      case Domain.education:
        return 'Education';
      case Domain.healthcare:
        return 'Healthcare';
      case Domain.cultural:
        return 'Cultural';
      case Domain.infrastructure:
        return 'Infrastructure';
      case Domain.renovation:
        return 'Renovation';
    }
  }
}

@MappableEnum()
enum ProjectRole {
  design,
  construction,
  supervision,
  supply;

  String get label {
    switch (this) {
      case ProjectRole.design:
        return 'Design';
      case ProjectRole.construction:
        return 'Construction';
      case ProjectRole.supervision:
        return 'Supervision';
      case ProjectRole.supply:
        return 'Supply';
    }
  }
}

@MappableEnum()
enum ProjectStatus {
  ongoing,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case ProjectStatus.ongoing:
        return 'Ongoing';
      case ProjectStatus.completed:
        return 'Completed';
      case ProjectStatus.cancelled:
        return 'Cancelled';
    }
  }
}

@MappableEnum()
enum ArchitectRole {
  seniorArchitect,
  designConsultant,
  interiorArchitect,
  projectArchitect,
  landscapeArchitect,
  urbanPlanner;

  String get label {
    switch (this) {
      case ArchitectRole.seniorArchitect:
        return 'Senior Architect';
      case ArchitectRole.designConsultant:
        return 'Design Consultant';
      case ArchitectRole.interiorArchitect:
        return 'Interior Architect';
      case ArchitectRole.projectArchitect:
        return 'Project Architect';
      case ArchitectRole.landscapeArchitect:
        return 'Landscape Architect';
      case ArchitectRole.urbanPlanner:
        return 'Urban Planner';
    }
  }
}

@MappableEnum()
enum DesignStyle {
  minimalism,
  modern,
  classical,
  tropical,
  neoclassical,
  scandinavian,
  traditional;

  String get label {
    switch (this) {
      case DesignStyle.minimalism:
        return 'Minimalism';
      case DesignStyle.modern:
        return 'Modern';
      case DesignStyle.classical:
        return 'Classical';
      case DesignStyle.tropical:
        return 'Tropical';
      case DesignStyle.neoclassical:
        return 'Neoclassical';
      case DesignStyle.scandinavian:
        return 'Scandinavian';
      case DesignStyle.traditional:
        return 'Traditional';
    }
  }
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
  welding;

  String get label {
    switch (this) {
      case ServiceType.fullConstruction:
        return 'Full Construction';
      case ServiceType.interiorFitOut:
        return 'Interior Fit-Out';
      case ServiceType.electricalInstallation:
        return 'Electrical Installation';
      case ServiceType.plumbing:
        return 'Plumbing';
      case ServiceType.finishingWorks:
        return 'Finishing Works';
      case ServiceType.roofing:
        return 'Roofing';
      case ServiceType.steelStructure:
        return 'Steel Structure';
      case ServiceType.bricklaying:
        return 'Bricklaying';
      case ServiceType.tiling:
        return 'Tiling';
      case ServiceType.painting:
        return 'Painting';
      case ServiceType.scaffolding:
        return 'Scaffolding';
      case ServiceType.concreteWorks:
        return 'Concrete Works';
      case ServiceType.welding:
        return 'Welding';
    }
  }
}

@MappableEnum()
enum SupplierType {
  enterprise,
  distributor,
  retailStore,
  individual,
  reseller,
  manufacturer,
  brand;

  String get label {
    switch (this) {
      case SupplierType.enterprise:
        return 'Enterprise';
      case SupplierType.distributor:
        return 'Distributor';
      case SupplierType.retailStore:
        return 'Retail Store';
      case SupplierType.individual:
        return 'Individual';
      case SupplierType.reseller:
        return 'Reseller';
      case SupplierType.manufacturer:
        return 'Manufacturer';
      case SupplierType.brand:
        return 'Brand';
    }
  }
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
  roofing;

  String get label {
    switch (this) {
      case MaterialCategory.cement:
        return 'Cement';
      case MaterialCategory.bricks:
        return 'Bricks';
      case MaterialCategory.sandAndGravel:
        return 'Sand and Gravel';
      case MaterialCategory.steel:
        return 'Steel';
      case MaterialCategory.electricalEquipment:
        return 'Electrical Equipment';
      case MaterialCategory.lighting:
        return 'Lighting';
      case MaterialCategory.plumbingEquipment:
        return 'Plumbing Equipment';
      case MaterialCategory.tiles:
        return 'Tiles';
      case MaterialCategory.paint:
        return 'Paint';
      case MaterialCategory.doorsAndWindows:
        return 'Doors and Windows';
      case MaterialCategory.waterproofing:
        return 'Waterproofing';
      case MaterialCategory.wood:
        return 'Wood';
      case MaterialCategory.interiorFurniture:
        return 'Interior Furniture';
      case MaterialCategory.safetyEquipment:
        return 'Safety Equipment';
      case MaterialCategory.toolsAndHardware:
        return 'Tools and Hardware';
      case MaterialCategory.roofing:
        return 'Roofing';
    }
  }
}

@MappableEnum()
enum BusinessEntityType {
  individual,
  partnership,
  limitedCompany,
  corporation,
  cooperative;

  String get label {
    switch (this) {
      case BusinessEntityType.individual:
        return 'Individual';
      case BusinessEntityType.partnership:
        return 'Partnership';
      case BusinessEntityType.limitedCompany:
        return 'Limited Company';
      case BusinessEntityType.corporation:
        return 'Corporation';
      case BusinessEntityType.cooperative:
        return 'Cooperative';
    }
  }
}

@MappableEnum()
enum PaymentMethod {
  cash,
  bankTransfer,
  creditCard,
  mobileBanking,
  eWallet;

  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.mobileBanking:
        return 'Mobile Banking';
      case PaymentMethod.eWallet:
        return 'E-Wallet';
    }
  }
}

@MappableEnum()
enum MediaType {
  image,
  video,
  document,
  model3D;

  String get label {
    switch (this) {
      case MediaType.image:
        return 'Image';
      case MediaType.video:
        return 'Video';
      case MediaType.document:
        return 'Document';
      case MediaType.model3D:
        return '3D Model';
    }
  }
}

@MappableEnum()
enum JobStatus {
  pending,
  active,
  closed,
  cancelled;

  String get label {
    switch (this) {
      case JobStatus.pending:
        return 'Pending';
      case JobStatus.active:
        return 'Active';
      case JobStatus.closed:
        return 'Closed';
      case JobStatus.cancelled:
        return 'Cancelled';
    }
  }
}

@MappableEnum()
enum ApplicationStatus {
  pending,
  accepted,
  rejected;

  String get label {
    switch (this) {
      case ApplicationStatus.pending:
        return 'Pending';
      case ApplicationStatus.accepted:
        return 'Accepted';
      case ApplicationStatus.rejected:
        return 'Rejected';
    }
  }
}

@MappableEnum()
enum JobPostingType {
  hiring,
  partnership,
  materials,
  other;

  String get label {
    switch (this) {
      case JobPostingType.hiring:
        return 'Hiring';
      case JobPostingType.partnership:
        return 'Partnership';
      case JobPostingType.materials:
        return 'Materials';
      case JobPostingType.other:
        return 'Other';
    }
  }
}
