using MyPetVenues.Models;

namespace MyPetVenues.Services;

public interface IVenueService
{
    Task<List<Venue>> GetAllVenuesAsync();
    Task<Venue?> GetVenueByIdAsync(int id);
    Task<List<Venue>> GetFeaturedVenuesAsync();
    Task<List<Venue>> SearchVenuesAsync(string? search, VenueType? type, PetType? pet);
    Task<List<Review>> GetVenueReviewsAsync(int venueId);
}

public class MockVenueService : IVenueService
{
    private readonly List<Venue> _venues;
    private readonly List<Review> _reviews;

    public MockVenueService()
    {
        _venues = GenerateMockVenues();
        _reviews = GenerateMockReviews();
    }

    public Task<List<Venue>> GetAllVenuesAsync()
    {
        return Task.FromResult(_venues);
    }

    public Task<Venue?> GetVenueByIdAsync(int id)
    {
        return Task.FromResult(_venues.FirstOrDefault(v => v.Id == id));
    }

    public Task<List<Venue>> GetFeaturedVenuesAsync()
    {
        return Task.FromResult(_venues.Where(v => v.IsFeatured).ToList());
    }

    public Task<List<Venue>> SearchVenuesAsync(string? search, VenueType? type, PetType? pet)
    {
        var results = _venues.AsEnumerable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            results = results.Where(v => 
                v.Name.Contains(search, StringComparison.OrdinalIgnoreCase) ||
                v.Description.Contains(search, StringComparison.OrdinalIgnoreCase) ||
                v.City.Contains(search, StringComparison.OrdinalIgnoreCase));
        }

        if (type.HasValue)
        {
            results = results.Where(v => v.Type == type.Value);
        }

        if (pet.HasValue && pet.Value != PetType.All)
        {
            results = results.Where(v => v.AllowedPets.Contains(pet.Value) || v.AllowedPets.Contains(PetType.All));
        }

