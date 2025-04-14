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