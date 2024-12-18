-- enable and disable a trigger
ALTER TRIGGER ap_before_create_drop DISABLE;
CREATE TABLE test1 (test_id NUMBER);
DROP TABLE test1;
ALTER TRIGGER ap_before_create_drop ENABLE;

-- disable or enable all triggers for a table
ALTER TABLE invoices DISABLE ALL TRIGGERS;
ALTER TABLE invoices ENABLE ALL TRIGGERS;

-- rename a trigger
ALTER TRIGGER invoices_before_update_total RENAME TO invoices_before_update_inv_tot;
ALTER TRIGGER invoices_before_update_inv_tot RENAME TO invoices_before_update_total;

-- drop a trigger
DROP TRIGGER ap_before_create_drop;