-- Flattened schema for BuildConnect
-- Generated on Mon, Apr 14, 2025  6:22:40 PM

-- Schema orchestration file for BuildConnect
-- This file imports all SQL schema files in the correct order

-- Enums (need to be created first)
-- Included file: schema/enums/architect_role.sql
-- Enum for architect roles
CREATE TYPE architect_role AS ENUM (
  'seniorArchitect',
  'designConsultant', 
  'interiorArchitect',
  'projectArchitect',
  'landscapeArchitect',
  'urbanPlanner'
); 

-- Included file: schema/enums/business_entity_type.sql
-- Enum for business entity types
CREATE TYPE business_entity_type AS ENUM (
  'individual',
  'householdBusiness',
  'companyLimited',
  'jointStockCompany',
  'partnershipCompany',
  'stateOwnedEnterprise',
  'foreignEnterprise'
); 

-- Included file: schema/enums/design_style.sql
-- Enum for design styles
CREATE TYPE design_style AS ENUM (
  'minimalism',
  'modern',
  'classical',
  'tropical',
  'neoclassical',
  'scandinavian',
  'traditional'
); 

-- Included file: schema/enums/domain.sql
-- Enum for domains/sectors
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

-- Included file: schema/enums/material_category.sql
-- Enum for material categories
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

-- Included file: schema/enums/payment_method.sql
-- Enum for payment methods
CREATE TYPE payment_method AS ENUM (
  'cod',
  'bankTransfer',
  'installment'
); 

-- Included file: schema/enums/profile_type.sql
-- Enum for profile types
CREATE TYPE profile_type AS ENUM (
  'architect',
  'contractor',
  'constructionTeam',
  'supplier'
); 

-- Included file: schema/enums/project_role.sql
-- Enum for project roles
CREATE TYPE project_role AS ENUM (
  'design',
  'construction',
  'supervision',
  'supply'
); 

-- Included file: schema/enums/project_status.sql
-- Enum for project statuses
CREATE TYPE project_status AS ENUM (
  'ongoing',
  'completed',
  'cancelled'
); 

-- Included file: schema/enums/service_type.sql
-- Enum for service types
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

-- Included file: schema/enums/supplier_type.sql
-- Enum for supplier types
CREATE TYPE supplier_type AS ENUM (
  'enterprise',
  'distributor',
  'retailStore',
  'individual',
  'reseller',
  'manufacturer',
  'brand'
); 

-- Included file: schema/enums/working_mode.sql
-- Enum for working modes
CREATE TYPE working_mode AS ENUM (
  'onsite',
  'remote',
  'hybrid'
); 


-- Included file: schema/core/user.sql
-- User table that extends Supabase auth.users
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view their own user data" ON users
  FOR SELECT USING (auth.uid() = id);
  
CREATE POLICY "Users can update their own user data" ON users
  FOR UPDATE USING (auth.uid() = id);

-- Function to create a new user entry when a new auth user is created
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, email)
  VALUES (NEW.id, NEW.email);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to call the function when a new auth user is created
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user(); 

-- Included file: schema/core/profile.sql
-- Profile table
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID UNIQUE REFERENCES users(id) ON DELETE SET NULL,
  display_name TEXT NOT NULL,
  logo TEXT,
  profile_type profile_type NOT NULL,
  profile_photo TEXT,
  bio TEXT,
  availability_status TEXT DEFAULT 'available',
  years_of_experience INTEGER,
  established_date DATE,
  operating_areas TEXT[] DEFAULT '{}',
  working_mode working_mode,
  links TEXT[] DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Profile domains linking table
