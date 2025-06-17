package Models;

public class Address {
    private int addressId;
    private String province;
    private String city;
    private String district;
    private String postalCode;
    private String fullAddress;
    private boolean isDefault;
    
    public Address() {}
    
    public Address(String province, String city, String district, String postalCode, String fullAddress) {
        this.province = province;
        this.city = city;
        this.district = district;
        this.postalCode = postalCode;
        this.fullAddress = fullAddress;
        this.isDefault = true;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public boolean isIsDefault() {
        return isDefault;
    }

    public void setIsDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }
    
    public String getFormattedAddress() {
        return fullAddress + ", " + district + ", " + city + ", " + province + " " + postalCode;
    }
    
    public void alamatInfo() {
        System.out.println("Address: " + getFormattedAddress());
        System.out.println("Default: " + (isDefault ? "Yes" : "No"));
    }
}