SELECT vendor_contact_first_name, vendor_contact_last_name,
    SUBSTR( vendor_contact_first_name, 1, 1) ||
    SUBSTR( vendor_contact_last_name, 1, 1) AS initials
FROM vendors
