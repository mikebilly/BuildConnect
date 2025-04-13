-- Payment terms table
CREATE TABLE IF NOT EXISTS payment_terms (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  deposit_required BOOLEAN DEFAULT false,
  deposit_amount DECIMAL(10,2),
  installments BOOLEAN DEFAULT false,
  payment_schedule TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Payment methods linking table
CREATE TABLE IF NOT EXISTS profile_payment_methods (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  payment_method payment_method NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  UNIQUE(profile_id, payment_method)
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS payment_terms_profile_id_idx ON payment_terms(profile_id);
CREATE INDEX IF NOT EXISTS profile_payment_methods_profile_id_idx ON profile_payment_methods(profile_id); 