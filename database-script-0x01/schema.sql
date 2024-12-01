-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enum Types
CREATE TYPE user_role_enum AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status_enum AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_enum AS ENUM ('credit_card', 'paypal', 'stripe');

-- Address Table
CREATE TABLE address (
    address_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create an index on address fields for faster lookups
CREATE INDEX idx_address_city ON address(city);
CREATE INDEX idx_address_country ON address(country);

-- User Roles Table
CREATE TABLE user_role (
    role_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role_name user_role_enum NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(role_name)
);

-- Users Table
CREATE TABLE "user" (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role_id UUID NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP WITH TIME ZONE,
    
    FOREIGN KEY (role_id) REFERENCES user_role(role_id)
);

-- Create indexes for user table
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_user_role ON "user"(role_id);

-- Property Types Table
CREATE TABLE property_type (
    property_type_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Properties Table
CREATE TABLE property (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL,
    property_type_id UUID NOT NULL,
    address_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night > 0),
    max_guests INTEGER NOT NULL CHECK (max_guests > 0),
    bedrooms INTEGER NOT NULL CHECK (bedrooms > 0),
    bathrooms DECIMAL(3, 1) NOT NULL CHECK (bathrooms > 0),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (host_id) REFERENCES "user"(user_id),
    FOREIGN KEY (property_type_id) REFERENCES property_type(property_type_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Create indexes for property table
CREATE INDEX idx_property_host ON property(host_id);
CREATE INDEX idx_property_type ON property(property_type_id);
CREATE INDEX idx_property_price ON property(price_per_night);

-- Booking Status Table
CREATE TABLE booking_status (
    status_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    status_name booking_status_enum NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(status_name)
);

-- Bookings Table
CREATE TABLE booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    status_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    total_guests INTEGER NOT NULL CHECK (total_guests > 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    FOREIGN KEY (status_id) REFERENCES booking_status(status_id),
    
    -- Ensure end date is after start date
    CHECK (end_date > start_date)
);

-- Create indexes for booking table
CREATE INDEX idx_booking_property ON booking(property_id);
CREATE INDEX idx_booking_user ON booking(user_id);
CREATE INDEX idx_booking_status ON booking(status_id);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);

-- Payment Method Table
CREATE TABLE payment_method (
    payment_method_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    method_name payment_method_enum NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(method_name)
);

-- Payments Table
CREATE TABLE payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL UNIQUE,
    payment_method_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    transaction_id VARCHAR(255),
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

-- Create indexes for payment table
CREATE INDEX idx_payment_booking ON payment(booking_id);
CREATE INDEX idx_payment_method ON payment(payment_method_id);

-- Reviews Table
CREATE TABLE review (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    
    -- Ensure a user can only review a property once
    UNIQUE(property_id, user_id)
);

-- Create indexes for review table
CREATE INDEX idx_review_property ON review(property_id);
CREATE INDEX idx_review_user ON review(user_id);
CREATE INDEX idx_review_rating ON review(rating);

-- Messages Table
CREATE TABLE message (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (sender_id) REFERENCES "user"(user_id),
    FOREIGN KEY (recipient_id) REFERENCES "user"(user_id),
    
    -- Prevent sending a message to oneself
    CHECK (sender_id != recipient_id)
);

-- Create indexes for message table
CREATE INDEX idx_message_sender ON message(sender_id);
CREATE INDEX idx_message_recipient ON message(recipient_id);
CREATE INDEX idx_message_sent_at ON message(sent_at);
