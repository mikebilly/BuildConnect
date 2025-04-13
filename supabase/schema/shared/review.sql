-- Reviews table
CREATE TABLE IF NOT EXISTS reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL,
  reviewer_id UUID NOT NULL,
  rating DECIMAL(2,1) NOT NULL CHECK (rating >= 0 AND rating <= 5),
  comment TEXT,
  review_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_reviewer
    FOREIGN KEY(reviewer_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS reviews_profile_id_idx ON reviews(profile_id);
CREATE INDEX IF NOT EXISTS reviews_reviewer_id_idx ON reviews(reviewer_id); 