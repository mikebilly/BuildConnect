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