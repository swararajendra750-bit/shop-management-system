# Security notes & test commands (updated with DB schema)

## Overview
- Spring Security with HTTP Basic for API demo.
- BCrypt password hashing (strength 10).
- Roles stored in table `user_roles` linked to `users.id`.
- `users` table columns: id, email, full_name, password.
- Flyway migration included: src/main/resources/db/migration/V1__init.sql

## Curl test commands
1) Register (example endpoint from backend must accept role field):
curl -X POST http://localhost:8080/api/auth/register \
 -H "Content-Type: application/json" \
 -d '{"email":"vendor@example.com","fullName":"Vendor One","password":"password","role":"vendor"}'

After registration, a row should be inserted into `users` and `user_roles`.

2) Check authenticated info:
curl -u vendor@example.com:password http://localhost:8080/api/auth/me

3) Vendor create product (expected 201):
curl -u vendor@example.com:password -X POST http://localhost:8080/api/products \
 -H "Content-Type: application/json" \
 -d '{"name":"Demo Item","description":"desc","price":199.99}'

4) Customer create product (expected 403):
curl -u customer@example.com:password -X POST http://localhost:8080/api/products \
 -H "Content-Type: application/json" \
 -d '{"name":"Bad Item","description":"desc","price":9.99}'

## DB check (confirm hashed password)
SELECT email, password FROM users WHERE email IN ('vendor@example.com', 'customer@example.com');

Passwords should start with $2a$ or $2b$ indicating BCrypt.

## Notes for implementers
- User entity should map `full_name` column to `fullName` field (e.g., @Column(name = "full_name")).
- Roles may be stored in `user_roles` table; ensure User.getRoles() gathers roles correctly (join or @ElementCollection with @CollectionTable mapping to user_roles).
