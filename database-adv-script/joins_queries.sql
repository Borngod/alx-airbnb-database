SELECT bookings.booking_id, bookings.property_id, bookings.booking_date, users.user_id, users.user_name
FROM bookings
INNER JOIN users ON bookings.user_id = users.user_id;


SELECT 
    p.property_id, 
    p.name AS property_name,
    p.description,
    r.review_id, 
    r.rating, 
    r.comment
FROM 
    property p
LEFT JOIN 
    review r ON p.property_id = r.property_id
ORDER BY 
    p.property_id, r.review_id;


SELECT 
    u.user_id, 
    u.first_name, 
    u.last_name,
    b.booking_id, 
    b.start_date, 
    b.end_date,
    CASE 
        WHEN b.booking_id IS NULL THEN 'No Booking'
        WHEN u.user_id IS NULL THEN 'Booking without User'
        ELSE 'Booked'
    END AS booking_status
FROM 
    "user" u
FULL OUTER JOIN 
    booking b ON u.user_id = b.user_id
ORDER BY 
    u.user_id, b.booking_id;
