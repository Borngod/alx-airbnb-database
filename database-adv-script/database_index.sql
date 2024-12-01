-- User Table Indexes
CREATE INDEX idx_user_user_id ON "user"(user_id);
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role_id ON "user"(role_id);

-- Booking Table Indexes
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_status_id ON booking(status_id);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);

-- Property Table Indexes
CREATE INDEX idx_property_property_id ON property(property_id);
CREATE INDEX idx_property_host_id ON property(host_id);
CREATE INDEX idx_property_price ON property(price_per_night);

-- Query to analyze
SELECT 
    u.user_id, 
    u.first_name, 
    COUNT(b.booking_id) AS total_bookings
FROM 
    "user" u
LEFT JOIN 
    booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name
ORDER BY 
    total_bookings DESC;

-- Analyze performance
EXPLAIN ANALYZE SELECT 
    u.user_id, 
    u.first_name, 
    COUNT(b.booking_id) AS total_bookings
FROM 
    "user" u
LEFT JOIN 
    booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name
ORDER BY 
    total_bookings DESC;
