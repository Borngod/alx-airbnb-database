
DROP TABLE IF EXISTS booking CASCADE;

-- Step 2: Create the partitioned booking table
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
    CHECK (end_date > start_date)
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions for different date ranges
-- Create partitions for bookings from 2020 to 2022
CREATE TABLE booking_2020_2022 PARTITION OF booking
    FOR VALUES FROM ('2020-01-01') TO ('2023-01-01');

-- Create partitions for bookings from 2023 to 2024
CREATE TABLE booking_2023_2024 PARTITION OF booking
    FOR VALUES FROM ('2023-01-01') TO ('2025-01-01');

-- Create partitions for bookings from 2025 onwards
CREATE TABLE booking_2025_onwards PARTITION OF booking
    FOR VALUES FROM ('2025-01-01') TO ('9999-12-31');


-- Query to fetch bookings in the year 2023
EXPLAIN ANALYZE 
SELECT 
    booking_id, 
    start_date, 
    end_date, 
    total_price 
FROM 
    booking 
WHERE 
    start_date BETWEEN '2023-01-01' AND '2023-12-31';

