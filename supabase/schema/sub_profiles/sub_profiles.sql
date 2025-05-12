-- Drop linking tables first (reverse dependency order)
DROP TABLE IF EXISTS architect_portfolio_links;
DROP TABLE IF EXISTS architect_design_styles;
DROP TABLE IF EXISTS contractor_services;
DROP TABLE IF EXISTS construction_team_services;
DROP TABLE IF EXISTS supplier_material_categories;

-- Drop main subprofile tables
DROP TABLE IF EXISTS architect_profiles;
DROP TABLE IF EXISTS contractor_profiles;
DROP TABLE IF EXISTS construction_team_profiles;
DROP TABLE IF EXISTS supplier_profiles;

-- Drop indexes (safe re-creation)
DROP INDEX IF EXISTS idx_architect_design_style;
DROP INDEX IF EXISTS idx_contractor_service_type;
DROP INDEX IF EXISTS idx_construction_team_service_type;
DROP INDEX IF EXISTS idx_supplier_material_category;

-- ----------------------
-- ArchitectProfile
-- ----------------------
CREATE TABLE architect_profiles (
  profile_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  architect_role architect_role NOT NULL,
  design_philosophy TEXT NOT NULL
);

CREATE TABLE architect_design_styles (
  profile_id UUID NOT NULL REFERENCES architect_profiles(profile_id) ON DELETE CASCADE,
  design_style design_style NOT NULL,
  PRIMARY KEY (profile_id, design_style)
);

CREATE INDEX idx_architect_design_style ON architect_design_styles(design_style);

CREATE TABLE architect_portfolio_links (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL REFERENCES architect_profiles(profile_id) ON DELETE CASCADE,
  portfolio_link TEXT NOT NULL
);

-- ----------------------
-- ContractorProfile
-- ----------------------
CREATE TABLE contractor_profiles (
  profile_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE
);

CREATE TABLE contractor_services (
  profile_id UUID NOT NULL REFERENCES contractor_profiles(profile_id) ON DELETE CASCADE,
  service_type service_type NOT NULL,
  PRIMARY KEY (profile_id, service_type)
);

CREATE INDEX idx_contractor_service_type ON contractor_services(service_type);

-- ----------------------
-- ConstructionTeamProfile
-- ----------------------
CREATE TABLE construction_team_profiles (
  profile_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  representative_name TEXT NOT NULL,
  representative_phone TEXT NOT NULL,
  team_size INTEGER NOT NULL
);

CREATE TABLE construction_team_services (
  profile_id UUID NOT NULL REFERENCES construction_team_profiles(profile_id) ON DELETE CASCADE,
  service_type service_type NOT NULL,
  PRIMARY KEY (profile_id, service_type)
);

CREATE INDEX idx_construction_team_service_type ON construction_team_services(service_type);

-- ----------------------
-- SupplierProfile
-- ----------------------
CREATE TABLE supplier_profiles (
  profile_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  supplier_type supplier_type NOT NULL,
  delivery_radius INTEGER NOT NULL
);

CREATE TABLE supplier_material_categories (
  profile_id UUID NOT NULL REFERENCES supplier_profiles(profile_id) ON DELETE CASCADE,
  material_category material_category NOT NULL,
  PRIMARY KEY (profile_id, material_category)
);

CREATE INDEX idx_supplier_material_category ON supplier_material_categories(material_category);
