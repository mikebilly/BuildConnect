-- Equipment table
CREATE TABLE IF NOT EXISTS equipment (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  name TEXT NOT NULL,
  equipment_type TEXT,
  specification TEXT,
  quantity INTEGER NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Equipment media linking table
CREATE TABLE IF NOT EXISTS equipment_media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  equipment_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_equipment
    FOREIGN KEY(equipment_id)
    REFERENCES equipment(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS equipment_profile_id_idx ON equipment(profile_id);
CREATE INDEX IF NOT EXISTS equipment_media_equipment_id_idx ON equipment_media(equipment_id);
CREATE INDEX IF NOT EXISTS equipment_media_media_id_idx ON equipment_media(media_id);

-- Enable Row Level Security
ALTER TABLE equipment ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipment_media ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Equipment is viewable by everyone" ON equipment
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their equipment" ON equipment
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = equipment.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Equipment media is viewable by everyone" ON equipment_media
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their equipment media" ON equipment_media
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM equipment
      JOIN profiles ON equipment.profile_id = profiles.id
      WHERE equipment.id = equipment_media.equipment_id
      AND profiles.user_id = auth.uid()
    )
  ); 