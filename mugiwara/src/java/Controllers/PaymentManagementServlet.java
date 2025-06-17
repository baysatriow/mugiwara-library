package Controllers;

import DAO.PaymentMethodDAO;
import Models.QrisPayment;
import Models.BankTransfer;
import Config.TripayService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;

@WebServlet("/PaymentManagement")
public class PaymentManagementServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        PaymentMethodDAO paymentDAO = new PaymentMethodDAO();
        HttpSession session = request.getSession();
        
        if ("getPaymentMethods".equals(action)) {
            ArrayList<QrisPayment> qrisList = paymentDAO.getQrisPayments();
            ArrayList<BankTransfer> bankList = paymentDAO.getBankTransfers();
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            Gson gson = new Gson();
            JsonObject result = new JsonObject();
            result.add("qris", gson.toJsonTree(qrisList));
            result.add("bank", gson.toJsonTree(bankList));
            
            response.getWriter().write(gson.toJson(result));
            
        } else if ("getChannels".equals(action)) {
            String channels = TripayService.getPaymentChannels();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(channels);
            
        } else if ("delete".equals(action)) {
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            
            if (paymentDAO.deletePaymentMethod(paymentId)) {
                session.setAttribute("notificationMsg", "Metode pembayaran berhasil dihapus");
                session.setAttribute("notificationType", "success");
            } else {
                session.setAttribute("notificationMsg", "Gagal menghapus metode pembayaran: " + paymentDAO.getMessage());
                session.setAttribute("notificationType", "error");
            }
            
            response.sendRedirect("Admin?page=paymentmethod");
            
        } else if ("getPayment".equals(action)) {
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            String type = request.getParameter("type");
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            Gson gson = new Gson();
            
            if ("QRIS".equals(type)) {
                ArrayList<QrisPayment> qrisList = paymentDAO.getQrisPayments();
                for (QrisPayment qris : qrisList) {
                    if (qris.getPaymentId() == paymentId) {
                        response.getWriter().write(gson.toJson(qris));
                        return;
                    }
                }
            } else if ("BANK".equals(type)) {
                ArrayList<BankTransfer> bankList = paymentDAO.getBankTransfers();
                for (BankTransfer bank : bankList) {
                    if (bank.getPaymentId() == paymentId) {
                        response.getWriter().write(gson.toJson(bank));
                        return;
                    }
                }
            }
            
            response.getWriter().write("{\"error\": \"Payment method not found\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        PaymentMethodDAO paymentDAO = new PaymentMethodDAO();
        HttpSession session = request.getSession();
        
        if ("addQris".equals(action)) {
            QrisPayment qris = new QrisPayment();
            qris.setPaymentCode(request.getParameter("paymentCode"));
            qris.setPaymentStatus("ACTIVE");
            qris.setDateTime(LocalDateTime.now());
            qris.setStatus("ACTIVE");
            qris.setImagePath(request.getParameter("imagePath"));
            qris.setQrisCode(request.getParameter("qrisCode"));
            
            if (paymentDAO.insertQrisPayment(qris)) {
                session.setAttribute("notificationMsg", "QRIS payment berhasil ditambahkan");
                session.setAttribute("notificationType", "success");
            } else {
                session.setAttribute("notificationMsg", "Gagal menambahkan QRIS payment: " + paymentDAO.getMessage());
                session.setAttribute("notificationType", "error");
            }
            
        } else if ("addBank".equals(action)) {
            BankTransfer bank = new BankTransfer();
            bank.setPaymentCode(request.getParameter("paymentCode"));
            bank.setPaymentStatus("ACTIVE");
            bank.setDateTime(LocalDateTime.now());
            bank.setStatus("ACTIVE");
            bank.setImagePath(request.getParameter("imagePath"));
            bank.setBankName(request.getParameter("bankName"));
            bank.setAccountNumber(request.getParameter("accountNumber"));
            bank.setAccName(request.getParameter("accName"));
            
            if (paymentDAO.insertBankTransfer(bank)) {
                session.setAttribute("notificationMsg", "Bank transfer berhasil ditambahkan");
                session.setAttribute("notificationType", "success");
            } else {
                session.setAttribute("notificationMsg", "Gagal menambahkan bank transfer: " + paymentDAO.getMessage());
                session.setAttribute("notificationType", "error");
            }
            
        } else if ("updateQris".equals(action)) {
            // Implementation for updating QRIS payment
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            // Get existing QRIS and update it
            // This would require additional methods in DAO
            session.setAttribute("notificationMsg", "Update QRIS functionality will be implemented");
            session.setAttribute("notificationType", "info");
            
        } else if ("updateBank".equals(action)) {
            // Implementation for updating Bank Transfer
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            // Get existing Bank Transfer and update it
            // This would require additional methods in DAO
            session.setAttribute("notificationMsg", "Update Bank Transfer functionality will be implemented");
            session.setAttribute("notificationType", "info");
        }
        
        response.sendRedirect("Admin?page=paymentmethod");
    }
}