        return Task.FromResult(results.ToList());
    }

    public Task<List<Review>> GetVenueReviewsAsync(int venueId)
    {
        return Task.FromResult(_reviews.Where(r => r.VenueId == venueId).ToList());
    }

    private static List<Venue> GenerateMockVenues()
    {
        return new List<Venue>
        {
            new Venue
            {
                Id = 1,
                Name = "Pawsome Park",
                Description = "A spacious dog park with separate areas for small and large breeds. Features include agility equipment, water fountains, and shaded seating areas.",
                Address = "123 Bark Avenue",
                City = "Seattle",
                ImageUrl = "https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800",
                Rating = 4.8,
                ReviewCount = 156,
                Type = VenueType.Park,
                AllowedPets = new List<PetType> { PetType.Dog, PetType.Cat, PetType.SmallPet },
                Amenities = new List<string> { "Off-leash area", "Water fountains", "Agility equipment", "Waste stations", "Shade structures" },
                OpeningHours = new Dictionary<string, string>
                {
                    { "Monday", "6:00 AM - 9:00 PM" },
                    { "Tuesday", "6:00 AM - 9:00 PM" },
                    { "Wednesday", "6:00 AM - 9:00 PM" },
                    { "Thursday", "6:00 AM - 9:00 PM" },
                    { "Friday", "6:00 AM - 9:00 PM" },
                    { "Saturday", "6:00 AM - 10:00 PM" },
                    { "Sunday", "6:00 AM - 10:00 PM" }
                },
                IsFeatured = true,
                ContactPhone = "(206) 555-0101",
                Website = "https://pawsomepark.example.com"
            },
            new Venue
            {
                Id = 2,
                Name = "Bark & Brew Café",
                Description = "Pet-friendly café serving artisan coffee, fresh pastries, and special treats for your furry friends. Indoor and outdoor seating available.",
                Address = "456 Woof Street",
                City = "Portland",
                ImageUrl = "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
                Rating = 4.7,
                ReviewCount = 89,
                Type = VenueType.Cafe,
                AllowedPets = new List<PetType> { PetType.Dog, PetType.Cat },
                Amenities = new List<string> { "Pet treats", "Water bowls", "Outdoor patio", "WiFi", "Pet photo wall" },
                OpeningHours = new Dictionary<string, string>
                {
                    { "Monday", "7:00 AM - 7:00 PM" },
                    { "Tuesday", "7:00 AM - 7:00 PM" },
                    { "Wednesday", "7:00 AM - 7:00 PM" },
                    { "Thursday", "7:00 AM - 7:00 PM" },
                    { "Friday", "7:00 AM - 8:00 PM" },
                    { "Saturday", "8:00 AM - 8:00 PM" },
                    { "Sunday", "8:00 AM - 6:00 PM" }
                },
                IsFeatured = true,
                ContactPhone = "(503) 555-0202",
                Website = "https://barkbrew.example.com"
            },
            new Venue
            {
                Id = 3,
                Name = "Furry Friends Hotel",
                Description = "Luxury pet-friendly hotel with spacious suites, grooming services, and 24/7 pet concierge. Your pets will feel right at home!",
                Address = "789 Pet Paradise Lane",
                City = "San Francisco",
                ImageUrl = "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
                Rating = 4.9,
                ReviewCount = 234,
                Type = VenueType.Hotel,
                AllowedPets = new List<PetType> { PetType.All },
                Amenities = new List<string> { "Pet suites", "Grooming", "Pet menu", "Exercise area", "Pet sitting", "Veterinarian on call" },
                OpeningHours = new Dictionary<string, string>
                {
                    { "Monday", "24/7" },
                    { "Tuesday", "24/7" },
                    { "Wednesday", "24/7" },
                    { "Thursday", "24/7" },
                    { "Friday", "24/7" },
                    { "Saturday", "24/7" },
                    { "Sunday", "24/7" }
                },
                IsFeatured = true,
                ContactPhone = "(415) 555-0303",
                Website = "https://furryfriendshotel.example.com"
            },
            new Venue
            {
                Id = 4,
                Name = "Pet Paradise Beach",
                Description = "Dog-friendly beach with designated swimming areas, beach toy rentals, and a rinse station. Perfect for a sunny day out!",
                Address = "321 Ocean Drive",
                City = "San Diego",
                ImageUrl = "https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=800",
                Rating = 4.6,
                ReviewCount = 178,
                Type = VenueType.Beach,
                AllowedPets = new List<PetType> { PetType.Dog },
                Amenities = new List<string> { "Swimming area", "Rinse station", "Beach toys", "Shade umbrellas", "Waste bags" },
                OpeningHours = new Dictionary<string, string>
                {
                    { "Monday", "Sunrise - Sunset" },
                    { "Tuesday", "Sunrise - Sunset" },
                    { "Wednesday", "Sunrise - Sunset" },
                    { "Thursday", "Sunrise - Sunset" },
                    { "Friday", "Sunrise - Sunset" },
                    { "Saturday", "Sunrise - Sunset" },
                    { "Sunday", "Sunrise - Sunset" }
                },
                IsFeatured = false,
                ContactPhone = "(619) 555-0404",
                Website = "https://petparadisebeach.example.com"
            },
            new Venue
            {
                Id = 5,
                Name = "Whiskers & Wags Store",
                Description = "Premier pet supply store with everything from premium food to designer accessories. Knowledgeable staff and in-store vet consultations.",
                Address = "654 Pet Supply Way",
                City = "Austin",
                ImageUrl = "https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=800",
                Rating = 4.7,
                ReviewCount = 145,
                Type = VenueType.Store,
                AllowedPets = new List<PetType> { PetType.All },
                Amenities = new List<string> { "Wide selection", "Expert advice", "Vet consultations", "Grooming products", "Custom orders" },
                OpeningHours = new Dictionary<string, string>
                {
                    { "Monday", "9:00 AM - 8:00 PM" },
                    { "Tuesday", "9:00 AM - 8:00 PM" },
                    { "Wednesday", "9:00 AM - 8:00 PM" },
                    { "Thursday", "9:00 AM - 8:00 PM" },
                    { "Friday", "9:00 AM - 9:00 PM" },
                    { "Saturday", "9:00 AM - 9:00 PM" },
                    { "Sunday", "10:00 AM - 7:00 PM" }
                },
                IsFeatured = false,
                ContactPhone = "(512) 555-0505",
                Website = "https://whiskersandwags.example.com"
            },
            new Venue
            {
                Id = 6,
                Name = "Cozy Paws Restaurant",
                Description = "Fine dining restaurant with a pet-friendly patio. Enjoy gourmet meals while your pets relax with complimentary treats and water.",
                Address = "987 Gourmet Boulevard",
                City = "Denver",
                ImageUrl = "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800",
                Rating = 4.5,
                ReviewCount = 112,
                Type = VenueType.Restaurant,
                AllowedPets = new List<PetType> { PetType.Dog, PetType.Cat },
                Amenities = new List<string> { "Pet-friendly patio", "Pet treats", "Water bowls", "Heating lamps", "Pet menu" },
                OpeningHours = new Dictionary<string, string>
                {
                    { "Monday", "Closed" },
                    { "Tuesday", "5:00 PM - 10:00 PM" },
                    { "Wednesday", "5:00 PM - 10:00 PM" },
                    { "Thursday", "5:00 PM - 10:00 PM" },
                    { "Friday", "5:00 PM - 11:00 PM" },
                    { "Saturday", "11:00 AM - 11:00 PM" },
                    { "Sunday", "11:00 AM - 9:00 PM" }
                },
                IsFeatured = false,
                ContactPhone = "(303) 555-0606",
                Website = "https://cozypaws.example.com"
            }
        };
    }

    private static List<Review> GenerateMockReviews()
    {
        return new List<Review>
        {
            new Review
            {
                Id = 1,
                VenueId = 1,
                UserId = 1,
                UserName = "Sarah Johnson",
                Rating = 5.0,
                Comment = "Absolutely love this park! My golden retriever Max has made so many friends here. The agility equipment is top-notch and the staff keeps everything spotless.",
                VisitDate = DateTime.Now.AddDays(-15),
                PetName = "Max"
            },
            new Review
            {
                Id = 2,
                VenueId = 1,
                UserId = 2,
                UserName = "Michael Chen",
                Rating = 4.5,
                Comment = "Great park with lots of space. The separate small dog area is perfect for my corgi. Only wish there were more shade structures.",
                VisitDate = DateTime.Now.AddDays(-8),
                PetName = "Luna"
            },
            new Review
            {
                Id = 3,
                VenueId = 2,
                UserId = 3,
                UserName = "Emily Rodriguez",
                Rating = 5.0,
                Comment = "Best pet-friendly café in town! The staff always remembers my pup's name and brings her favorite treats. Coffee is amazing too!",
                VisitDate = DateTime.Now.AddDays(-3),
                PetName = "Bella"
            },
            new Review
            {
                Id = 4,
                VenueId = 2,
                UserId = 4,
                UserName = "David Thompson",
                Rating = 4.0,
                Comment = "Nice atmosphere and good coffee. The outdoor patio is lovely. Gets pretty crowded on weekends though.",
                VisitDate = DateTime.Now.AddDays(-20),
                PetName = "Charlie"
            },
            new Review
            {
                Id = 5,
                VenueId = 3,
                UserId = 5,
                UserName = "Jessica Lee",
                Rating = 5.0,
                Comment = "Stayed here during our vacation and it was incredible! The pet suites are luxurious and the staff went above and beyond for our two cats.",
                VisitDate = DateTime.Now.AddDays(-30),
                PetName = "Whiskers & Mittens"
            },
            new Review
            {
                Id = 6,
                VenueId = 4,
                UserId = 6,
                UserName = "Robert Garcia",
                Rating = 4.5,
                Comment = "Perfect beach for dogs! Mine loved the swimming area. The rinse station is a lifesaver. Could use more parking though.",
                VisitDate = DateTime.Now.AddDays(-12),
                PetName = "Rocky"
            },
            new Review
            {
                Id = 7,
                VenueId = 5,
                UserId = 7,
                UserName = "Amanda Martinez",
                Rating = 4.5,
                Comment = "Excellent selection of products and the staff really knows their stuff. Prices are a bit high but the quality is worth it.",
                VisitDate = DateTime.Now.AddDays(-5),
                PetName = "Fluffy"
            },
            new Review
            {
                Id = 8,
                VenueId = 6,
                UserId = 8,
                UserName = "Christopher Brown",
                Rating = 4.0,
                Comment = "Lovely restaurant with great food. The pet-friendly patio is charming. Service was a bit slow but overall a nice experience.",
                VisitDate = DateTime.Now.AddDays(-18),
                PetName = "Buddy"
            }
        };
    }
}
