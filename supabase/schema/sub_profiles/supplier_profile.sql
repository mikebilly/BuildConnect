-- Supplier profile table
CREATE TABLE IF NOT EXISTS supplier_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  supplier_type supplier_type NOT NULL,
  supply_capacity TEXT,
  delivery_radius INTEGER,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Supplier warehouse locations linking table
CREATE TABLE IF NOT EXISTS supplier_warehouse_locations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  supplier_profile_id UUID NOT NULL,
  location_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_supplier_profile
    FOREIGN KEY(supplier_profile_id)
    REFERENCES supplier_profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_location
    FOREIGN KEY(location_id)
    REFERENCES locations(id)
    ON DELETE CASCADE
);

-- Supplier material categories linking table
CREATE TABLE IF NOT EXISTS supplier_material_categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  supplier_profile_id UUID NOT NULL,
  material_category material_category NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_supplier_profile
    FOREIGN KEY(supplier_profile_id)
    REFERENCES supplier_profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(supplier_profile_id, material_category)
);

-- Supplier catalog media linking table
CREATE TABLE IF NOT EXISTS supplier_catalogs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  supplier_profile_id UUID NOT NULL,
  media_id UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_supplier_profile
    FOREIGN KEY(supplier_profile_id)
    REFERENCES supplier_profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_media
    FOREIGN KEY(media_id)
    REFERENCES media(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS supplier_profiles_profile_id_idx ON supplier_profiles(profile_id);
CREATE INDEX IF NOT EXISTS supplier_profiles_supplier_type_idx ON supplier_profiles(supplier_type);
CREATE INDEX IF NOT EXISTS supplier_warehouse_locations_supplier_profile_id_idx ON supplier_warehouse_locations(supplier_profile_id);
CREATE INDEX IF NOT EXISTS supplier_warehouse_locations_location_id_idx ON supplier_warehouse_locations(location_id);
CREATE INDEX IF NOT EXISTS supplier_material_categories_supplier_profile_id_idx ON supplier_material_categories(supplier_profile_id);
CREATE INDEX IF NOT EXISTS supplier_catalogs_supplier_profile_id_idx ON supplier_catalogs(supplier_profile_id);
CREATE INDEX IF NOT EXISTS supplier_catalogs_media_id_idx ON supplier_catalogs(media_id);

-- Enable Row Level Security
ALTER TABLE supplier_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_warehouse_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_material_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_catalogs ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Supplier profiles are viewable by everyone" ON supplier_profiles
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their supplier profile" ON supplier_profiles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = supplier_profiles.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );

-- Policies for related tables
CREATE POLICY "Warehouse locations are viewable by everyone" ON supplier_warehouse_locations
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their warehouse locations" ON supplier_warehouse_locations
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM supplier_profiles
      JOIN profiles ON supplier_profiles.profile_id = profiles.id
      WHERE supplier_profiles.id = supplier_warehouse_locations.supplier_profile_id
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Material categories are viewable by everyone" ON supplier_material_categories
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their material categories" ON supplier_material_categories
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM supplier_profiles
      JOIN profiles ON supplier_profiles.profile_id = profiles.id
      WHERE supplier_profiles.id = supplier_material_categories.supplier_profile_id
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Catalogs are viewable by everyone" ON supplier_catalogs
  FOR SELECT USING (true);
  
CREATE POLICY "Users can manage their catalogs" ON supplier_catalogs
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM supplier_profiles
      JOIN profiles ON supplier_profiles.profile_id = profiles.id
      WHERE supplier_profiles.id = supplier_catalogs.supplier_profile_id
      AND profiles.user_id = auth.uid()
    )
  ); 