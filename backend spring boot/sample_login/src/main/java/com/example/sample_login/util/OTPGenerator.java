package com.example.sample_login.util;

import java.util.Random;

public class OTPGenerator {

    public static String generateOTP() {
        int otpLength = 4; // Length of OTP
        Random random = new Random();
        StringBuilder otp = new StringBuilder();

        for (int i = 0; i < otpLength; i++) {
            otp.append(random.nextInt(10)); // Append random digit (0-9)
        }

        return otp.toString();
    }
}
