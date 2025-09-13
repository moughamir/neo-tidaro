import { createSeedClient } from "@snaplet/seed";
import { copycat } from "@snaplet/copycat";

async function runSeed() {
  const seed = await createSeedClient();

  // Truncate all tables (use with caution, this deletes existing data)
  await seed.$resetDatabase();

  console.log("Generating and seeding data with Snaplet...");

  // Generate Profiles (Customers and Providers)
  const profiles = await seed.profiles((create) =>
    Array.from(
      { length: 1 },
      (
        _,
        i // Changed length to 1 for initial test
      ) =>
        create({
          full_name: copycat.fullName(i),
          email: copycat.email(i),
          phone_number: copycat.phoneNumber(i, { format: "06########" }), // Moroccan format
          role: i < 10 ? "clientConsumer" : "clientProvider", // First 10 are consumers, rest are providers
          professional_status:
            i < 10
              ? null
              : copycat.oneOf(i, ["available", "busy", "offline", "onBreak"]),
          avatar_url: `https://via.placeholder.com/150?text=Avatar+${i}`, // Using a placeholder image URL
        })
    )
  );

  // Generate Addresses for Consumers
  // const consumerProfiles = profiles.filter(p => p.role === "clientConsumer");
  // await seed.addresses((create) =>
  //   consumerProfiles.map((profile, i) =>
  //     create({
  //       profile_id: profile.id,
  //       street: copycat.street(i),
  //       apartment: copycat.buildingNumber(i),
  //       city: copycat.city(i), // Can be improved with Moroccan cities
  //       state: copycat.state(i), // Can be improved with Moroccan regions
  //       zip_code: copycat.zipcode(i),
  //       country: "MA",
  //       instructions: copycat.sentence(i),
  //     })
  //   )
  // );

  // Generate Services
  // const services = await seed.services((create) =>
  //   Array.from({ length: 5 }, (_, i) =>
  //     create({
  //       name: copycat.word(i) + " Cleaning",
  //       description: copycat.sentence(i),
  //       base_price: copycat.float(i, { min: 50, max: 500, precision: 2 }),
  //       estimated_duration_minutes: copycat.int(i, { min: 60, max: 480 }),
  //       category: copycat.oneOf(i, ["standardCleaning", "deepCleaning", "moveInOut", "postConstruction", "commercial", "residential"]),
  //       is_active: copycat.boolean(i),
  //     })
  //   )
  // );

  // Generate Bookings
  // const providerProfiles = profiles.filter(p => p.role === "clientProvider");
  // await seed.bookings((create) =>
  //   Array.from({ length: 30 }, (_, i) => {
  //     const customer = copycat.oneOf(i, consumerProfiles);
  //     const service = copycat.oneOf(i, services);
  //     const professional = copycat.oneOf(i, providerProfiles);
  //     const status = copycat.oneOf(i, ["pending", "confirmed", "inProgress", "completed", "cancelled", "rescheduled", "noShow", "disputed"]);
  //     const payment_status = copycat.oneOf(i, ["pending", "paid", "failed", "refunded"]);

  //     return create({
  //       customer_id: customer.id,
  //       service_id: service.id,
  //       address_id: copycat.oneOf(i, customer.addresses).id, // Assuming addresses are linked to customers
  //       professional_id: professional.id,
  //       scheduled_date: copycat.date(i, { min: "2025-01-01", max: "2025-12-31" }),
  //       status: status,
  //       total_price: copycat.float(i, { min: 100, max: 1000, precision: 2 }),
  //       payment_status: payment_status,
  //       notes: copycat.sentence(i),
  //       completed_at: status === "completed" ? copycat.date(i, { min: "2024-01-01", max: "2025-01-01" }) : null,
  //       cancelled_at: status === "cancelled" ? copycat.date(i, { min: "2024-01-01", max: "2025-01-01" }) : null,
  //       rescheduled_from: status === "rescheduled" ? copycat.date(i, { min: "2024-01-01", max: "2025-01-01" }) : null,
  //     });
  //   })
  // );

  // Generate Reviews (linking to bookings, reviewers, reviewees)
  // For AI-generated reviews, you would configure Snaplet with an LLM API key.
  // For deterministic text, use copycat.sentence or similar.
  // const allBookings = await seed.bookings.findMany(); // Fetch all generated bookings
  // await seed.reviews((create) =>
  //   allBookings.filter((_, i) => copycat.boolean(i)).map((booking, i) => { // Review a subset of bookings
  //     // Assuming customer and professional are directly accessible from the booking object
  //     // If not, you might need to fetch them based on booking.customer_id and booking.professional_id
  //     const reviewer_id = booking.customer_id;
  //     const reviewee_id = booking.professional_id;

  //     return create({
  //       booking_id: booking.id,
  //       reviewer_id: reviewer_id,
  //       reviewee_id: reviewee_id,
  //       rating: copycat.int(i, { min: 3, max: 5 }), // Mostly positive reviews
  //       comment: copycat.sentence(i), // Placeholder for AI-generated comment
  //       is_verified_booking: true,
  //     });
  //   })
  // );

  console.log("Database seeded successfully with Snaplet!");
  process.exit(0);
}

runSeed().catch((error) => {
  console.error("Seed failed:", error);
  process.exit(1);
});
