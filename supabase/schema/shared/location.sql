-- Location table
CREATE TABLE IF NOT EXISTS locations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  address TEXT NOT NULL,
  lat DOUBLE PRECISION,
  lng DOUBLE PRECISION,
  region TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Extend PostgreSQL with PostGIS if it's not already enabled
-- CREATE EXTENSION IF NOT EXISTS postgis;

-- Create index for spatial queries if PostGIS is used
-- CREATE INDEX IF NOT EXISTS locations_geom_idx ON locations USING GIST (ST_SetSRID(ST_MakePoint(lng, lat), 4326)); 

-- Profile locations linking table
CREATE TABLE IF NOT EXISTS profile_locations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  location_id UUID NOT NULL,
  is_main BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_location
    FOREIGN KEY(location_id)
    REFERENCES locations(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS profile_locations_profile_id_idx ON profile_locations(profile_id);
CREATE INDEX IF NOT EXISTS profile_locations_location_id_idx ON profile_locations(location_id); 