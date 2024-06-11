package com.example.sample_login.controller;

import com.example.sample_login.entity.User;
import com.example.sample_login.service.UserService;
import com.example.sample_login.util.OTPGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/users")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JavaMailSender emailSender; // Autowire JavaMailSender

    @PostMapping("/add")
    public User createUser(@RequestBody User user) {
        System.out.println("Received request to create user: " + user);
        return userService.saveUser(user);
    }

    @GetMapping("/get")
    public List<User> getAllUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/getByEmail")
    public User getUserByEmail(@RequestParam String email) {
        User user = userService.findByEmail(email);
        if (user != null) {
            return user; // User with the provided email exists
        } else {
            return null; // User with the provided email does not exist
        }
    }

    @PostMapping("/generateOTP")
    public Map<String, String> generateOTP(@RequestBody Map<String, String> request) {
        // Get the email from the request body
        String email = request.get("email");

        // Create a map to hold the response data
        Map<String, String> response = new HashMap<>();

        // Check if the email is null or empty
        if (email == null || email.isEmpty()) {
            response.put("error", "Email not provided");
            return response;
        }

        // Check if the email exists in the database
        User user = userService.findByEmail(email);
        if (user == null) {
            response.put("error", "Email not found");
            return response;
        }

        // Generate OTP
        String otp = OTPGenerator.generateOTP();

        // Send email with OTP
        sendOTPEmail(email, otp);

        // Put the generated OTP in the response
        response.put("otp", otp);

        // Return the response map to the frontend
        return response;
    }


    // Method to send email with OTP
    private void sendOTPEmail(String email, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Your OTP for rest password");
        message.setText("Your OTP is: " + otp);

        emailSender.send(message);
    }
}
