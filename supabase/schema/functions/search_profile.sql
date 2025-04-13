-- Search profiles function
CREATE OR REPLACE FUNCTION search_profiles(
  search_term TEXT DEFAULT NULL,
  profile_types profile_type[] DEFAULT NULL,
  domain_filter domain[] DEFAULT NULL,
  location_region TEXT DEFAULT NULL,
  min_rating DECIMAL DEFAULT NULL,
  working_mode_filter working_mode[] DEFAULT NULL,
  architect_role_filter architect_role[] DEFAULT NULL,
  service_type_filter service_type[] DEFAULT NULL,
  supplier_type_filter supplier_type[] DEFAULT NULL,
  material_category_filter material_category[] DEFAULT NULL,
  limit_val INTEGER DEFAULT 100,
  offset_val INTEGER DEFAULT 0
)
RETURNS TABLE (
  id UUID,
  display_name TEXT,
  profile_type profile_type,
  profile_photo TEXT,
  bio TEXT,
  average_rating DECIMAL,
  years_of_experience INTEGER,
  working_mode working_mode,
  is_verified BOOLEAN,
  location_address TEXT
)
LANGUAGE SQL
AS $$
  WITH filtered_profiles AS (
    SELECT 
      p.id,
      p.display_name,
      p.profile_type,
      p.profile_photo,
      p.bio,
      ri.average_rating,
      p.years_of_experience,
      p.working_mode,
      vi.is_verified,
      l.address AS location_address
    FROM 
      profiles p
    LEFT JOIN 
      ratings_info ri ON p.id = ri.profile_id
    LEFT JOIN 
      verification_info vi ON p.id = vi.profile_id
    LEFT JOIN 
      profile_locations pl ON pl.profile_id = p.id AND pl.is_main = true
    LEFT JOIN 
      locations l ON l.id = pl.location_id
    WHERE
      -- Filter by search term in name, bio, or other relevant fields
      (search_term IS NULL OR 
        p.display_name ILIKE '%' || search_term || '%' OR
        p.bio ILIKE '%' || search_term || '%')
      
      -- Filter by profile types
      AND (profile_types IS NULL OR p.profile_type = ANY(profile_types))
      
      -- Filter by minimum rating
      AND (min_rating IS NULL OR ri.average_rating >= min_rating)
      
      -- Filter by working mode
      AND (working_mode_filter IS NULL OR p.working_mode = ANY(working_mode_filter))
      
      -- Filter by region
      AND (location_region IS NULL OR EXISTS (
        SELECT 1 FROM profile_locations pl2
        JOIN locations loc ON pl2.location_id = loc.id
        WHERE pl2.profile_id = p.id AND loc.region = location_region
      ))
      
      -- Filter by domains
      AND (domain_filter IS NULL OR EXISTS (
        SELECT 1 FROM profile_domains pd
        WHERE pd.profile_id = p.id AND pd.domain = ANY(domain_filter)
      ))
      
      -- Filter by architect role
      AND (architect_role_filter IS NULL OR (
        p.profile_type = 'architect' AND EXISTS (
          SELECT 1 FROM architect_profiles ap
          WHERE ap.profile_id = p.id AND ap.architect_role = ANY(architect_role_filter)
        )
      ))
      
      -- Filter by service type for contractors and construction teams
      AND (service_type_filter IS NULL OR (
        p.profile_type = 'contractor' AND EXISTS (
          SELECT 1 FROM contractor_services cs
          JOIN contractor_profiles cp ON cs.contractor_profile_id = cp.id
          WHERE cp.profile_id = p.id AND cs.service_type = ANY(service_type_filter)
        )
      ) OR (
        p.profile_type = 'constructionTeam' AND EXISTS (
          SELECT 1 FROM construction_team_services cts
          JOIN construction_team_profiles ctp ON cts.construction_team_profile_id = ctp.id
          WHERE ctp.profile_id = p.id AND cts.service_type = ANY(service_type_filter)
        )
      ))
      
      -- Filter by supplier type
      AND (supplier_type_filter IS NULL OR (
        p.profile_type = 'supplier' AND EXISTS (
          SELECT 1 FROM supplier_profiles sp
          WHERE sp.profile_id = p.id AND sp.supplier_type = ANY(supplier_type_filter)
        )
      ))
      
      -- Filter by material category for suppliers
      AND (material_category_filter IS NULL OR (
        p.profile_type = 'supplier' AND EXISTS (
          SELECT 1 FROM supplier_material_categories smc
          JOIN supplier_profiles sp ON smc.supplier_profile_id = sp.id
          WHERE sp.profile_id = p.id AND smc.material_category = ANY(material_category_filter)
        )
      ))
  )
  
  SELECT *
  FROM filtered_profiles
  ORDER BY average_rating DESC NULLS LAST, display_name ASC
  LIMIT limit_val
  OFFSET offset_val;
$$; 