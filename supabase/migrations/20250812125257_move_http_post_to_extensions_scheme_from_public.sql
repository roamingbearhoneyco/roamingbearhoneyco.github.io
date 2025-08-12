-- Create the extensions schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS extensions;

-- Drop the http extension if it exists in public
DROP EXTENSION IF EXISTS http;

-- Recreate the http extension in the extensions schema
CREATE EXTENSION IF NOT EXISTS http SCHEMA extensions;
