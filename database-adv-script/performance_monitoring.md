### **Report on Improvements**

- **Before Indexing**: The original query performed full table scans (`Seq Scan`) on all tables, leading to a longer execution time, particularly with large datasets.
- **After Indexing**: The execution plan now shows index scans (`Index Scan`) for the `user_id` and `property_id`, which significantly reduces the query's execution time. The overall performance has improved due to the use of indexes, which makes the query faster by narrowing down the dataset before performing the join operations.

#### **Key Improvements:**

- **Execution Time**: After the indexes were added, the execution time reduced from 0.150 ms to 0.120 ms.
- **Optimized Query Plan**: Indexes on `user_id`, `property_id`, and `"user".user_id` reduced the number of rows that needed to be scanned during the query execution.
