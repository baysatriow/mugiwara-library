/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author VIVOBOOK
 */
public class ShippingMethod {

    private String methodID;
    private String methodName;
    private double cost;
    private int duration; // Asumsi durasi dalam satuan waktu (misal: hari)

    /**
     * Konstruktor default
     */
    public ShippingMethod() {
    }
    public ShippingMethod(String methodID, String methodName, double cost, int duration) {
        this.methodID = methodID;
        this.methodName = methodName;
        this.cost = cost;
        this.duration = duration;
    }

    // --- Getter dan Setter untuk atribut ---

    public String getMethodID() {
        return methodID;
    }

    public void setMethodID(String methodID) {
        this.methodID = methodID;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    // --- Metode (opsional, jika ada perilaku spesifik) ---
    // Contoh: Menampilkan detail metode pengiriman
    public void displayMethodDetails() {
        System.out.println("Method ID: " + methodID);
        System.out.println("Method Name: " + methodName);
        System.out.println("Cost: $" + cost);
        System.out.println("Duration: " + duration + " days");
    }

    @Override
    public String toString() {
        return "ShippingMethod{" +
               "methodID='" + methodID + '\'' +
               ", methodName='" + methodName + '\'' +
               ", cost=" + cost +
               ", duration=" + duration +
               '}';
    }
}
