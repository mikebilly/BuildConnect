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