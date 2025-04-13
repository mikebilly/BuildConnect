-- Enum for business entity types
CREATE TYPE business_entity_type AS ENUM (
  'individual',
  'householdBusiness',
  'companyLimited',
  'jointStockCompany',
  'partnershipCompany',
  'stateOwnedEnterprise',
  'foreignEnterprise'
); 