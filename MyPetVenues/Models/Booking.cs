namespace MyPetVenues.Models;

public enum BookingStatus
{
    Pending, Confirmed, Cancelled, Completed
}

public class Booking
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public int VenueId { get; set; }
    public DateTime BookingDate { get; set; }
    public string TimeSlot { get; set; } = string.Empty;
    public int NumberOfPets { get; set; }
    public string Notes { get; set; } = string.Empty;
    public BookingStatus Status { get; set; }
}
