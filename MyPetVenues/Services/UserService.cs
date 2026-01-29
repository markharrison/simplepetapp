using MyPetVenues.Models;

namespace MyPetVenues.Services;

public interface IUserService
{
    Task<User> GetCurrentUserAsync();
    Task UpdateUserAsync(User user);
    Task AddFavoriteVenueAsync(int venueId);
    Task RemoveFavoriteVenueAsync(int venueId);
}

public class MockUserService : IUserService
{
    private User _currentUser;

    public MockUserService()
    {
        _currentUser = GenerateMockUser();
    }

    public Task<User> GetCurrentUserAsync()
    {
        return Task.FromResult(_currentUser);
    }

    public Task UpdateUserAsync(User user)
    {
        _currentUser = user;
        return Task.CompletedTask;
    }

    public Task AddFavoriteVenueAsync(int venueId)
    {
        if (!_currentUser.FavoriteVenueIds.Contains(venueId))
        {
            _currentUser.FavoriteVenueIds.Add(venueId);
        }
        return Task.CompletedTask;
    }

    public Task RemoveFavoriteVenueAsync(int venueId)
    {
        _currentUser.FavoriteVenueIds.Remove(venueId);
        return Task.CompletedTask;
    }

    private static User GenerateMockUser()
    {
        return new User
        {
            Id = 1,
            Name = "Alex Morgan",
            Email = "alex.morgan@example.com",
            ProfileImageUrl = "https://i.pravatar.cc/150?img=33",
            Pets = new List<Pet>
            {
                new Pet
                {
                    Name = "Max",
                    Type = PetType.Dog,
                    Breed = "Golden Retriever",
                    Age = 3,
                    ImageUrl = "https://images.unsplash.com/photo-1633722715463-d30f4f325e24?w=400"
                },
                new Pet
                {
                    Name = "Luna",
                    Type = PetType.Cat,
                    Breed = "Siamese",
                    Age = 2,
                    ImageUrl = "https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400"
                }
            },
            FavoriteVenueIds = new List<int> { 1, 2, 3 },
            Bookings = new List<Booking>()
        };
    }
}
