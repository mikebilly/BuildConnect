-- Enum for supplier types
CREATE TYPE supplier_type AS ENUM (
  'enterprise',
  'distributor',
  'retailStore',
  'individual',
  'reseller',
  'manufacturer',
  'brand'
); 