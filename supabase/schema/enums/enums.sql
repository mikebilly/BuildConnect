-- enums.sql

-- ProfileType
CREATE TYPE profile_type AS ENUM (
  'architect',
  'contractor',
  'constructionTeam',
  'supplier'
);

-- WorkingMode
CREATE TYPE working_mode AS ENUM (
  'onsite',
  'remote',
  'hybrid'
);

-- Domain
CREATE TYPE domain AS ENUM (
  'residential',
  'commercial',
  'industrial',
  'hospitality',
  'urbanPlanning',
  'education',
  'healthcare',
  'cultural',
  'infrastructure',
  'renovation'
);

-- ProjectRole
CREATE TYPE project_role AS ENUM (
  'design',
  'construction',
  'supervision',
  'supply'
);

-- ProjectStatus
CREATE TYPE project_status AS ENUM (
  'ongoing',
  'completed',
  'cancelled'
);

-- AvailabilityStatus
CREATE TYPE availability_status AS ENUM (
  'available',
  'unavailable',
  'busy',
  'onLeave'
);

-- ArchitectRole
CREATE TYPE architect_role AS ENUM (
  'seniorArchitect',
  'designConsultant',
  'interiorArchitect',
  'projectArchitect',
  'landscapeArchitect',
  'urbanPlanner'
);

-- DesignStyle
CREATE TYPE design_style AS ENUM (
  'minimalism',
  'modern',
  'classical',
  'tropical',
  'neoclassical',
  'scandinavian',
  'traditional'
);

-- ServiceType
CREATE TYPE service_type AS ENUM (
  'fullConstruction',
  'interiorFitOut',
  'electricalInstallation',
  'plumbing',
  'finishingWorks',
  'roofing',
  'steelStructure',
  'bricklaying',
  'tiling',
  'painting',
  'scaffolding',
  'concreteWorks',
  'welding'
);

-- SupplierType
CREATE TYPE supplier_type AS ENUM (
  'enterprise',
  'distributor',
  'retailStore',
  'individual',
  'reseller',
  'manufacturer',
  'brand'
);

-- MaterialCategory
CREATE TYPE material_category AS ENUM (
  'cement',
  'bricks',
  'sandAndGravel',
  'steel',
  'electricalEquipment',
  'lighting',
  'plumbingEquipment',
  'tiles',
  'paint',
  'doorsAndWindows',
  'waterproofing',
  'wood',
  'interiorFurniture',
  'safetyEquipment',
  'toolsAndHardware',
  'roofing'
);

-- BusinessEntityType
CREATE TYPE business_entity_type AS ENUM (
  'individual',
  'partnership',
  'limitedCompany',
  'corporation',
  'cooperative'
);

-- PaymentMethod
CREATE TYPE payment_method AS ENUM (
  'cash',
  'bankTransfer',
  'creditCard',
  'mobileBanking',
  'eWallet'
);

-- MediaType
CREATE TYPE media_type AS ENUM (
  'image',
  'video',
  'document',
  'model3D'
);

-- JobStatus
CREATE TYPE job_status AS ENUM (
  'pending',
  'active',
  'closed',
  'cancelled'
);

-- ApplicationStatus
CREATE TYPE application_status AS ENUM (
  'pending',
  'accepted',
  'rejected'
);

-- JobPostingType
CREATE TYPE job_posting_type AS ENUM (
  'hiring',
  'partnership',
  'materials',
  'other'
);

-- ContactType
CREATE TYPE contact_type AS ENUM (
  'email',
  'phone',
  'website',
  'github',
  'linkedin',
  'twitter',
  'facebook',
  'instagram',
  'youtube',
  'tiktok',
  'other'
);

-- City
CREATE TYPE city as ENUM (
  'hanoi', 
  'hoChiMinh', 
  'daNang', 
  'haiPhong', 
  'canTho',
  'ninhBinh', 
  'hue', 
  'daLat', 
  'bienHoa', 
  'vungTau'
)