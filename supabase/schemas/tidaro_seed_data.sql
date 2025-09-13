-- ============================================================================
-- TIDARO SEED DATA FOR TESTING
-- Version: 2.0
-- Description: Test data for development and staging environments
-- Architecture: Clean Architecture with DRY principles
-- ============================================================================

-- Note: This seed data is for testing purposes only
-- Do not use in production environment

-- ============================================================================
-- TEST USERS AND PROFILES
-- ============================================================================

-- Insert test users (assuming auth.users are created via Supabase Auth)
-- These IDs should match the auth.users table
INSERT INTO public.users (id, email, phone_number, role, status, verification_status, kyc_level, metadata) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'john.client@test.com', '+1234567890', 'client', 'active', 'verified', 'basic', '{"test_user": true}'),
('550e8400-e29b-41d4-a716-446655440002', 'jane.pro@test.com', '+1234567891', 'professional', 'active', 'verified', 'enhanced', '{"test_user": true}'),
('550e8400-e29b-41d4-a716-446655440003', 'mike.professional@test.com', '+1234567892', 'professional', 'active', 'verified', 'basic', '{"test_user": true}'),
('550e8400-e29b-41d4-a716-446655440004', 'sarah.client@test.com', '+1234567893', 'client', 'active', 'pending', 'none', '{"test_user": true}'),
('550e8400-e29b-41d4-a716-446655440005', 'admin@test.com', '+1234567894', 'admin', 'active', 'verified', 'premium', '{"test_user": true}');

