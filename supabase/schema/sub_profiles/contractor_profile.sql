-- Contractor profile table
CREATE TABLE IF NOT EXISTS contractor_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT check_profile_type
    CHECK (
      EXISTS (
        SELECT 1 FROM profiles
        WHERE profiles.id = profile_id
        AND profiles.profile_type = 'contractor'
      )
    )
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