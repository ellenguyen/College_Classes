//package dbaccess;

import java.sql.*;
import java.text.NumberFormat;

public class JavaDBTestApp {

    public static void main(String args[]) {
        // define common JDBC objects
        Connection connection = null;
        Statement statement = null;
        ResultSet rs = null;

        try {
            // Connect to the database
            String dbUrl = "jdbc:oracle:thin:@localhost:1521:XE";
            String username = "ap";
            String password = "ap";
            connection = DriverManager.getConnection(dbUrl, username, password);

            // Execute a SELECT statement
            statement = connection.createStatement();
            String query
                    = "SELECT vendor_name, invoice_number, invoice_total "
                    + "FROM vendors INNER JOIN invoices "
                    + "	ON vendors.vendor_id = invoices.vendor_id "
                    + "WHERE invoice_total >= 500 "
                    + "ORDER BY vendor_name, invoice_total DESC";

            rs = statement.executeQuery(query);

            // Display the results of a SELECT statement
            System.out.println("Invoices with totals over 500:\n");
            while (rs.next()) {
                String vendorName = rs.getString("vendor_name");
                String invoiceNumber = rs.getString("invoice_number");
                double invoiceTotal = rs.getDouble("invoice_total");
                NumberFormat currency = NumberFormat.getCurrencyInstance();
                String invoiceTotalString = currency.format(invoiceTotal);
                System.out.println(
                        "Vendor:	" + vendorName + "\n"
                        + "Invoice No: " + invoiceNumber + "\n"
                        +"Total: " + invoiceTotalString + "\n");

            }
        } catch (SQLException e) {
                System.out.println(e);
        }
    }
}
