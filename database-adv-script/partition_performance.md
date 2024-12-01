After partitioning the `Booking` table, the observed performance improvements include:

- **Faster query execution**: Queries that filter on `start_date`, such as fetching bookings within a specific year or date range, saw significant performance improvements. PostgreSQL was able to quickly access only the relevant partitions, reducing the total amount of data that needed to be scanned.
- **Improved scalability**: As the `Booking` table grows over time, partitioning ensures that queries continue to perform well, even with a large number of records. This makes the system more scalable for future growth.
- **Reduced I/O**: By partitioning the data, the system reduces unnecessary I/O by eliminating full table scans and only scanning the partitions that match the query's `start_date` filter.
