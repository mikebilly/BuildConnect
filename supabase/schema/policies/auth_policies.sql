-- Additional Row Level Security Policies

-- Enable RLS on locations
ALTER TABLE locations ENABLE ROW LEVEL SECURITY;

-- Locations are viewable by everyone
CREATE POLICY "Locations are viewable by everyone" ON locations
  FOR SELECT USING (true);
  
-- Locations can be created by anyone
CREATE POLICY "Locations can be created by authenticated users" ON locations
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');
  
-- Locations can be updated by anyone (they are shared resources)
CREATE POLICY "Locations can be updated by authenticated users" ON locations
  FOR UPDATE USING (auth.role() = 'authenticated');

-- Profile locations policies
ALTER TABLE profile_locations ENABLE ROW LEVEL SECURITY;

-- Profile locations are viewable by everyone
CREATE POLICY "Profile locations are viewable by everyone" ON profile_locations
  FOR SELECT USING (true);
  
-- Users can manage their profile locations
CREATE POLICY "Users can manage their profile locations" ON profile_locations
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = profile_locations.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );

-- Enable RLS on media
ALTER TABLE media ENABLE ROW LEVEL SECURITY;

-- Media items are viewable by everyone
CREATE POLICY "Media items are viewable by everyone" ON media
  FOR SELECT USING (true);
  
-- Media items can be created by authenticated users
CREATE POLICY "Media items can be created by authenticated users" ON media
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');
  
-- Media items cannot be updated once created
CREATE POLICY "Media items cannot be updated" ON media
  FOR UPDATE USING (false);

-- Media items can be deleted by their related profile owners
CREATE POLICY "Media items can be deleted by related profile owners" ON media
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM profile_media pm
      JOIN profiles p ON pm.profile_id = p.id
      WHERE pm.media_id = media.id AND p.user_id = auth.uid()
    ) OR
    EXISTS (
      SELECT 1 FROM project_media prm
      JOIN projects pr ON prm.project_id = pr.id
      JOIN profiles p ON pr.profile_id = p.id
      WHERE prm.media_id = media.id AND p.user_id = auth.uid()
    ) OR
    EXISTS (
      SELECT 1 FROM equipment_media em
      JOIN equipment e ON em.equipment_id = e.id
      JOIN profiles p ON e.profile_id = p.id
      WHERE em.media_id = media.id AND p.user_id = auth.uid()
    ) OR
    EXISTS (
      SELECT 1 FROM supplier_catalogs sc
      JOIN supplier_profiles sp ON sc.supplier_profile_id = sp.id
      JOIN profiles p ON sp.profile_id = p.id
      WHERE sc.media_id = media.id AND p.user_id = auth.uid()
    )
  );

-- Additional policies as needed for other tables can be added here 