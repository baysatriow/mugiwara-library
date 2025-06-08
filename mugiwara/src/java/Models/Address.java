/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author VIVOBOOK
 */

public class Address {
    private String province;
    private String city;
    private String district;
    private String postalCode;
    private String fullAddress;
    
    public Address() {}
    
    public Address(String province, String city, String district, String postalCode, String fullAddress) {
        this.province = province;
        this.city = city;
        this.district = district;
        this.postalCode = postalCode;
        this.fullAddress = fullAddress;
    }
    
    // Getters and Setters
    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }
    
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    
    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }
    
    public String getPostalCode() { return postalCode; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }
    
    public String getFullAddress() { return fullAddress; }
    public void setFullAddress(String fullAddress) { this.fullAddress = fullAddress; }
    
    @Override
    public String toString() {
        return fullAddress + ", " + district + ", " + city + ", " + province + " " + postalCode;
    }
}
