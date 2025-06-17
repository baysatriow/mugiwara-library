package Config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class TripayConfig {
    private static final String CONFIG_FILE = "tripay.properties";
    private static Properties properties;
    
    static {
        loadProperties();
    }
    
    private static void loadProperties() {
        properties = new Properties();
        try (InputStream input = TripayConfig.class.getClassLoader().getResourceAsStream(CONFIG_FILE)) {
            if (input != null) {
                properties.load(input);
            } else {
                // Default values if properties file not found
                properties.setProperty("tripay.api.key", "DEV-your-api-key-here");
                properties.setProperty("tripay.private.key", "your-private-key-here");
                properties.setProperty("tripay.merchant.code", "your-merchant-code");
                properties.setProperty("tripay.base.url", "https://tripay.co.id/api-sandbox");
                properties.setProperty("tripay.callback.url", "http://localhost:8080/your-app/callback");
                properties.setProperty("tripay.return.url", "http://localhost:8080/your-app/return");
            }
        } catch (IOException e) {
            System.err.println("Error loading Tripay configuration: " + e.getMessage());
        }
    }
    
    public static String getApiKey() {
        return properties.getProperty("tripay.api.key");
    }
    
    public static String getPrivateKey() {
        return properties.getProperty("tripay.private.key");
    }
    
    public static String getMerchantCode() {
        return properties.getProperty("tripay.merchant.code");
    }
    
    public static String getBaseUrl() {
        return properties.getProperty("tripay.base.url");
    }
    
    public static String getCallbackUrl() {
        return properties.getProperty("tripay.callback.url");
    }
    
    public static String getReturnUrl() {
        return properties.getProperty("tripay.return.url");
    }
    
    public static void updateConfig(String apiKey, String privateKey, String merchantCode, 
                                   String baseUrl, String callbackUrl, String returnUrl) {
        properties.setProperty("tripay.api.key", apiKey);
        properties.setProperty("tripay.private.key", privateKey);
        properties.setProperty("tripay.merchant.code", merchantCode);
        properties.setProperty("tripay.base.url", baseUrl);
        properties.setProperty("tripay.callback.url", callbackUrl);
        properties.setProperty("tripay.return.url", returnUrl);
    }
}
