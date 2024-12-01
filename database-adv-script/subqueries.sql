SELECT 
    p.property_id,
    p.name,
    p.description,
    p.price_per_night,
    (SELECT AVG(rating) 
     FROM review r 
     WHERE r.property_id = p.property_id) AS average_rating
FROM 
    property p
WHERE 
    (SELECT AVG(rating) 
     FROM review r 
     WHERE r.property_id = p.property_id) > 4.0
ORDER BY 
    average_rating DESC;


SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (SELECT COUNT(*) 
     FROM booking b 
     WHERE b.user_id = u.user_id) AS total_bookings
FROM 
    "user" u
WHERE 
    (SELECT COUNT(*) 
     FROM booking b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    total_bookings DESC;