CREATE TABLE IF NOT EXISTS profile_domains (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  domain domain NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(profile_id, domain)
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS profiles_user_id_idx ON profiles(user_id);
CREATE INDEX IF NOT EXISTS profiles_profile_type_idx ON profiles(profile_type);
CREATE INDEX IF NOT EXISTS profile_domains_profile_id_idx ON profile_domains(profile_id);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Profiles are viewable by everyone" ON profiles
  FOR SELECT USING (true);
  
CREATE POLICY "Users can create their own profile" ON profiles
  FOR INSERT WITH CHECK (auth.uid() = user_id);
  
CREATE POLICY "Users can update their own profile" ON profiles
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own profile" ON profiles
  FOR DELETE USING (auth.uid() = user_id);
  
-- Same policies for profile domains
ALTER TABLE profile_domains ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Profile domains are viewable by everyone" ON profile_domains
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their profile domains" ON profile_domains
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = profile_domains.profile_id 
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/shared/location.sql
-- Location table
CREATE TABLE IF NOT EXISTS locations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  address TEXT NOT NULL,
  lat DOUBLE PRECISION,
  lng DOUBLE PRECISION,
  region TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Extend PostgreSQL with PostGIS if it's not already enabled
-- CREATE EXTENSION IF NOT EXISTS postgis;

-- Create index for spatial queries if PostGIS is used
-- CREATE INDEX IF NOT EXISTS locations_geom_idx ON locations USING GIST (ST_SetSRID(ST_MakePoint(lng, lat), 4326)); 

-- Profile locations linking table
CREATE TABLE IF NOT EXISTS profile_locations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  location_id UUID NOT NULL,
  is_main BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_location
    FOREIGN KEY(location_id)
    REFERENCES locations(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS profile_locations_profile_id_idx ON profile_locations(profile_id);
CREATE INDEX IF NOT EXISTS profile_locations_location_id_idx ON profile_locations(location_id); 

-- Included file: schema/core/project.sql
-- Projects table
CREATE TABLE IF NOT EXISTS projects (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  profile_id UUID NOT NULL,
  project_role project_role NOT NULL,
  location_id UUID,
  project_status project_status DEFAULT 'ongoing',
  start_date DATE,
  end_date DATE,
  budget DECIMAL(15,2),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_location
    FOREIGN KEY(location_id)
    REFERENCES locations(id)
    ON DELETE SET NULL
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS projects_profile_id_idx ON projects(profile_id);
CREATE INDEX IF NOT EXISTS projects_location_id_idx ON projects(location_id);
CREATE INDEX IF NOT EXISTS projects_project_status_idx ON projects(project_status);
CREATE INDEX IF NOT EXISTS projects_project_role_idx ON projects(project_role);

-- Enable Row Level Security
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Projects are viewable by everyone" ON projects
  FOR SELECT USING (true);
  
CREATE POLICY "Users can create projects for their profiles" ON projects
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = projects.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Users can update their own projects" ON projects
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = projects.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete their own projects" ON projects
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = projects.profile_id 
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/shared/media.sql
-- Media table for storing URLs to images, videos, and other media files
CREATE TABLE IF NOT EXISTS media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  url TEXT NOT NULL,
  label TEXT,
  media_type TEXT,
  uploaded_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Link table for profiles media
CREATE TABLE IF NOT EXISTS profile_media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Link table for project media
CREATE TABLE IF NOT EXISTS project_media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_project
    FOREIGN KEY(project_id)
    REFERENCES projects(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS profile_media_profile_id_idx ON profile_media(profile_id);
CREATE INDEX IF NOT EXISTS profile_media_media_id_idx ON profile_media(media_id);
CREATE INDEX IF NOT EXISTS project_media_project_id_idx ON project_media(project_id);
CREATE INDEX IF NOT EXISTS project_media_media_id_idx ON project_media(media_id); 


-- Shared types/tables
-- Included file: schema/shared/certification.sql
-- Certification table
CREATE TABLE IF NOT EXISTS certifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  name TEXT NOT NULL,
  issuer TEXT NOT NULL,
  certificate_number TEXT,
  issue_date DATE,
  expiry_date DATE,
  description TEXT,
  media_id UUID,
  certification_urls TEXT[] DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE SET NULL
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS certifications_profile_id_idx ON certifications(profile_id); 

-- Included file: schema/shared/contact_info.sql
-- Contact information table
CREATE TABLE IF NOT EXISTS contact_info (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  phone_numbers TEXT[] NOT NULL DEFAULT '{}',
  emails TEXT[] NOT NULL DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS contact_info_profile_id_idx ON contact_info(profile_id);

-- Enable Row Level Security
ALTER TABLE contact_info ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Contact info is viewable by everyone" ON contact_info
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their contact info" ON contact_info
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = contact_info.profile_id 
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/shared/education.sql
-- Education table
CREATE TABLE IF NOT EXISTS education (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  degree TEXT NOT NULL,
  institution TEXT NOT NULL,
  graduation_year INTEGER,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS education_profile_id_idx ON education(profile_id); 

-- Included file: schema/shared/equipment.sql
-- Equipment table
CREATE TABLE IF NOT EXISTS equipment (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  name TEXT NOT NULL,
  equipment_type TEXT,
  specification TEXT,
  quantity INTEGER NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Equipment media linking table
CREATE TABLE IF NOT EXISTS equipment_media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  equipment_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_equipment
    FOREIGN KEY(equipment_id)
    REFERENCES equipment(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS equipment_profile_id_idx ON equipment(profile_id);
CREATE INDEX IF NOT EXISTS equipment_media_equipment_id_idx ON equipment_media(equipment_id);
CREATE INDEX IF NOT EXISTS equipment_media_media_id_idx ON equipment_media(media_id);

-- Enable Row Level Security
ALTER TABLE equipment ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipment_media ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Equipment is viewable by everyone" ON equipment
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their equipment" ON equipment
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = equipment.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Equipment media is viewable by everyone" ON equipment_media
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their equipment media" ON equipment_media
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM equipment
      JOIN profiles ON equipment.profile_id = profiles.id
      WHERE equipment.id = equipment_media.equipment_id
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/shared/legal.sql
-- Legal information table
CREATE TABLE IF NOT EXISTS legal (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  license TEXT,
  tax_code TEXT,
  business_entity_type business_entity_type,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS legal_profile_id_idx ON legal(profile_id); 



-- Included file: schema/shared/payment_terms.sql
-- Payment terms table
CREATE TABLE IF NOT EXISTS payment_terms (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  deposit_required BOOLEAN DEFAULT false,
  deposit_amount DECIMAL(10,2),
  installments BOOLEAN DEFAULT false,
  payment_schedule TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Payment methods linking table
CREATE TABLE IF NOT EXISTS profile_payment_methods (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  payment_method payment_method NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(profile_id, payment_method)
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS payment_terms_profile_id_idx ON payment_terms(profile_id);
CREATE INDEX IF NOT EXISTS profile_payment_methods_profile_id_idx ON profile_payment_methods(profile_id); 

-- Included file: schema/shared/review.sql
-- Reviews table
CREATE TABLE IF NOT EXISTS reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  reviewer_id UUID NOT NULL,
  rating DECIMAL(2,1) NOT NULL CHECK (rating >= 0 AND rating <= 5),
  comment TEXT,
  review_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_reviewer
    FOREIGN KEY(reviewer_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS reviews_profile_id_idx ON reviews(profile_id);
CREATE INDEX IF NOT EXISTS reviews_reviewer_id_idx ON reviews(reviewer_id); 

-- Included file: schema/shared/ratings_info.sql
-- Ratings information table
CREATE TABLE IF NOT EXISTS ratings_info (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  average_rating DECIMAL(2,1) DEFAULT 0 CHECK (average_rating >= 0 AND average_rating <= 5),
  total_reviews INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS ratings_info_profile_id_idx ON ratings_info(profile_id);

-- Function to update average rating when a new review is added
CREATE OR REPLACE FUNCTION update_ratings_info()
RETURNS TRIGGER AS $$
BEGIN
  -- Update the average rating and total reviews
  UPDATE ratings_info
  SET 
    average_rating = (
      SELECT COALESCE(AVG(rating), 0)
      FROM reviews
      WHERE profile_id = NEW.profile_id
    ),
    total_reviews = (
      SELECT COUNT(*)
      FROM reviews
      WHERE profile_id = NEW.profile_id
    ),
    updated_at = NOW()
  WHERE profile_id = NEW.profile_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update ratings info
CREATE TRIGGER update_ratings_after_review
AFTER INSERT OR UPDATE OR DELETE ON reviews
FOR EACH ROW
EXECUTE FUNCTION update_ratings_info(); 

-- Included file: schema/shared/representative.sql
-- Representative information table
CREATE TABLE IF NOT EXISTS representative (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  position TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS representative_profile_id_idx ON representative(profile_id); 


-- Included file: schema/shared/social.sql
-- Social media links
CREATE TABLE IF NOT EXISTS socials (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  platform TEXT NOT NULL,
  url TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS socials_profile_id_idx ON socials(profile_id);

-- Enable Row Level Security
ALTER TABLE socials ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Socials are viewable by everyone" ON socials
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their socials" ON socials
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = socials.profile_id
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/shared/verification_info.sql
-- Verification information table
CREATE TABLE IF NOT EXISTS verification_info (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  is_verified BOOLEAN NOT NULL DEFAULT false,
  verified_date TIMESTAMPTZ,
  verified_by TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS verification_info_profile_id_idx ON verification_info(profile_id); 

-- Included file: schema/shared/warranty.sql
-- Warranty information table
CREATE TABLE IF NOT EXISTS warranty (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  duration TEXT NOT NULL,
  terms TEXT,
  coverage TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS warranty_profile_id_idx ON warranty(profile_id); 


-- Core tables




-- Profile subtypes
-- Included file: schema/sub_profiles/architect_profile.sql
-- Architect profile table
CREATE TABLE IF NOT EXISTS architect_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  architect_role architect_role NOT NULL,
  design_philosophy TEXT,
  portfolio_links TEXT[] DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
    
);

-- Architect design styles linking table
CREATE TABLE IF NOT EXISTS architect_design_styles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  architect_profile_id UUID NOT NULL,
  design_style design_style NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_architect_profile
    FOREIGN KEY(architect_profile_id)
    REFERENCES architect_profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(architect_profile_id, design_style)
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS architect_profiles_profile_id_idx ON architect_profiles(profile_id);
CREATE INDEX IF NOT EXISTS architect_profiles_architect_role_idx ON architect_profiles(architect_role);
CREATE INDEX IF NOT EXISTS architect_design_styles_architect_profile_id_idx ON architect_design_styles(architect_profile_id);

-- Enable Row Level Security
ALTER TABLE architect_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE architect_design_styles ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Architect profiles are viewable by everyone" ON architect_profiles
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their architect profile" ON architect_profiles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = architect_profiles.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Design styles are viewable by everyone" ON architect_design_styles
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their design styles" ON architect_design_styles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM architect_profiles
      JOIN profiles ON architect_profiles.profile_id = profiles.id
      WHERE architect_profiles.id = architect_design_styles.architect_profile_id
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/sub_profiles/construction_team_profile.sql
-- Construction team profile table
CREATE TABLE IF NOT EXISTS construction_team_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  team_size INTEGER,
  representative_id UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_representative
    FOREIGN KEY(representative_id)
    REFERENCES representative(id)
    ON DELETE SET NULL
);

-- Construction team services linking table
CREATE TABLE IF NOT EXISTS construction_team_services (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  construction_team_profile_id UUID NOT NULL,
  service_type service_type NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_construction_team_profile
    FOREIGN KEY(construction_team_profile_id)
    REFERENCES construction_team_profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(construction_team_profile_id, service_type)
);

-- Construction team equipment linking table
CREATE TABLE IF NOT EXISTS construction_team_equipment (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  construction_team_profile_id UUID NOT NULL,
  equipment_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_construction_team_profile
    FOREIGN KEY(construction_team_profile_id)
    REFERENCES construction_team_profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_equipment
    FOREIGN KEY(equipment_id)
    REFERENCES equipment(id)
    ON DELETE CASCADE,
    
  UNIQUE(construction_team_profile_id, equipment_id)
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS construction_team_profiles_profile_id_idx ON construction_team_profiles(profile_id);
CREATE INDEX IF NOT EXISTS construction_team_profiles_representative_id_idx ON construction_team_profiles(representative_id);
CREATE INDEX IF NOT EXISTS construction_team_services_construction_team_profile_id_idx ON construction_team_services(construction_team_profile_id);
CREATE INDEX IF NOT EXISTS construction_team_equipment_construction_team_profile_id_idx ON construction_team_equipment(construction_team_profile_id);
CREATE INDEX IF NOT EXISTS construction_team_equipment_equipment_id_idx ON construction_team_equipment(equipment_id);

-- Enable Row Level Security
ALTER TABLE construction_team_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE construction_team_services ENABLE ROW LEVEL SECURITY;
ALTER TABLE construction_team_equipment ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Construction team profiles are viewable by everyone" ON construction_team_profiles
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their construction team profile" ON construction_team_profiles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = construction_team_profiles.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Services are viewable by everyone" ON construction_team_services
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their services" ON construction_team_services
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM construction_team_profiles
      JOIN profiles ON construction_team_profiles.profile_id = profiles.id
      WHERE construction_team_profiles.id = construction_team_services.construction_team_profile_id
      AND profiles.user_id = auth.uid()
    )
  );

CREATE POLICY "Equipment associations are viewable by everyone" ON construction_team_equipment
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their equipment associations" ON construction_team_equipment
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM construction_team_profiles
      JOIN profiles ON construction_team_profiles.profile_id = profiles.id
      WHERE construction_team_profiles.id = construction_team_equipment.construction_team_profile_id
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/sub_profiles/contractor_profile.sql
-- Contractor profile table
CREATE TABLE IF NOT EXISTS contractor_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Contractor services linking table
CREATE TABLE IF NOT EXISTS contractor_services (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  contractor_profile_id UUID NOT NULL,
  service_type service_type NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_contractor_profile
    FOREIGN KEY(contractor_profile_id)
    REFERENCES contractor_profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(contractor_profile_id, service_type)
);

-- Contractor equipment linking table
CREATE TABLE IF NOT EXISTS contractor_equipment (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  contractor_profile_id UUID NOT NULL,
  equipment_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_contractor_profile
    FOREIGN KEY(contractor_profile_id)
    REFERENCES contractor_profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_equipment
    FOREIGN KEY(equipment_id)
    REFERENCES equipment(id)
    ON DELETE CASCADE,
    
  UNIQUE(contractor_profile_id, equipment_id)
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS contractor_profiles_profile_id_idx ON contractor_profiles(profile_id);
CREATE INDEX IF NOT EXISTS contractor_services_contractor_profile_id_idx ON contractor_services(contractor_profile_id);
CREATE INDEX IF NOT EXISTS contractor_equipment_contractor_profile_id_idx ON contractor_equipment(contractor_profile_id);
CREATE INDEX IF NOT EXISTS contractor_equipment_equipment_id_idx ON contractor_equipment(equipment_id);

-- Enable Row Level Security
ALTER TABLE contractor_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE contractor_services ENABLE ROW LEVEL SECURITY;
ALTER TABLE contractor_equipment ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Contractor profiles are viewable by everyone" ON contractor_profiles
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their contractor profile" ON contractor_profiles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = contractor_profiles.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Services are viewable by everyone" ON contractor_services
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their services" ON contractor_services
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM contractor_profiles
      JOIN profiles ON contractor_profiles.profile_id = profiles.id
      WHERE contractor_profiles.id = contractor_services.contractor_profile_id
      AND profiles.user_id = auth.uid()
    )
  );

CREATE POLICY "Equipment associations are viewable by everyone" ON contractor_equipment
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their equipment associations" ON contractor_equipment
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM contractor_profiles
      JOIN profiles ON contractor_profiles.profile_id = profiles.id
      WHERE contractor_profiles.id = contractor_equipment.contractor_profile_id
      AND profiles.user_id = auth.uid()
    )
  ); 

-- Included file: schema/sub_profiles/supplier_profile.sql
-- Supplier profile table
CREATE TABLE IF NOT EXISTS supplier_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  supplier_type supplier_type NOT NULL,
  supply_capacity TEXT,
  delivery_radius INTEGER,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Supplier warehouse locations linking table
CREATE TABLE IF NOT EXISTS supplier_warehouse_locations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  supplier_profile_id UUID NOT NULL,
  location_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_supplier_profile
    FOREIGN KEY(supplier_profile_id)
    REFERENCES supplier_profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_location
    FOREIGN KEY(location_id)
    REFERENCES locations(id)
    ON DELETE CASCADE
);

-- Supplier material categories linking table
CREATE TABLE IF NOT EXISTS supplier_material_categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  supplier_profile_id UUID NOT NULL,
  material_category material_category NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_supplier_profile
    FOREIGN KEY(supplier_profile_id)
    REFERENCES supplier_profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(supplier_profile_id, material_category)
);

-- Supplier catalog media linking table
CREATE TABLE IF NOT EXISTS supplier_catalogs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  supplier_profile_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_supplier_profile
    FOREIGN KEY(supplier_profile_id)
    REFERENCES supplier_profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS supplier_profiles_profile_id_idx ON supplier_profiles(profile_id);
CREATE INDEX IF NOT EXISTS supplier_profiles_supplier_type_idx ON supplier_profiles(supplier_type);
CREATE INDEX IF NOT EXISTS supplier_warehouse_locations_supplier_profile_id_idx ON supplier_warehouse_locations(supplier_profile_id);
CREATE INDEX IF NOT EXISTS supplier_warehouse_locations_location_id_idx ON supplier_warehouse_locations(location_id);
CREATE INDEX IF NOT EXISTS supplier_material_categories_supplier_profile_id_idx ON supplier_material_categories(supplier_profile_id);
CREATE INDEX IF NOT EXISTS supplier_catalogs_supplier_profile_id_idx ON supplier_catalogs(supplier_profile_id);
CREATE INDEX IF NOT EXISTS supplier_catalogs_media_id_idx ON supplier_catalogs(media_id);

-- Enable Row Level Security
ALTER TABLE supplier_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_warehouse_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_material_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_catalogs ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Supplier profiles are viewable by everyone" ON supplier_profiles
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their supplier profile" ON supplier_profiles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = supplier_profiles.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );

-- Policies for related tables
CREATE POLICY "Warehouse locations are viewable by everyone" ON supplier_warehouse_locations
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their warehouse locations" ON supplier_warehouse_locations
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM supplier_profiles
      JOIN profiles ON supplier_profiles.profile_id = profiles.id
      WHERE supplier_profiles.id = supplier_warehouse_locations.supplier_profile_id
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Material categories are viewable by everyone" ON supplier_material_categories
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their material categories" ON supplier_material_categories
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM supplier_profiles
      JOIN profiles ON supplier_profiles.profile_id = profiles.id
      WHERE supplier_profiles.id = supplier_material_categories.supplier_profile_id
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Catalogs are viewable by everyone" ON supplier_catalogs
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their catalogs" ON supplier_catalogs
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM supplier_profiles
      JOIN profiles ON supplier_profiles.profile_id = profiles.id
      WHERE supplier_profiles.id = supplier_catalogs.supplier_profile_id
      AND profiles.user_id = auth.uid()
    )
  ); 


-- Functions
-- Included file: schema/functions/search_profile.sql
-- Search profiles function
CREATE OR REPLACE FUNCTION search_profiles(
  search_term TEXT DEFAULT NULL,
  profile_types profile_type[] DEFAULT NULL,
  domain_filter domain[] DEFAULT NULL,
  location_region TEXT DEFAULT NULL,
  min_rating DECIMAL DEFAULT NULL,
  working_mode_filter working_mode[] DEFAULT NULL,
  architect_role_filter architect_role[] DEFAULT NULL,
  service_type_filter service_type[] DEFAULT NULL,
  supplier_type_filter supplier_type[] DEFAULT NULL,
  material_category_filter material_category[] DEFAULT NULL,
  limit_val INTEGER DEFAULT 100,
  offset_val INTEGER DEFAULT 0
)
RETURNS TABLE (
  id UUID,
  display_name TEXT,
  profile_type profile_type,
  profile_photo TEXT,
  bio TEXT,
  average_rating DECIMAL,
  years_of_experience INTEGER,
  working_mode working_mode,
  is_verified BOOLEAN,
  location_address TEXT
)
LANGUAGE SQL
AS $$
  WITH filtered_profiles AS (
    SELECT 
      p.id,
      p.display_name,
      p.profile_type,
      p.profile_photo,
      p.bio,
      ri.average_rating,
      p.years_of_experience,
      p.working_mode,
      vi.is_verified,
      l.address AS location_address
    FROM 
      profiles p
    LEFT JOIN 
      ratings_info ri ON p.id = ri.profile_id
    LEFT JOIN 
      verification_info vi ON p.id = vi.profile_id
    LEFT JOIN 
      profile_locations pl ON pl.profile_id = p.id AND pl.is_main = true
    LEFT JOIN 
      locations l ON l.id = pl.location_id
    WHERE
      -- Filter by search term in name, bio, or other relevant fields
      (search_term IS NULL OR 
        p.display_name ILIKE '%' || search_term || '%' OR
        p.bio ILIKE '%' || search_term || '%')
      
      -- Filter by profile types
      AND (profile_types IS NULL OR p.profile_type = ANY(profile_types))
      
      -- Filter by minimum rating
      AND (min_rating IS NULL OR ri.average_rating >= min_rating)
      
      -- Filter by working mode
      AND (working_mode_filter IS NULL OR p.working_mode = ANY(working_mode_filter))
      
      -- Filter by region
      AND (location_region IS NULL OR EXISTS (
        SELECT 1 FROM profile_locations pl2
        JOIN locations loc ON pl2.location_id = loc.id
        WHERE pl2.profile_id = p.id AND loc.region = location_region
      ))
      
      -- Filter by domains
      AND (domain_filter IS NULL OR EXISTS (
        SELECT 1 FROM profile_domains pd
        WHERE pd.profile_id = p.id AND pd.domain = ANY(domain_filter)
      ))
      
      -- Filter by architect role
      AND (architect_role_filter IS NULL OR (
        p.profile_type = 'architect' AND EXISTS (
          SELECT 1 FROM architect_profiles ap
          WHERE ap.profile_id = p.id AND ap.architect_role = ANY(architect_role_filter)
        )
      ))
      
      -- Filter by service type for contractors and construction teams
      AND (service_type_filter IS NULL OR (
        p.profile_type = 'contractor' AND EXISTS (
          SELECT 1 FROM contractor_services cs
          JOIN contractor_profiles cp ON cs.contractor_profile_id = cp.id
          WHERE cp.profile_id = p.id AND cs.service_type = ANY(service_type_filter)
        )
      ) OR (
        p.profile_type = 'constructionTeam' AND EXISTS (
          SELECT 1 FROM construction_team_services cts
          JOIN construction_team_profiles ctp ON cts.construction_team_profile_id = ctp.id
          WHERE ctp.profile_id = p.id AND cts.service_type = ANY(service_type_filter)
        )
      ))
      
      -- Filter by supplier type
      AND (supplier_type_filter IS NULL OR (
        p.profile_type = 'supplier' AND EXISTS (
          SELECT 1 FROM supplier_profiles sp
          WHERE sp.profile_id = p.id AND sp.supplier_type = ANY(supplier_type_filter)
        )
      ))
      
      -- Filter by material category for suppliers
      AND (material_category_filter IS NULL OR (
        p.profile_type = 'supplier' AND EXISTS (
          SELECT 1 FROM supplier_material_categories smc
          JOIN supplier_profiles sp ON smc.supplier_profile_id = sp.id
          WHERE sp.profile_id = p.id AND smc.material_category = ANY(material_category_filter)
        )
      ))
  )
  
  SELECT *
  FROM filtered_profiles
  ORDER BY average_rating DESC NULLS LAST, display_name ASC
  LIMIT limit_val
  OFFSET offset_val;
$$; 


-- Policies (RLS)
