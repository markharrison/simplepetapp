namespace MyPetVenues.Models;

public class Pet
{
    public string Name { get; set; } = string.Empty;
    public PetType Type { get; set; }
    public string Breed { get; set; } = string.Empty;
    public int Age { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
}

public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string ProfileImageUrl { get; set; } = string.Empty;
    public List<Pet> Pets { get; set; } = [];
    public List<int> FavoriteVenueIds { get; set; } = [];
    public List<Booking> Bookings { get; set; } = [];
}
