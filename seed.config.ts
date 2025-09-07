import { SeedPostgres } from "@snaplet/seed/adapter-postgres";
import { defineConfig } from "@snaplet/seed/config";
import postgres from "postgres"; // Correct import for Postgres.js

export default defineConfig({
  adapter: () => {
    // Ensure DATABASE_URL is set in your environment (e.g., .env file)
    const client = postgres(process.env.DATABASE_URL); // Correct instantiation for Postgres.js
    return new SeedPostgres(client);
  },
  select: [
    "!*", // Exclude all schemas by default
    "public*", // Explicitly include the 'public' schema
    "auth.users", // Include the auth.users table
  ],
});