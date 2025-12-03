package com.careportal.careportal_service.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class HealthCheckController {

    @GetMapping("/status")
    public Map<String, Object> statusCheck() {

        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("timestamp", LocalDateTime.now().toString());
        response.put("message", "CarePortal service is running smoothly");

        return response;
    }

    @GetMapping("/predict")
    public Map<String, Double> predict() {

        Map<String, Double> response = new HashMap<>();
        response.put("score", 0.75);

        return response;
    }
}