-- Ratings information table
CREATE TABLE IF NOT EXISTS ratings_info (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID NOT NULL UNIQUE,
  average_rating DECIMAL(2,1) DEFAULT 0 CHECK (average_rating >= 0 AND average_rating <= 5),
  total_reviews INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS ratings_info_profile_id_idx ON ratings_info(profile_id);

-- Function to update average rating when a new review is added
CREATE OR REPLACE FUNCTION update_ratings_info()
RETURNS TRIGGER AS $$
BEGIN
  -- Update the average rating and total reviews
  UPDATE ratings_info
  SET 
    average_rating = (
      SELECT COALESCE(AVG(rating), 0)
      FROM reviews
      WHERE profile_id = NEW.profile_id
    ),
    total_reviews = (
      SELECT COUNT(*)
      FROM reviews
      WHERE profile_id = NEW.profile_id
    ),
    updated_at = NOW()
  WHERE profile_id = NEW.profile_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update ratings info
CREATE TRIGGER update_ratings_after_review
AFTER INSERT OR UPDATE OR DELETE ON reviews
FOR EACH ROW
EXECUTE FUNCTION update_ratings_info(); 