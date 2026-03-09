# Assignment 09 — Error Handling and Request Observability

## Overview

This assignment standardizes **API error responses** and introduces **request correlation IDs** to improve debugging and traceability in a Rails API application.

---

## Implementation Summary

The following features were implemented:

- Request IDs included in API responses
- Global exception handling in a base controller
- Consistent error response schema
- Logs linked to API responses using request IDs

---

## Request Correlation

Rails automatically generates a **request ID** for every incoming request.

The implementation exposes this ID through:

- HTTP response header
- JSON error response
- Application logs

### Example Header

```http
X-Request-ID: c92b4a7a-5c3a-4a0b-9c4a-2e6e6c19f7d4
Error Response Schema

All API errors follow a consistent JSON structure.

{
  "error": {
    "code": "string",
    "message": "string | array",
    "request_id": "uuid"
  }
}

Example Error Response
HTTP/1.1 404 Not Found
X-Request-ID: c92b4a7a-5c3a-4a0b-9c4a-2e6e6c19f7d4

Response body:

{
  "error": {
    "code": "not_found",
    "message": "Couldn't find Appointment with 'id'=1",
    "request_id": "c92b4a7a-5c3a-4a0b-9c4a-2e6e6c19f7d4"
  }
}

Example Logs

Log entry from development.log:

[c92b4a7a-5c3a-4a0b-9c4a-2e6e6c19f7d4] ActiveRecord::RecordNotFound: Couldn't find Appointment with 'id'=1

```
The request ID links:

> API response

> HTTP response header

> Application logs

This allows developers to trace a single request across the system for debugging.

## Error Handling Strategy

Exception handling is centralized in:
```
Api::BaseController
Handled Exceptions
Exception	Response
ActiveRecord::RecordNotFound	404 Not Found
ActiveRecord::RecordInvalid	422 Unprocessable Entity
StandardError	500 Internal Server Error
```
Internal errors are logged but not exposed to API clients.

### Security Considerations

> To prevent leaking sensitive information:

> Stack traces are not returned to clients

> Raw exception messages are hidden for internal errors

> Generic error messages are returned instead
