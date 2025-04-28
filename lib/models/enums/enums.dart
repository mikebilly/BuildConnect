import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:buildconnect/core/constants/supabase_constants.dart';

part 'enums.mapper.dart';

@MappableEnum()
enum ProfileType {
  architect,
  contractor,
  constructionTeam,
  supplier;

  String get title => 'Profile Type';

  String get label => switch (this) {
    ProfileType.architect => 'Architect',
    ProfileType.contractor => 'Contractor',
    ProfileType.constructionTeam => 'Construction Team',
    ProfileType.supplier => 'Supplier',
  };

  String get table => switch (this) {
    ProfileType.architect => SupabaseConstants.architectProfilesTable,
    ProfileType.contractor => SupabaseConstants.contractorProfilesTable,
    ProfileType.constructionTeam => SupabaseConstants.constructionTeamProfilesTable,
    ProfileType.supplier => SupabaseConstants.supplierProfilesTable,
  };
}

@MappableEnum()
enum WorkingMode {
  onsite,
  remote,
  hybrid;

  String get title => 'Working Mode';

  String get label => switch (this) {
    WorkingMode.onsite => 'Onsite',
    WorkingMode.remote => 'Remote',
    WorkingMode.hybrid => 'Hybrid',
  };
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

  String get title => 'Domain';

  String get label => switch (this) {
    Domain.residential => 'Residential',
    Domain.commercial => 'Commercial',
    Domain.industrial => 'Industrial',
    Domain.hospitality => 'Hospitality',
    Domain.urbanPlanning => 'Urban Planning',
    Domain.education => 'Education',
    Domain.healthcare => 'Healthcare',
    Domain.cultural => 'Cultural',
    Domain.infrastructure => 'Infrastructure',
    Domain.renovation => 'Renovation',
  };
}

@MappableEnum()
enum ProjectRole {
  design,
  construction,
  supervision,
  supply;

  String get title => 'Project Role';

  String get label => switch (this) {
    ProjectRole.design => 'Design',
    ProjectRole.construction => 'Construction',
    ProjectRole.supervision => 'Supervision',
    ProjectRole.supply => 'Supply',
  };
}

@MappableEnum()
enum ProjectStatus {
  ongoing,
  completed,
  cancelled;

  String get title => 'Project Status';

  String get label => switch (this) {
    ProjectStatus.ongoing => 'Ongoing',
    ProjectStatus.completed => 'Completed',
    ProjectStatus.cancelled => 'Cancelled',
  };
}

@MappableEnum()
enum AvailabilityStatus {
  available,
  unavailable,
  busy,
  onLeave;

  String get title => 'Availability Status';

  String get label => switch (this) {
    AvailabilityStatus.available => 'Available',
    AvailabilityStatus.unavailable => 'Unavailable',
    AvailabilityStatus.busy => 'Busy',
    AvailabilityStatus.onLeave => 'On Leave',
  };
}

@MappableEnum()
enum ArchitectRole {
  seniorArchitect,
  designConsultant,
  interiorArchitect,
  projectArchitect,
  landscapeArchitect,
  urbanPlanner;

  String get title => 'Architect Role';

  String get label => switch (this) {
    ArchitectRole.seniorArchitect => 'Senior Architect',
    ArchitectRole.designConsultant => 'Design Consultant',
    ArchitectRole.interiorArchitect => 'Interior Architect',
    ArchitectRole.projectArchitect => 'Project Architect',
    ArchitectRole.landscapeArchitect => 'Landscape Architect',
    ArchitectRole.urbanPlanner => 'Urban Planner',
  };
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

  String get title => 'Design Style';

  String get label => switch (this) {
    DesignStyle.minimalism => 'Minimalism',
    DesignStyle.modern => 'Modern',
    DesignStyle.classical => 'Classical',
    DesignStyle.tropical => 'Tropical',
    DesignStyle.neoclassical => 'Neoclassical',
    DesignStyle.scandinavian => 'Scandinavian',
    DesignStyle.traditional => 'Traditional',
  };
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

  String get title => 'Service Type';

  String get label => switch (this) {
    ServiceType.fullConstruction => 'Full Construction',
    ServiceType.interiorFitOut => 'Interior Fit-Out',
    ServiceType.electricalInstallation => 'Electrical Installation',
    ServiceType.plumbing => 'Plumbing',
    ServiceType.finishingWorks => 'Finishing Works',
    ServiceType.roofing => 'Roofing',
    ServiceType.steelStructure => 'Steel Structure',
    ServiceType.bricklaying => 'Bricklaying',
    ServiceType.tiling => 'Tiling',
    ServiceType.painting => 'Painting',
    ServiceType.scaffolding => 'Scaffolding',
    ServiceType.concreteWorks => 'Concrete Works',
    ServiceType.welding => 'Welding',
  };
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

  String get title => 'Supplier Type';

  String get label => switch (this) {
    SupplierType.enterprise => 'Enterprise',
    SupplierType.distributor => 'Distributor',
    SupplierType.retailStore => 'Retail Store',
    SupplierType.individual => 'Individual',
    SupplierType.reseller => 'Reseller',
    SupplierType.manufacturer => 'Manufacturer',
    SupplierType.brand => 'Brand',
  };
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

  String get title => 'Material Category';

