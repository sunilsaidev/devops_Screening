# devops_Screening

Tiered storage: hot (Cosmos <3 mo), cold (Blob + index)
No downtime, no contract changes — API fallback handles retrieval
Simple to deploy, maintainable code
Robust: handles failures, duplicates, and growth gracefully
Record Retrieval Logic (Hot & Cold Path)
When a billing record is requested (via API), the system transparently retrieves it from either:

 1. Hot Path (Cosmos DB)
The system first checks Cosmos DB, where recent (active) billing records are stored.

If the record exists in Cosmos DB, it is returned immediately.

This path is fast and optimized for frequently accessed data.

2. Cold Path (Blob Storage via Table Index)
If the record is not found in Cosmos DB, it is likely an archived record.

The system then looks up the Azure Table Storage index using the billing record ID.

If an index entry is found, it provides the location of the archived record in Azure Blob Storage.

The system downloads the archived JSON file from Blob Storage, parses it, and returns it just like any live record.

3. Record Not Found
If the record is not found in Cosmos DB or in the Table Storage index, the system responds with a “record not found” error (typically HTTP 404).

Benefits of This Design
No Changes to Your API: The calling application doesn't need to know where the record is stored. The same endpoint serves both hot and cold data.

Cost-Optimized: Frequently accessed records stay in Cosmos DB (high-performance), while older data is moved to cheaper Blob Storage.

Scalable and Seamless: This logic ensures a smooth experience regardless of how old or where the data resides
