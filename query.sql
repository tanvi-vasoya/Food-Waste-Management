# SQL query functions will go here
SQL_QUERIES = {
    # 1. Total Providers
    "total_providers": "SELECT COUNT(*) AS Total FROM providers;",

    # 2. Total Receivers
    "total_receivers": "SELECT COUNT(*) AS Total FROM receivers;",

    # 3. Total Food Listings
    "total_food_listings": "SELECT COUNT(*) AS Total FROM food_listings;",

    # 4. Total Claims
    "total_claims": "SELECT COUNT(*) AS Total FROM claims;",

    # 5. Top 5 Providers by Donations
    "top_5_providers": """
        SELECT p.Provider_Name AS name, COUNT(f.Food_ID) AS total_donations
        FROM providers p
        JOIN food_listings f ON p.Provider_ID = f.Provider_ID
        GROUP BY p.Provider_Name
        ORDER BY total_donations DESC
        LIMIT 5;
    """,

    # 6. Claims by Status
    "claims_by_status": """
        SELECT Status, COUNT(*) AS Count
        FROM claims
        GROUP BY Status;
    """,

    # 7. Available vs Expired Food
    "available_vs_expired": """
        SELECT 
            CASE WHEN date(Expiry_Date) >= date('now') THEN 'Available'
                 ELSE 'Expired'
            END AS food_status,
            COUNT(*) AS Count
        FROM food_listings
        GROUP BY food_status;
    """,

    # 8. Food Listings by Category
    "food_listings_by_category": """
        SELECT Category, COUNT(*) AS Count
        FROM food_listings
        GROUP BY Category;
    """,

    # 9. Monthly Claims Trend (Fixed for Timestamp column)

"monthly_claims_trend": """
    SELECT 
      CASE 
        WHEN instr(Timestamp,'-') > 0 
          THEN substr(Timestamp,7,4) || '-' || substr(Timestamp,1,2)          -- e.g. 03-05-2025 ...
        WHEN instr(Timestamp,'/') > 0 
          THEN substr(Timestamp,-4) || '-' || printf('%02d', CAST(substr(Timestamp,1,instr(Timestamp,'/')-1) AS INT))  -- e.g. 3/21/2025 ...
        ELSE 'Unknown'
      END AS Month,
      COUNT(*) AS Count
    FROM claims
    GROUP BY Month
    ORDER BY Month;
""",



    # 10. Providers by Type
    "providers_by_type": """
        SELECT Provider_Type, COUNT(*) AS Count
        FROM providers
        GROUP BY Provider_Type;
    """,

    # 11. Receivers by Type
    "receivers_by_type": """
        SELECT Receiver_Type, COUNT(*) AS Count
        FROM receivers
        GROUP BY Receiver_Type;
    """,

    # 12. Most Claimed Food Items
    "most_claimed_food_items": """
        SELECT f.Food_Name AS name, COUNT(c.Claim_ID) AS claim_count
        FROM food_listings f
        JOIN claims c ON f.Food_ID = c.Food_ID
        GROUP BY f.Food_Name
        ORDER BY claim_count DESC
        LIMIT 5;
    """,

    # 13. Claims per Provider
    "claims_per_provider": """
        SELECT p.Provider_Name AS name, COUNT(c.Claim_ID) AS total_claims
        FROM providers p
        JOIN food_listings f ON p.Provider_ID = f.Provider_ID
        JOIN claims c ON f.Food_ID = c.Food_ID
        GROUP BY p.Provider_Name
        ORDER BY total_claims DESC;
    """,

    # 14. Food Expiry in Next 7 Days
    "expiry_next_7_days": """
        SELECT Food_Name, Expiry_Date
        FROM food_listings
        WHERE date(Expiry_Date) BETWEEN date('now') AND date('now', '+7 day');
    """,

    # 15. Unclaimed Food
    "unclaimed_food": """
        SELECT f.Food_Name, f.Category, f.Expiry_Date
        FROM food_listings f
        LEFT JOIN claims c ON f.Food_ID = c.Food_ID
        WHERE c.Claim_ID IS NULL;
    """
}
