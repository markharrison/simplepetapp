namespace MyPetVenues.Models;

public class Review
{
    public int Id { get; set; }
    public int VenueId { get; set; }
    public int UserId { get; set; }
    public string UserName { get; set; } = string.Empty;
    public double Rating { get; set; }
    public string Comment { get; set; } = string.Empty;
    public DateTime VisitDate { get; set; }
    public string PetName { get; set; } = string.Empty;
}
