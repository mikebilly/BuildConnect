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