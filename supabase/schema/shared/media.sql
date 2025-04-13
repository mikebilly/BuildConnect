-- Media table for storing URLs to images, videos, and other media files
CREATE TABLE IF NOT EXISTS media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  url TEXT NOT NULL,
  label TEXT,
  media_type TEXT,
  uploaded_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Link table for profiles media
CREATE TABLE IF NOT EXISTS profile_media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Link table for project media
CREATE TABLE IF NOT EXISTS project_media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_project
    FOREIGN KEY(project_id)
    REFERENCES projects(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS profile_media_profile_id_idx ON profile_media(profile_id);
CREATE INDEX IF NOT EXISTS profile_media_media_id_idx ON profile_media(media_id);
CREATE INDEX IF NOT EXISTS project_media_project_id_idx ON project_media(project_id);
CREATE INDEX IF NOT EXISTS project_media_media_id_idx ON project_media(media_id); 