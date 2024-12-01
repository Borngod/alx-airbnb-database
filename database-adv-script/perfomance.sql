-- Initial Query to retrieve bookings along with user, property, and payment details
SELECT 
    b.booking_id, 
    b.start_date, 
    b.end_date, 
    b.total_price AS booking_total_price,
    u.user_id, 
    u.first_name, 
    u.last_name, 
    u.email, 
    p.property_id, 
    p.name AS property_name, 
    p.price_per_night, 
    p.max_guests, 
    pay.payment_id, 
    pay.amount AS payment_amount, 
    pay.payment_date 
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
JOIN 
    payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC;

EXPLAIN ANALYZE
SELECT 
    b.booking_id, 
    b.start_date, 
    b.end_date, 
    b.total_price AS booking_total_price,
    u.user_id, 
    u.first_name, 
    u.last_name, 
    u.email, 
    p.property_id, 
    p.name AS property_name, 
    p.price_per_night, 
    p.max_guests, 
    pay.payment_id, 
    pay.amount AS payment_amount, 
    pay.payment_date 
FROM 
    booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
JOIN 
    payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC;
