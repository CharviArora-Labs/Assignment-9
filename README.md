# Observability API — Assignment 09

This project implements **standardized API error handling and request observability** in a Rails API application as part of the **ILA Rails & React Engineering Certification (Level 1)**.

---

# Objective

The assignment demonstrates how to:

- Add **request correlation IDs** to API responses  
- Implement **centralized exception handling**  
- Provide **consistent API error responses**  
- Ensure **internal stack traces are not exposed to clients**  
- Improve debugging by making **logs traceable using request IDs**

---

# Project Setup

## 1. Install Dependencies

Ensure the following are installed:

- Ruby
- Rails
- Bundler

Check versions:

```bash
ruby -v
rails -v
```

Install dependencies:
```bash
bundle install
```

### 2. Run the Server

Start the Rails server:
```
rails s
```
Server runs at:
```
http://localhost:3000
```
## API Endpoint:

Example endpoint for testing error handling:
```
GET /api/v1/appointments/:id
```

Example request:
```
curl -i http://localhost:3000/api/v1/appointments/1
```

Error Response Format

All API errors follow a consistent schema:
```
{
  "error": {
    "code": "string",
    "message": "string | array",
    "request_id": "uuid"
  }
}
```

Example Error Response
```
{
  "error": {
    "code": "not_found",
    "message": "Couldn't find Appointment with 'id'=1",
    "request_id": "c92b4a7a-5c3a-4a0b-9c4a-2e6e6c19f7d4"
  }
}
```
## Request Observability

Each API response includes a request correlation ID.

Header:
```
X-Request-ID
```

This ID appears in:

> API responses

> HTTP response headers

> Application logs

This allows developers to trace a single request across logs for debugging.


## Project Structure
```
app
 └ controllers
    └ api
       ├ base_controller.rb
       └ v1
          └ appointments_controller.rb

config
 └ routes.rb

docs
 └ assignment-09.md
Key Implementation Features
Centralized Error Handling
```

Implemented in:
```
app/controllers/api/base_controller.rb
```
Handles:
```
> ActiveRecord::RecordNotFound
> ActiveRecord::RecordInvalid
> StandardError
> Request Correlation
```
Each request automatically includes:
```
request.request_id
```

This ID is:

> Returned in API responses

> Logged for debugging

> Documentation

### Assignment details and logs are documented in:
```
docs/assignment-09.md
```

> Logs traceable via request ID

> Internal stack traces hidden from clients
