# Security Bundle v2 (Member 4) - includes DB migration

Files included:
- PasswordConfig.java
- SecurityConfig.java
- ShopUserDetailsService.java
- AuthController.java (adds /api/auth/me)
- UserDetailsServiceTest.java (unit test)
- src/main/resources/db/migration/V1__init.sql (Flyway migration)
- db/sql_dump.sql (original user-provided dump for reference)
- SECURITY.md (tests & commands)

## How to use
1. Drop Java files into your backend module under src/main/java and src/test/java.
2. Ensure package root is `com.shopapp` (adjust package declarations if different).
3. Add dependency to pom.xml:
   - spring-boot-starter-security
   - spring-security-crypto
   - (optional) flyway-core to run migrations automatically
4. If using Flyway, the migration V1__init.sql will create tables matching the provided dump.
5. Build and run:
   mvn clean package
   mvn spring-boot:run
6. Use curl commands in SECURITY.md to validate.

## Important mapping notes
- `users.full_name` -> `User.fullName` use @Column(name = "full_name")
- `user_roles` is a separate table; map roles using @ElementCollection or a dedicated Role entity.
- Product vendor relation uses `vendor_id` FK to `users.id`.
