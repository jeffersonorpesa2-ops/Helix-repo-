package com.ibarangay.controller;

import com.ibarangay.model.DocumentRequest;
import com.ibarangay.service.DocumentRequestService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/document-requests")
public class DocumentRequestController {

    private final DocumentRequestService service;

    public DocumentRequestController(DocumentRequestService service) {
        this.service = service;
    }

    // Retrieve all document requests
    @GetMapping
    public List<DocumentRequest> getAll() {
        return service.getAllDocumentRequests();
    }

    // Retrieve a document request by ID
    @GetMapping("/{requestId}")
    public ResponseEntity<DocumentRequest> getById(
            @PathVariable Long requestId) {

        return service.getDocumentRequestById(requestId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}