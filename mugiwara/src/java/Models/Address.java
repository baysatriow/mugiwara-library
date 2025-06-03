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

    private String addressID;
    private String street;
    private String city;
    private String state;
    private String zipCode;
    private String country;

    /**
     * Konstruktor default
     */
    public Address() {
    }

    /**
     * Konstruktor dengan semua atribut
     * @param addressID ID Alamat
     * @param street Nama Jalan
     * @param city Kota
     * @param state Provinsi/Negara Bagian
     * @param zipCode Kode Pos
     * @param country Negara
     */
    public Address(String addressID, String street, String city, String state, String zipCode, String country) {
        this.addressID = addressID;
        this.street = street;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.country = country;
    }

    // --- Getter dan Setter untuk atribut ---

    public String getAddressID() {
        return addressID;
    }

    public void setAddressID(String addressID) {
        this.addressID = addressID;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    // --- Metode (opsional, jika ada perilaku spesifik) ---
    public String getFullAddress() {
        return street + ", " + city + ", " + state + " " + zipCode + ", " + country;
    }

    @Override
    public String toString() {
        return "Address{" +
               "addressID='" + addressID + '\'' +
               ", street='" + street + '\'' +
               ", city='" + city + '\'' +
               ", state='" + state + '\'' +
               ", zipCode='" + zipCode + '\'' +
               ", country='" + country + '\'' +
               '}';
    }
}