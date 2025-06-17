package Config;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

public class TripayService {
    
    public static String getPaymentChannels() {
        try {
            URL url = new URL(TripayConfig.getBaseUrl() + "/merchant/payment-channel");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + TripayConfig.getApiKey());
            conn.setRequestProperty("Content-Type", "application/json");
            
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            
            return response.toString();
        } catch (IOException e) {
            return "{\"error\": \"" + e.getMessage() + "\"}";
        }
    }
    
    public static String createTransaction(Map<String, Object> transactionData) {
        try {
            // Generate signature
            String signature = generateSignature(transactionData);
            transactionData.put("signature", signature);
            
            Gson gson = new Gson();
            String jsonData = gson.toJson(transactionData);
            
            URL url = new URL(TripayConfig.getBaseUrl() + "/transaction/create");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + TripayConfig.getApiKey());
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);
            
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonData.getBytes("utf-8");
                os.write(input, 0, input.length);
            }
            
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            
            return response.toString();
        } catch (IOException e) {
            return "{\"error\": \"" + e.getMessage() + "\"}";
        }
    }
    
    public static String getTransactionDetail(String reference) {
        try {
            URL url = new URL(TripayConfig.getBaseUrl() + "/transaction/detail?reference=" + reference);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + TripayConfig.getApiKey());
            conn.setRequestProperty("Content-Type", "application/json");
            
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            
            return response.toString();
        } catch (IOException e) {
            return "{\"error\": \"" + e.getMessage() + "\"}";
        }
    }
    
    private static String generateSignature(Map<String, Object> data) {
        try {
            String merchantCode = TripayConfig.getMerchantCode();
            String merchantRef = (String) data.get("merchant_ref");
            String amount = data.get("amount").toString();
            String privateKey = TripayConfig.getPrivateKey();
            
            String signatureString = merchantCode + merchantRef + amount + privateKey;
            
            MessageDigest md = MessageDigest.getInstance("SHA256");
            byte[] hash = md.digest(signatureString.getBytes("UTF-8"));
            
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (Exception e) {
            return "";
        }
    }
    
    public static boolean validateCallback(String callbackSignature, String merchantRef, String amount, String status) {
        try {
            String privateKey = TripayConfig.getPrivateKey();
            String signatureString = merchantRef + amount + status + privateKey;
            
            MessageDigest md = MessageDigest.getInstance("SHA256");
            byte[] hash = md.digest(signatureString.getBytes("UTF-8"));
            
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString().equals(callbackSignature);
        } catch (Exception e) {
            return false;
        }
    }
}
