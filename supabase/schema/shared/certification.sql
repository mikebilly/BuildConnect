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