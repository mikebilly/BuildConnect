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