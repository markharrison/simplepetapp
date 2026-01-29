using MyPetVenues.Models;

namespace MyPetVenues.Services;

public interface IBookingService
{
    Task<List<Booking>> GetUserBookingsAsync();
    Task<Booking> CreateBookingAsync(Booking booking);
    Task CancelBookingAsync(int bookingId);
}

public class MockBookingService : IBookingService
{
    private readonly List<Booking> _bookings;
    private int _nextId = 3;

    public MockBookingService()
    {
        _bookings = GenerateMockBookings();
    }

    public Task<List<Booking>> GetUserBookingsAsync()
    {
        return Task.FromResult(_bookings.OrderByDescending(b => b.BookingDate).ToList());
    }

    public Task<Booking> CreateBookingAsync(Booking booking)
    {
        booking.Id = _nextId++;
        booking.Status = BookingStatus.Pending;
        _bookings.Add(booking);
        return Task.FromResult(booking);
    }

    public Task CancelBookingAsync(int bookingId)
    {
        var booking = _bookings.FirstOrDefault(b => b.Id == bookingId);
        if (booking != null)
        {
            booking.Status = BookingStatus.Cancelled;
        }
        return Task.CompletedTask;
    }

    private static List<Booking> GenerateMockBookings()
    {
        return new List<Booking>
        {
            new Booking
            {
                Id = 1,
                UserId = 1,
                VenueId = 3,
                BookingDate = DateTime.Now.AddDays(7),
                TimeSlot = "2:00 PM - 4:00 PM",
                NumberOfPets = 2,
                Notes = "Checking in with Max and Luna for weekend getaway",
                Status = BookingStatus.Confirmed
            },
            new Booking
            {
                Id = 2,
                UserId = 1,
                VenueId = 1,
                BookingDate = DateTime.Now.AddDays(-10),
                TimeSlot = "10:00 AM - 12:00 PM",
                NumberOfPets = 1,
                Notes = "Playtime session for Max",
                Status = BookingStatus.Completed
            }
        };
    }
}
