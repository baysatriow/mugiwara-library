package Models;

/**
 *
 * @author bayus
 */

public class StoreSetting {
    private int storeId;
    private String storeName;
    private String logoPath;
    private String address;
    private String phone;
    private String email;
    private String description;
    private String socialMedia;
    private int updatedBy;

    public StoreSetting(int storeId, String storeName, String logoPath, String address, String phone, String email, String description, String socialMedia, int updatedBy) {
        this.storeId = storeId;
        this.storeName = storeName;
        this.logoPath = logoPath;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.description = description;
        this.socialMedia = socialMedia;
        this.updatedBy = updatedBy;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSocialMedia() {
        return socialMedia;
    }

    public void setSocialMedia(String socialMedia) {
        this.socialMedia = socialMedia;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    
}
