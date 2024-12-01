

# Database Normalization Analysis

## Initial Schema Assessment

### 1. First Normal Form (1NF) Compliance
The initial schema mostly complies with 1NF requirements:
- Each table has a primary key (UUID)
- Atomic values in columns
- No repeating groups

### 2. Second Normal Form (2NF) Compliance
The schema is already in 2NF as:
- All tables have a single-column primary key
- Non-key attributes fully depend on the primary key

### 3. Third Normal Form (3NF) Analysis

#### Potential Denormalization Issues
1. **User Table**: No immediate 3NF violations detected
2. **Property Table**: Potential issue with derived attributes
   - `total_bookings` (if added) would violate 3NF
   - Recommendation: Remove calculated fields, compute dynamically

3. **Booking Table**: Minor optimization possible
   - `total_price` could be a calculated field based on:
     - `Property.price_per_night`
     - Booking duration (`start_date` to `end_date`)

#### Proposed Normalization Improvements

##### 1. Property Metadata Extraction
Created a separate `PropertyType` table to handle potential categorical data:

```sql
CREATE TABLE PropertyType (
    property_type_id UUID PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

ALTER TABLE Property 
ADD COLUMN property_type_id UUID REFERENCES PropertyType(property_type_id);
```

##### 2. Address Normalization
Split location into more granular components:

```sql
CREATE TABLE Address (
    address_id UUID PRIMARY KEY,
    street_address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20)
);

ALTER TABLE Property 
ADD COLUMN address_id UUID REFERENCES Address(address_id);
```

##### 3. Payment Method Normalization
Created a separate table for payment method details:

```sql
CREATE TABLE PaymentMethod (
    payment_method_id UUID PRIMARY KEY,
    method_name ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    description TEXT
);

ALTER TABLE Payment 
ADD COLUMN payment_method_id UUID REFERENCES PaymentMethod(payment_method_id);
```

## Normalization Principles Applied

### Transitive Dependency Elimination
- Removed potential calculated fields
- Separated categorical and metadata information
- Ensured each non-key column depends directly on the primary key

### Functional Dependency Analysis
- Verified that non-key attributes depend only on the primary key
- Eliminated indirect dependencies
- Created separate tables for metadata and categorical information

## Normalized Table 

![Untitled diagram-2024-12-01-115534](https://github.com/user-attachments/assets/20fd2ce4-5edc-477c-9368-33f62e0cbf28)
