namespace MyPetVenues.Models;

public enum VenueType
{
    Park, Restaurant, Cafe, Hotel, Store, Beach, DayCare, Grooming, VetClinic
}

public enum PetType
{
    Dog, Cat, Bird, Rabbit, SmallPet, All
}

public class Venue
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string City { get; set; } = string.Empty;
    public string ImageUrl { get; set; } = string.Empty;
    public double Rating { get; set; }
    public int ReviewCount { get; set; }
    public VenueType Type { get; set; }
    public List<PetType> AllowedPets { get; set; } = [];
    public List<string> Amenities { get; set; } = [];
    public Dictionary<string, string> OpeningHours { get; set; } = new();
    public bool IsFeatured { get; set; }
    public string ContactPhone { get; set; } = string.Empty;
    public string Website { get; set; } = string.Empty;
}
