-- Insert initial user roles
INSERT INTO user_role (role_name, description) VALUES 
    ('guest', 'Regular user who can book properties'),
    ('host', 'User who can list and manage properties'),
    ('admin', 'Platform administrator with full access');

-- Insert initial property types
INSERT INTO property_type (name, description) VALUES 
    ('apartment', 'Apartment in a residential building'),
    ('house', 'Entire house or home'),
    ('room', 'Private room in a shared space'),
    ('villa', 'Luxury villa'),
    ('cottage', 'Countryside cottage');

-- Insert initial booking statuses
INSERT INTO booking_status (status_name, description) VALUES 
    ('pending', 'Booking is awaiting confirmation'),
    ('confirmed', 'Booking is confirmed'),
    ('canceled', 'Booking has been canceled');

-- Insert initial payment methods
INSERT INTO payment_method (method_name, description) VALUES 
    ('credit_card', 'Payment via credit card'),
    ('paypal', 'Payment via PayPal'),
    ('stripe', 'Payment via Stripe');
