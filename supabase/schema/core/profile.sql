-- Drop deepest child tables first (linked to subprofiles)
DROP TABLE IF EXISTS construction_team_services;
DROP TABLE IF EXISTS contractor_services;
DROP TABLE IF EXISTS supplier_material_categories;
DROP TABLE IF EXISTS supplier_types;
DROP TABLE IF EXISTS architect_design_styles;
DROP TABLE IF EXISTS architect_portfolio_links;

-- Drop subprofile tables that depend on profiles
DROP TABLE IF EXISTS architect_profiles;
DROP TABLE IF EXISTS contractor_profiles;
DROP TABLE IF EXISTS construction_team_profiles;
DROP TABLE IF EXISTS supplier_profiles;

-- Drop existing tables (in reverse dependency order)
DROP TABLE IF EXISTS profile_payment_methods;
DROP TABLE IF EXISTS profile_contacts;
DROP TABLE IF EXISTS profile_domains;
DROP TABLE IF EXISTS profiles;

-- Drop indexes if they exist
DROP INDEX IF EXISTS profiles_user_id_idx;
DROP INDEX IF EXISTS profiles_profile_type_idx;
DROP INDEX IF EXISTS profiles_main_city_idx;
DROP INDEX IF EXISTS profiles_operating_areas_city_idx;

-- Main Profile Table
CREATE TABLE profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL,
  profile_type profile_type NOT NULL,
  bio TEXT NOT NULL,
  availability_status availability_status NOT NULL,
  years_of_experience INTEGER NOT NULL,
  working_mode working_mode NOT NULL,
  business_entity_type business_entity_type NOT NULL,

  main_city city NOT NULL,
  main_address TEXT
);

-- Profile Domains (Many-to-Many via enum)
CREATE TABLE profile_domains (
  profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  domain domain NOT NULL,
  PRIMARY KEY (profile_id, domain)
);

-- Profile Contacts (One-to-Many, contact stored as JSONB)
CREATE TABLE profile_contacts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  contact JSONB NOT NULL
);

-- Profile Payment Methods (Many-to-Many via enum)
CREATE TABLE profile_payment_methods (
  profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  payment_method payment_method NOT NULL,
  PRIMARY KEY (profile_id, payment_method)
);

-- Operating Areas: Many-to-Many (Enum List)
CREATE TABLE profile_operating_areas (
  profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  city city NOT NULL,
  PRIMARY KEY (profile_id, city)
);

-- Create useful indexes for lookup and filtering
CREATE INDEX profiles_user_id_idx ON profiles(user_id);
CREATE INDEX profiles_profile_type_idx ON profiles(profile_type);
CREATE INDEX profiles_main_city_idx ON profiles(main_city);
CREATE INDEX profiles_operating_areas_city_idx ON profile_operating_areas(city);