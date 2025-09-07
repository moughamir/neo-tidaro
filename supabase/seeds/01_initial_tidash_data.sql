-- Initial seed data for TiDash application
-- This file populates the database with sample data for development and testing

-- Insert sample dashboard metrics
INSERT INTO public.dashboard_metrics (metric_name, metric_value, metric_change, metric_type) VALUES
('total_users', 1250, 12.5, 'count'),
('active_users', 892, 8.3, 'count'),
('revenue', 45780.50, 15.2, 'currency'),
('total_orders', 324, -2.1, 'count'),
('conversion_rate', 3.2, 0.5, 'percentage'),
('avg_order_value', 141.30, 5.8, 'currency');

-- Insert sample activities (these will be created automatically when users perform actions)
-- We'll insert some system activities for demonstration
INSERT INTO public.activities (user_id, activity_type, title, description, icon, metadata) VALUES
-- System activities (no user_id for system events)
(NULL, 'system', 'Database Migration', 'Initial TiDash schema migration completed', 'database', '{"version": "20250106000000"}'),
(NULL, 'system', 'Metrics Updated', 'Dashboard metrics refreshed automatically', 'refresh', '{"timestamp": "2025-01-06T10:00:00Z"}'),
(NULL, 'system', 'Backup Created', 'Daily database backup completed successfully', 'shield', '{"size": "2.3MB"}');

-- Insert sample notification templates (these will be user-specific when created)
-- For now, we'll create system notifications
-- Note: These will need user_id when actual users exist

-- Create a sample admin user profile (this would normally be created via the trigger)
-- We'll insert this manually for development purposes
-- Note: This assumes you have a user with this ID in auth.users
-- You should replace this UUID with an actual user ID from your auth system

-- Sample booking statuses for reference
-- INSERT INTO public.bookings (user_id, service_name, booking_date, status, customer_name, customer_email, total_amount) VALUES
-- These will be created when actual bookings are made

-- Create some sample service categories or types that can be referenced
-- You might want to create a services table later for this
-- For now, we'll just ensure the metrics are populated

-- Update metrics with more realistic sample data
UPDATE public.dashboard_metrics SET 
    updated_at = NOW() - INTERVAL '1 hour'
WHERE metric_name IN ('total_users', 'active_users');

UPDATE public.dashboard_metrics SET 
    updated_at = NOW() - INTERVAL '30 minutes'
WHERE metric_name IN ('revenue', 'total_orders');

-- Add some historical metric variations (you might want to create a metrics_history table later)
-- For now, this gives us baseline data to work with
