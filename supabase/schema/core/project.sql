-- Projects table
CREATE TABLE IF NOT EXISTS projects (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  profile_id UUID NOT NULL,
  project_role project_role NOT NULL,
  location_id UUID,
  project_status project_status DEFAULT 'ongoing',
  start_date DATE,
  end_date DATE,
  budget DECIMAL(15,2),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  
  CONSTRAINT fk_profile
    FOREIGN KEY(profile_id)
    REFERENCES profiles(id)
    ON DELETE CASCADE,
    
  CONSTRAINT fk_location
    FOREIGN KEY(location_id)
    REFERENCES locations(id)
    ON DELETE SET NULL
);

-- Create indexes for faster lookups
CREATE INDEX IF NOT EXISTS projects_profile_id_idx ON projects(profile_id);
CREATE INDEX IF NOT EXISTS projects_location_id_idx ON projects(location_id);
CREATE INDEX IF NOT EXISTS projects_project_status_idx ON projects(project_status);
CREATE INDEX IF NOT EXISTS projects_project_role_idx ON projects(project_role);

-- Enable Row Level Security
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Projects are viewable by everyone" ON projects
  FOR SELECT USING (true);
  
CREATE POLICY "Users can create projects for their profiles" ON projects
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = projects.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );
  
CREATE POLICY "Users can update their own projects" ON projects
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = projects.profile_id 
      AND profiles.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete their own projects" ON projects
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = projects.profile_id 
      AND profiles.user_id = auth.uid()
    )
  ); 