-- Insert user profiles
INSERT INTO public.user_profiles (id, user_id, profile_type, email, full_name, phone, is_public, is_verified) VALUES
('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'client', 'john.client@test.com', 'John Doe', '+1234567890', true, true),
('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'professional', 'jane.pro@test.com', 'Jane Smith', '+1234567891', true, true),
('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', 'professional', 'mike.professional@test.com', 'Mike Johnson', '+1234567892', true, true),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', 'client', 'sarah.client@test.com', 'Sarah Wilson', '+1234567893', false, false);

-- Insert client profiles
INSERT INTO public.client_profiles (user_profile_id, bio, date_of_birth, gender, occupation, preferences) VALUES
('650e8400-e29b-41d4-a716-446655440001', 'Busy professional looking for reliable home services', '1985-06-15', 'male', 'Software Engineer', '{"preferred_time": "evening", "communication": "text"}'),
('650e8400-e29b-41d4-a716-446655440004', 'New to the platform, excited to try services', '1992-03-22', 'female', 'Marketing Manager', '{"preferred_time": "weekend", "communication": "call"}');

-- Insert professional profiles
INSERT INTO public.professional_profiles (user_profile_id, business_name, bio, years_of_experience, hourly_rate, service_radius_km, rating, total_reviews, availability_status, skills, certifications, languages) VALUES
('650e8400-e29b-41d4-a716-446655440002', 'Jane''s Home Services', 'Professional professional with 8 years of experience', 8, 35.00, 25, 4.8, 127, 'available', '{"deep cleaning", "eco-friendly products", "pet-friendly"}', '{"Certified Professional Professional", "Green Cleaning Specialist"}', '{"English", "Spanish"}'),
('650e8400-e29b-41d4-a716-446655440003', 'Mike''s Maintenance', 'Handyman and maintenance specialist', 5, 45.00, 15, 4.6, 89, 'available', '{"plumbing", "electrical", "carpentry", "painting"}', '{"Licensed Electrician", "Plumbing Certification"}', '{"English"}');

-- ============================================================================
-- TEST ADDRESSES
-- ============================================================================

INSERT INTO public.addresses (id, user_id, type, street_address, apartment_unit, city, state_province, postal_code, country, special_instructions, is_default) VALUES
('750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'home', '123 Main St', 'Apt 4B', 'San Francisco', 'CA', '94102', 'US', 'Ring doorbell twice, dog friendly', true),
('750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'work', '456 Business Ave', 'Suite 200', 'San Francisco', 'CA', '94105', 'US', 'Reception on 2nd floor', false),
('750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440004', 'home', '789 Oak Street', NULL, 'Oakland', 'CA', '94601', 'US', 'Gate code: 1234', true);

-- ============================================================================
-- TEST SERVICES
-- ============================================================================

INSERT INTO public.services (id, professional_id, category, name, description, base_price, rate_type, estimated_duration_minutes, tasks, requirements, is_active) VALUES
('850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'cleaning', 'Standard House Cleaning', 'Complete house cleaning including all rooms, bathrooms, and kitchen', 120.00, 'fixed', 180, '{"vacuum all rooms", "mop floors", "clean bathrooms", "kitchen cleaning", "dust surfaces"}', '{"access to home", "cleaning supplies provided"}', true),
('850e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'cleaning', 'Deep Cleaning Service', 'Thorough deep cleaning for move-in/move-out or seasonal cleaning', 200.00, 'fixed', 300, '{"detailed cleaning", "inside appliances", "baseboards", "light fixtures", "window sills"}', '{"empty or minimal furniture", "4+ hour time block"}', true),
('850e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', 'maintenance', 'Basic Handyman Services', 'General home repairs and maintenance tasks', 45.00, 'hourly', 60, '{"minor repairs", "furniture assembly", "picture hanging", "basic plumbing"}', '{"access to work area", "basic tools provided"}', true),
('850e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', 'maintenance', 'Electrical Work', 'Licensed electrical repairs and installations', 75.00, 'hourly', 120, '{"outlet installation", "light fixture repair", "electrical troubleshooting"}', '{"licensed work only", "permit may be required"}', true);

-- ============================================================================
-- TEST BOOKINGS
-- ============================================================================

INSERT INTO public.bookings (id, client_id, professional_id, service_id, address_id, status, scheduled_date, start_time, end_time, duration_minutes, total_price, payment_status, special_instructions) VALUES
('950e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 'completed', '2024-01-15', '09:00:00', '12:00:00', 180, 120.00, 'paid', 'Please focus on kitchen and bathrooms'),
('950e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', '850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', 'confirmed', '2024-01-25', '14:00:00', '16:00:00', 120, 90.00, 'pending', 'Need help assembling IKEA furniture'),
('950e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', 'pending', '2024-02-01', '10:00:00', '15:00:00', 300, 200.00, 'pending', 'Moving out, need thorough cleaning');

-- ============================================================================
-- TEST PAYMENTS
-- ============================================================================

INSERT INTO public.payments (id, booking_id, payer_id, payee_id, amount, platform_fee, payment_method, status, transaction_id) VALUES
('b50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 120.00, 12.00, 'credit_card', 'completed', 'txn_test_001'),
('b50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', 90.00, 9.00, 'paypal', 'pending', 'txn_test_002');

-- ============================================================================
-- TEST REVIEWS
-- ============================================================================

INSERT INTO public.reviews (id, booking_id, reviewer_id, reviewee_id, overall_rating, aspect_ratings, comment, is_verified) VALUES
('c50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 5, '{"punctuality": 5, "quality": 5, "communication": 4, "value": 5}', 'Excellent service! Jane was punctual, thorough, and very professional. My house has never been professional. Highly recommend!', true),
('c50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 4, '{"communication": 4, "respect": 5, "clarity": 4}', 'John was clear about his expectations and very respectful. Easy to work with!', true);

-- ============================================================================
-- TEST CHATS AND MESSAGES
-- ============================================================================

INSERT INTO public.chats (id, booking_id, created_by, last_message_at, unread_count) VALUES
('d50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '2024-01-15 08:30:00+00', 0),
('d50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', '2024-01-24 16:45:00+00', 1);

INSERT INTO public.chat_members (id, chat_id, user_id, role) VALUES
('e50e8400-e29b-41d4-a716-446655440001', 'd50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'member'),
('e50e8400-e29b-41d4-a716-446655440002', 'd50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'member'),
('e50e8400-e29b-41d4-a716-446655440003', 'd50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', 'member'),
('e50e8400-e29b-41d4-a716-446655440004', 'd50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', 'member');

INSERT INTO public.messages (id, chat_id, sender_id, message_type, content, status) VALUES
('f50e8400-e29b-41d4-a716-446655440001', 'd50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'text', 'Hi Jane! Looking forward to the cleaning service tomorrow. Is there anything specific I should prepare?', 'read'),
('f50e8400-e29b-41d4-a716-446655440002', 'd50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'text', 'Hi John! Just make sure I have access and clear any valuable items. I''ll bring all supplies. See you at 9 AM!', 'read'),
('f50e8400-e29b-41d4-a716-446655440003', 'd50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', 'text', 'Hi Mike! I have several IKEA boxes that need assembly. Can you help this weekend?', 'read'),
('f50e8400-e29b-41d4-a716-446655440004', 'd50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', 'text', 'Absolutely! I''m available Saturday afternoon. I''ll bring my tools.', 'delivered');

-- ============================================================================
-- TEST NOTIFICATIONS
-- ============================================================================

INSERT INTO public.notifications (id, user_id, type, title, message, data, is_read) VALUES
('g50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'booking_confirmed', 'Booking Confirmed', 'Your cleaning service with Jane Smith has been confirmed for Jan 15th at 9:00 AM', '{"booking_id": "950e8400-e29b-41d4-a716-446655440001"}', true),
('g50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'new_booking', 'New Booking Request', 'You have a new booking request from John Doe for house cleaning', '{"booking_id": "950e8400-e29b-41d4-a716-446655440001"}', true),
('g50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', 'review_reminder', 'Review Reminder', 'Please leave a review for your recent cleaning service with Jane Smith', '{"booking_id": "950e8400-e29b-41d4-a716-446655440001"}', false);

COMMENT ON TABLE public.users IS 'Test data loaded for TiDaro platform development and testing';
