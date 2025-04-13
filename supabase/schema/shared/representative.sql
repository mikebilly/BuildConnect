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