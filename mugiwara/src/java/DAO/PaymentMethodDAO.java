//package DAO;
//
//import Models.PaymentMethod;
//import Models.QrisPayment;
//import Models.BankTransfer;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.time.LocalDateTime;
//import java.util.ArrayList;
//
//public class PaymentMethodDAO extends Models<PaymentMethod> {
//    
//    public PaymentMethodDAO() {
//        table = "payment_method";
//        primaryKey = "payment_id";
//    }
//    
//    @Override
//    PaymentMethod toModel(ResultSet rs) {
//        try {
//            // Check if this is a QRIS payment or Bank Transfer
//            String paymentCode = rs.getString("payment_code");
//            
//            if (paymentCode.startsWith("QRIS")) {
//                QrisPayment qris = new QrisPayment();
//                qris.setPaymentId(rs.getInt("payment_id"));
//                qris.setPaymentCode(rs.getString("payment_code"));
//                qris.setPaymentStatus(rs.getString("payment_status"));
//                qris.setDateTime(rs.getTimestamp("date_time").toLocalDateTime());
//                qris.setStatus(rs.getString("status"));
//                qris.setImagePath(rs.getString("image_path"));
//                return qris;
//            } else {
//                BankTransfer bank = new BankTransfer();
//                bank.setPaymentId(rs.getInt("payment_id"));
//                bank.setPaymentCode(rs.getString("payment_code"));
//                bank.setPaymentStatus(rs.getString("payment_status"));
//                bank.setDateTime(rs.getTimestamp("date_time").toLocalDateTime());
//                bank.setStatus(rs.getString("status"));
//                bank.setImagePath(rs.getString("image_path"));
//                return bank;
//            }
//        } catch (SQLException e) {
//            setMessage("Error in toModel: " + e.getMessage());
//            return null;
//        }
//    }
//    
//    public ArrayList<QrisPayment> getQrisPayments() {
//        ArrayList<QrisPayment> result = new ArrayList<>();
//        try {
//            connect();
//            String query = "SELECT pm.*, qp.qris_code FROM payment_method pm " +
//                          "JOIN qris_payment qp ON pm.payment_id = qp.payment_id " +
//                          "WHERE pm.payment_code LIKE 'QRIS%'";
//            ResultSet rs = stmt.executeQuery(query);
//            while (rs.next()) {
//                QrisPayment qris = new QrisPayment();
//                qris.setPaymentId(rs.getInt("payment_id"));
//                qris.setPaymentCode(rs.getString("payment_code"));
//                qris.setPaymentStatus(rs.getString("payment_status"));
//                qris.setDateTime(rs.getTimestamp("date_time").toLocalDateTime());
//                qris.setStatus(rs.getString("status"));
//                qris.setImagePath(rs.getString("image_path"));
//                qris.setQrisCode(rs.getString("qris_code"));
//                result.add(qris);
//            }
//        } catch (SQLException e) {
//            setMessage("Error getting QRIS payments: " + e.getMessage());
//        } finally {
//            disconnect();
//        }
//        return result;
//    }
//    
//    public ArrayList<BankTransfer> getBankTransfers() {
//        ArrayList<BankTransfer> result = new ArrayList<>();
//        try {
//            connect();
//            String query = "SELECT pm.*, bt.bank_name, bt.account_number, bt.acc_name " +
//                          "FROM payment_method pm " +
//                          "JOIN bank_transfer bt ON pm.payment_id = bt.payment_id";
//            ResultSet rs = stmt.executeQuery(query);
//            while (rs.next()) {
//                BankTransfer bank = new BankTransfer();
//                bank.setPaymentId(rs.getInt("payment_id"));
//                bank.setPaymentCode(rs.getString("payment_code"));
//                bank.setPaymentStatus(rs.getString("payment_status"));
//                bank.setDateTime(rs.getTimestamp("date_time").toLocalDateTime());
//                bank.setStatus(rs.getString("status"));
//                bank.setImagePath(rs.getString("image_path"));
//                bank.setBankName(rs.getString("bank_name"));
//                bank.setAccountNumber(rs.getString("account_number"));
//                bank.setAccName(rs.getString("acc_name"));
//                result.add(bank);
//            }
//        } catch (SQLException e) {
//            setMessage("Error getting bank transfers: " + e.getMessage());
//        } finally {
//            disconnect();
//        }
//        return result;
//    }
//    
//    public boolean insertQrisPayment(QrisPayment qris) {
//        try {
//            connect();
//            conn.setAutoCommit(false); // Fixed: use conn instead of stmt
//            
//            // Insert into payment_method
//            String insertPaymentMethod = "INSERT INTO payment_method (payment_code, payment_status, date_time, status, image_path) " +
//                                       "VALUES ('" + qris.getPaymentCode() + "', '" + qris.getPaymentStatus() + "', NOW(), '" + 
//                                       qris.getStatus() + "', '" + qris.getImagePath() + "')";
//            stmt.executeUpdate(insertPaymentMethod, Statement.RETURN_GENERATED_KEYS);
//            
//            ResultSet generatedKeys = stmt.getGeneratedKeys();
//            int paymentId = 0;
//            if (generatedKeys.next()) {
//                paymentId = generatedKeys.getInt(1);
//            }
//            
//            // Insert into qris_payment
//            String insertQris = "INSERT INTO qris_payment (payment_id, qris_code) VALUES (" + 
//                               paymentId + ", '" + qris.getQrisCode() + "')";
//            stmt.executeUpdate(insertQris);
//            
//            conn.commit(); // Fixed: use conn inste
