-- Schema orchestration file for BuildConnect
-- This file imports all SQL schema files in the correct order

-- Enums (need to be created first)
\ir 'schema/enums/architect_role.sql'
\ir 'schema/enums/business_entity_type.sql'
\ir 'schema/enums/design_style.sql'
\ir 'schema/enums/domain.sql'
\ir 'schema/enums/material_category.sql'
\ir 'schema/enums/payment_method.sql'
\ir 'schema/enums/profile_type.sql'
\ir 'schema/enums/project_role.sql'
\ir 'schema/enums/project_status.sql'
\ir 'schema/enums/service_type.sql'
\ir 'schema/enums/supplier_type.sql'
\ir 'schema/enums/working_mode.sql'

-- Shared types/tables
\ir 'schema/shared/certification.sql'
\ir 'schema/shared/contact_info.sql'
\ir 'schema/shared/education.sql'
\ir 'schema/shared/equipment.sql'
\ir 'schema/shared/legal.sql'
\ir 'schema/shared/location.sql'
\ir 'schema/shared/media.sql'
\ir 'schema/shared/payment_terms.sql'
\ir 'schema/shared/ratings_info.sql'
\ir 'schema/shared/representative.sql'
\ir 'schema/shared/review.sql'
\ir 'schema/shared/social.sql'
\ir 'schema/shared/verification_info.sql'
\ir 'schema/shared/warranty.sql'

-- Core tables
\ir 'schema/core/user.sql'
\ir 'schema/core/profile.sql'
\ir 'schema/core/project.sql'

-- Profile subtypes
\ir 'schema/sub_profiles/architect_profile.sql'
\ir 'schema/sub_profiles/construction_team_profile.sql'
\ir 'schema/sub_profiles/contractor_profile.sql'
\ir 'schema/sub_profiles/supplier_profile.sql'

-- Functions
\ir 'schema/functions/search_profile.sql'

-- Policies (RLS)
\ir 'schema/policies/auth_policies.sql'

-- Seed data
\ir 'schema/seed/seed_data.sql' 