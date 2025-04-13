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