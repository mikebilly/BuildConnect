-- Drop in reverse dependency order (sub-tables first)
DROP TABLE IF EXISTS profile_payment_methods;
DROP TABLE IF EXISTS profile_contacts;
DROP TABLE IF EXISTS profile_domains;
DROP TABLE IF EXISTS profiles;

-- Main Profile table
CREATE TABLE profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL,
  profile_type profile_type NOT NULL,
  bio TEXT NOT NULL,
  availability_status availability_status NOT NULL,
  years_of_experience INTEGER NOT NULL,
  working_mode working_mode NOT NULL,
  business_entity_type business_entity_type NOT NULL
);

-- Profile Domains (many-to-many)
CREATE TABLE profile_domains (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  domain domain NOT NULL,
  UNIQUE(profile_id, domain)
);

-- Profile Contacts (one-to-many)
CREATE TABLE profile_contacts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  contact contact NOT NULL
);

-- Profile Payment Methods (many-to-many)
CREATE TABLE profile_payment_methods (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  payment_method payment_method NOT NULL,
  UNIQUE(profile_id, payment_method)
);

DROP INDEX IF EXISTS profiles_user_id_idx;
DROP INDEX IF EXISTS profiles_profile_type_idx;

CREATE INDEX profiles_user_id_idx ON profiles(user_id);
CREATE INDEX profiles_profile_type_idx ON profiles(profile_type);