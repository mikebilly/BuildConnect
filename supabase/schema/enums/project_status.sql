-- Enum for project statuses
CREATE TYPE project_status AS ENUM (
  'ongoing',
  'completed',
  'cancelled'
); 