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
