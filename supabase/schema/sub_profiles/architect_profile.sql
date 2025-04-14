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