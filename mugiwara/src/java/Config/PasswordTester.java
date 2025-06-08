/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Config;

/**
 *
 * @author bayus
 */

public class PasswordTester {

    public static void main(String[] args) {
        // --- Skenario 1: Kata Sandi Sederhana ---
        System.out.println("--- Memulai Tes Skenario 1 ---");
        
        // 1. Tentukan kata sandi asli yang ingin diuji.
        String myPassword = "bayu123";
        System.out.println("Kata Sandi Asli: " + myPassword);
        
        // 2. Gunakan PasswordConf untuk membuat hash dari kata sandi tersebut.
        String hashedPassword = PasswordConf.hashPassword(myPassword);
        System.out.println("Hasil Hash (BCrypt): " + hashedPassword);
        System.out.println("Panjang Hash: " + hashedPassword.length()); // Hash BCrypt selalu 60 karakter.
        
        System.out.println("\n--- Memulai Verifikasi ---");

        // 3. Verifikasi menggunakan kata sandi yang BENAR. Hasilnya harus 'true'.
        boolean isPasswordCorrect = PasswordConf.verifyPassword(myPassword, hashedPassword);
        System.out.println("Hasil verifikasi dengan password BENAR ('bayu123'): " + isPasswordCorrect);

        // 4. Verifikasi menggunakan kata sandi yang SALAH. Hasilnya harus 'false'.
        String wrongPassword = "passwordSALAH";
        boolean isPasswordWrong = PasswordConf.verifyPassword(wrongPassword, hashedPassword);
        System.out.println("Hasil verifikasi dengan password SALAH ('" + wrongPassword + "'): " + isPasswordWrong);

        System.out.println("--- Tes Skenario 1 Selesai ---\n");


        // --- Skenario 2: Menguji dengan hash yang sudah ada ---
        System.out.println("--- Memulai Tes Skenario 2 ---");
        String existingHash = "$2a$12$fiZ9Sw.RJ7YhnuGqeBlGUOTSy6NxNhiJsntCZRd9Z0qXy91LFTteC";
        String passwordForExistingHash = "bayu123";
        
        System.out.println("Hash yang sudah ada: " + existingHash);
        System.out.println("Kata sandi yang seharusnya cocok: " + passwordForExistingHash);

        boolean isExistingHashCorrect = PasswordConf.verifyPassword(passwordForExistingHash, existingHash);
        System.out.println("Hasil verifikasi: " + isExistingHashCorrect);
        
        System.out.println("--- Tes Skenario 2 Selesai ---");
    }
}

