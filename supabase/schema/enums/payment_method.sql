-- Enum for payment methods
CREATE TYPE payment_method AS ENUM (
  'cod',
  'bankTransfer',
  'installment'
); 