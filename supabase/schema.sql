-- Schema orchestration file for BuildConnect
-- This file imports all SQL schema files in the correct order

-- Enums (need to be created first)
'schema/enums/architect_role.sql'
'schema/enums/business_entity_type.sql'
'schema/enums/design_style.sql'
'schema/enums/domain.sql'
'schema/enums/material_category.sql'
'schema/enums/payment_method.sql'
'schema/enums/profile_type.sql'
'schema/enums/project_role.sql'
'schema/enums/project_status.sql'
'schema/enums/service_type.sql'
'schema/enums/supplier_type.sql'
'schema/enums/working_mode.sql'

'schema/core/user.sql'
'schema/core/profile.sql'
'schema/shared/location.sql'
'schema/core/project.sql'
'schema/shared/media.sql'

-- Shared types/tables
'schema/shared/certification.sql'
'schema/shared/contact_info.sql'
'schema/shared/education.sql'
'schema/shared/equipment.sql'
'schema/shared/legal.sql'


'schema/shared/payment_terms.sql'
'schema/shared/review.sql'
'schema/shared/ratings_info.sql'
'schema/shared/representative.sql'

'schema/shared/social.sql'
'schema/shared/verification_info.sql'
'schema/shared/warranty.sql'

-- Core tables

-- Profile subtypes
'schema/sub_profiles/architect_profile.sql'
'schema/sub_profiles/construction_team_profile.sql'
'schema/sub_profiles/contractor_profile.sql'
'schema/sub_profiles/supplier_profile.sql'

-- Functions
'schema/functions/search_profile.sql'

-- Policies (RLS)
'schema/policies/auth_policies.sql'