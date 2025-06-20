package com.example.backend.controller;

import com.example.backend.model.User;
import com.example.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class UserController {

    @Autowired
    private UserRepository userRepository;

    // Get all users
   @GetMapping("/api/users/search")
public List<User> searchUsers(@RequestParam String name) {
    return userRepository.findByNameContainingIgnoreCase(name);
}

    @PostMapping("/api/users")
public ResponseEntity<?> addUser(@RequestBody User user) {
    String name = user.getName() != null ? user.getName().trim() : "";
    String email = user.getEmail() != null ? user.getEmail().trim() : "";

    // Backend-side validation
    if (name.isEmpty() || email.isEmpty() || !email.contains("@")) {
        return ResponseEntity.badRequest().body("Invalid name or email. Email must include '@'");
    }

    try {
        User savedUser = userRepository.save(user);
        return ResponseEntity.ok(savedUser);
    } catch (Exception e) {
        return ResponseEntity.status(500).body("Error saving user.");
    }
}

    // Update user by ID
    @PutMapping("/api/users/{id}")
    public User updateUser(@PathVariable Long id, @RequestBody User userData) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setName(userData.getName());
            user.setEmail(userData.getEmail());
            return userRepository.save(user);
        }
        return null;
    }

    // Delete user by ID
    @DeleteMapping("/api/users/{id}")
    public void deleteUser(@PathVariable Long id) {
        userRepository.deleteById(id);
    }
}