  String get label => switch (this) {
    MaterialCategory.cement => 'Cement',
    MaterialCategory.bricks => 'Bricks',
    MaterialCategory.sandAndGravel => 'Sand and Gravel',
    MaterialCategory.steel => 'Steel',
    MaterialCategory.electricalEquipment => 'Electrical Equipment',
    MaterialCategory.lighting => 'Lighting',
    MaterialCategory.plumbingEquipment => 'Plumbing Equipment',
    MaterialCategory.tiles => 'Tiles',
    MaterialCategory.paint => 'Paint',
    MaterialCategory.doorsAndWindows => 'Doors and Windows',
    MaterialCategory.waterproofing => 'Waterproofing',
    MaterialCategory.wood => 'Wood',
    MaterialCategory.interiorFurniture => 'Interior Furniture',
    MaterialCategory.safetyEquipment => 'Safety Equipment',
    MaterialCategory.toolsAndHardware => 'Tools and Hardware',
    MaterialCategory.roofing => 'Roofing',
  };
}

@MappableEnum()
enum BusinessEntityType {
  individual,
  partnership,
  limitedCompany,
  corporation,
  cooperative;

  String get title => 'Business Entity Type';

  String get label => switch (this) {
    BusinessEntityType.individual => 'Individual',
    BusinessEntityType.partnership => 'Partnership',
    BusinessEntityType.limitedCompany => 'Limited Company',
    BusinessEntityType.corporation => 'Corporation',
    BusinessEntityType.cooperative => 'Cooperative',
  };
}

@MappableEnum()
enum PaymentMethod {
  cash,
  bankTransfer,
  creditCard,
  mobileBanking,
  eWallet;

  String get title => 'Payment Method';

  String get label => switch (this) {
    PaymentMethod.cash => 'Cash',
    PaymentMethod.bankTransfer => 'Bank Transfer',
    PaymentMethod.creditCard => 'Credit Card',
    PaymentMethod.mobileBanking => 'Mobile Banking',
    PaymentMethod.eWallet => 'E-Wallet',
  };
}

@MappableEnum()
enum MediaType {
  image,
  video,
  document,
  model3D;

  String get title => 'Media Type';

  String get label => switch (this) {
    MediaType.image => 'Image',
    MediaType.video => 'Video',
    MediaType.document => 'Document',
    MediaType.model3D => '3D Model',
  };
}

@MappableEnum()
enum JobStatus {
  pending,
  active,
  closed,
  cancelled;

  String get title => 'Job Status';

  String get label => switch (this) {
    JobStatus.pending => 'Pending',
    JobStatus.active => 'Active',
    JobStatus.closed => 'Closed',
    JobStatus.cancelled => 'Cancelled',
  };
}

@MappableEnum()
enum ApplicationStatus {
  pending,
  accepted,
  rejected;

  String get title => 'Application Status';

  String get label => switch (this) {
    ApplicationStatus.pending => 'Pending',
    ApplicationStatus.accepted => 'Accepted',
    ApplicationStatus.rejected => 'Rejected',
  };
}

@MappableEnum()
enum JobPostingType {
  hiring,
  partnership,
  materials,
  other;

  String get title => 'Job Posting Type';

  String get label => switch (this) {
    JobPostingType.hiring => 'Hiring',
    JobPostingType.partnership => 'Partnership',
    JobPostingType.materials => 'Materials',
    JobPostingType.other => 'Other',
  };
}

@MappableEnum()
enum ContactType {
  email,
  phone,
  website,
  github,
  linkedin,
  twitter,
  facebook,
  instagram,
  youtube,
  tiktok,
  other;

  String get title => 'Contact Type';

  String get label => switch (this) {
    ContactType.email => 'Email',
    ContactType.phone => 'Phone',
    ContactType.website => 'Website',
    ContactType.github => 'GitHub',
    ContactType.linkedin => 'LinkedIn',
    ContactType.twitter => 'Twitter',
    ContactType.facebook => 'Facebook',
    ContactType.instagram => 'Instagram',
    ContactType.youtube => 'YouTube',
    ContactType.tiktok => 'TikTok',
    ContactType.other => 'Other',
  };

  String get hintText => switch (this) {
    ContactType.email => 'example@email.com',
    ContactType.phone => '0123456789',
    ContactType.website => 'https://example.com',
    ContactType.github => 'https://github.com/username',
    ContactType.linkedin => 'https://linkedin.com/in/username',
    ContactType.twitter => 'https://twitter.com/username',
    ContactType.facebook => 'https://facebook.com/username',
    ContactType.instagram => 'https://instagram.com/username',
    ContactType.youtube => 'https://youtube.com/@channel',
    ContactType.tiktok => 'https://tiktok.com/@username',
    ContactType.other => 'Enter contact link or text',
  };

  Widget icon(BuildContext context) => switch (this) {
    ContactType.email => Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
    ContactType.phone => Icon(Icons.phone, color: Theme.of(context).colorScheme.primary),
    ContactType.website => Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
    ContactType.github => const FaIcon(FontAwesomeIcons.github, color: Colors.black),
    ContactType.linkedin => const FaIcon(FontAwesomeIcons.linkedin, color: Color(0xFF0A66C2)),
    ContactType.twitter => const FaIcon(FontAwesomeIcons.twitter, color: Color(0xFF1DA1F2)),
    ContactType.facebook => const FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF1877F2)),
    ContactType.instagram => const FaIcon(FontAwesomeIcons.instagram, color: Color(0xFFC13584)),
    ContactType.youtube => const FaIcon(FontAwesomeIcons.youtube, color: Color(0xFFFF0000)),
    ContactType.tiktok => const FaIcon(FontAwesomeIcons.tiktok, color: Color(0xFF010101)),
    ContactType.other => Icon(Icons.device_unknown, color: Theme.of(context).colorScheme.secondary),
  };
}
