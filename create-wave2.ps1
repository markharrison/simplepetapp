# Wave 2 Component Creation Script
# Creates all 5 components in their respective worktrees

# VenueCard Component
$venueCardRazor = @'
@using MyPetVenues.Models

<div class="venue-card @(IsFeatured ? "featured" : "")" @onclick="HandleClick">
    @if (IsFeatured)
    {
        <div class="featured-badge">⭐ Featured</div>
    }
    
    <div class="venue-image">
        <img src="@Venue.ImageUrl" alt="@Venue.Name" />
        <VenueTypeBadge Type="@Venue.Type" />
    </div>
    
    <div class="venue-content">
        <h3 class="venue-name">@Venue.Name</h3>
        <p class="venue-location">📍 @Venue.Address, @Venue.City</p>
        
        <div class="venue-rating">
            <StarRating Rating="@Venue.Rating" ShowValue="true" />
            <span class="review-count">(@Venue.ReviewCount reviews)</span>
        </div>
        
        <div class="venue-pets">
            @foreach (var pet in Venue.AllowedPets.Take(4))
            {
                <PetBadge Type="@pet" />
            }
            @if (Venue.AllowedPets.Count > 4)
            {
                <span class="more-pets">+@(Venue.AllowedPets.Count - 4)</span>
            }
        </div>
        
        @if (Venue.Amenities.Any())
        {
            <div class="venue-amenities">
                @foreach (var amenity in Venue.Amenities.Take(3))
                {
                    <AmenityTag Amenity="@amenity" />
                }
                @if (Venue.Amenities.Count > 3)
                {
                    <span class="more-amenities">+@(Venue.Amenities.Count - 3) more</span>
                }
            </div>
        }
    </div>
</div>

@code {
    [Parameter] public Venue Venue { get; set; } = null!;
    [Parameter] public bool IsFeatured { get; set; }
    [Parameter] public EventCallback OnClick { get; set; }

    private async Task HandleClick()
    {
        await OnClick.InvokeAsync();
    }
}
'@

$venueCardCss = @'
.venue-card {
    background: var(--card-bg);
    border: 1px solid var(--card-border);
    border-radius: var(--radius-xl);
    overflow: hidden;
    cursor: pointer;
    transition: all var(--transition-base);
    box-shadow: var(--shadow-sm);
    position: relative;
}

.venue-card:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-lg);
}

.venue-card.featured {
    border: 2px solid var(--accent-primary);
    box-shadow: 0 0 0 4px rgba(219, 39, 119, 0.1);
}

.featured-badge {
    position: absolute;
    top: var(--space-4);
    left: var(--space-4);
    background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
    color: white;
    padding: var(--space-2) var(--space-4);
    border-radius: var(--radius-full);
    font-weight: 700;
    font-size: 0.875rem;
    z-index: 10;
    box-shadow: var(--shadow-md);
}

.venue-image {
    position: relative;
    height: 240px;
    overflow: hidden;
}

.venue-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform var(--transition-slow);
}

.venue-card:hover .venue-image img {
    transform: scale(1.06);
}

.venue-content {
    padding: var(--space-6);
    display: flex;
    flex-direction: column;
    gap: var(--space-3);
}

.venue-name {
    font-size: 1.5rem;
    font-weight: 700;
    margin: 0;
    color: var(--text-primary);
}

.venue-location {
    color: var(--text-secondary);
    margin: 0;
}

.venue-rating {
    display: flex;
    align-items: center;
    gap: var(--space-2);
}

.review-count {
    color: var(--text-muted);
    font-size: 0.875rem;
}

.venue-pets {
    display: flex;
    gap: var(--space-2);
    align-items: center;
    flex-wrap: wrap;
}

.more-pets {
    font-size: 0.875rem;
    color: var(--text-muted);
}

.venue-amenities {
    display: flex;
    gap: var(--space-2);
    flex-wrap: wrap;
}

.more-amenities {
    font-size: 0.75rem;
    color: var(--text-muted);
}
'@

# StarRating Component
$starRatingRazor = @'
<div class="star-rating">
    @for (int i = 1; i <= 5; i++)
    {
        int starIndex = i;
        @if (Rating >= starIndex)
        {
            <span class="star filled">⭐</span>
        }
        else if (Rating >= starIndex - 0.5)
        {
            <span class="star half">⭐</span>
        }
        else
        {
            <span class="star empty">☆</span>
        }
    }
    @if (ShowValue)
    {
        <span class="rating-value">@Rating.ToString("0.0")</span>
    }
</div>

@code {
    [Parameter] public double Rating { get; set; }
    [Parameter] public bool ShowValue { get; set; } = true;
}
'@

$starRatingCss = @'
.star-rating {
    display: flex;
    align-items: center;
    gap: var(--space-1);
}

.star {
    font-size: 1.125rem;
    transition: transform var(--transition-fast);
}

.star.filled {
    color: #fbbf24;
}

.star.half {
    color: #fbbf24;
    opacity: 0.6;
}

.star.empty {
    color: var(--text-muted);
}

.star:hover {
    transform: scale(1.2);
}

.rating-value {
    font-weight: 600;
    color: var(--text-primary);
    margin-left: var(--space-1);
}
'@

# ReviewCard Component
$reviewCardRazor = @'
@using MyPetVenues.Models

<div class="review-card">
    <div class="review-header">
        <img src="https://i.pravatar.cc/50?u=@Review.UserId" alt="@Review.UserName" class="user-avatar" />
        <div class="user-info">
            <h4 class="user-name">@Review.UserName</h4>
            <span class="visit-date">Visited @Review.VisitDate.ToString("MMM dd, yyyy")</span>
        </div>
        <StarRating Rating="@Review.Rating" ShowValue="false" />
    </div>
    
    <p class="review-comment">@Review.Comment</p>
    
    <div class="review-footer">
        <span class="pet-name">🐾 With @Review.PetName</span>
        <button class="helpful-button">👍 Helpful</button>
    </div>
</div>

@code {
    [Parameter] public Review Review { get; set; } = null!;
}
'@

$reviewCardCss = @'
.review-card {
    background: var(--card-bg);
    border: 1px solid var(--card-border);
    border-radius: var(--radius-lg);
    padding: var(--space-6);
    transition: all var(--transition-base);
}

.review-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-md);
}

.review-header {
    display: flex;
    align-items: center;
    gap: var(--space-4);
    margin-bottom: var(--space-4);
}

.user-avatar {
    width: 50px;
    height: 50px;
    border-radius: var(--radius-full);
    border: 3px solid transparent;
    transition: border-color var(--transition-base);
}

.review-card:hover .user-avatar {
    border-color: var(--accent-primary);
}

.user-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: var(--space-1);
}

.user-name {
    font-size: 1rem;
    font-weight: 600;
    margin: 0;
}

.visit-date {
    font-size: 0.875rem;
    color: var(--text-muted);
}

.review-comment {
    color: var(--text-secondary);
    line-height: 1.6;
    margin-bottom: var(--space-4);
}

.review-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.pet-name {
    color: var(--accent-primary);
    font-weight: 500;
}

.helpful-button {
    background: none;
    border: 1px solid var(--card-border);
    border-radius: var(--radius-md);
    padding: var(--space-2) var(--space-4);
    cursor: pointer;
    font-size: 0.875rem;
    transition: all var(--transition-base);
}

.helpful-button:hover {
    background: var(--accent-primary);
    color: white;
    border-color: var(--accent-primary);
}
'@

# SearchFilters Component
$searchFiltersRazor = @'
@using MyPetVenues.Models

<div class="search-filters">
    <div class="search-input-group">
        <span class="search-icon">🔍</span>
        <input type="text" 
               class="search-input" 
               placeholder="Search venues..." 
               value="@searchTerm"
               @oninput='e => searchTerm = e.Value?.ToString() ?? ""'
               @onkeydown="HandleKeyDown" />
        @if (!string.IsNullOrWhiteSpace(searchTerm))
        {
            <button class="clear-button" @onclick="ClearSearch">✕</button>
        }
    </div>
    
    <select class="filter-select" value="@selectedVenueType" @onchange='e => selectedVenueType = e.Value?.ToString() ?? ""'>
        <option value="">All Venue Types</option>
        @foreach (var type in Enum.GetValues<VenueType>())
        {
            <option value="@type">@type</option>
        }
    </select>
    
    <select class="filter-select" value="@selectedPetType" @onchange='e => selectedPetType = e.Value?.ToString() ?? ""'>
        <option value="">All Pet Types</option>
        @foreach (var type in Enum.GetValues<PetType>())
        {
            <option value="@type">@type</option>
        }
    </select>
    
    <button class="search-button btn-primary" @onclick="HandleSearch">Search</button>
</div>

@code {
    [Parameter] public string? SearchTerm { get; set; }
    [Parameter] public VenueType? SelectedVenueType { get; set; }
    [Parameter] public PetType? SelectedPetType { get; set; }
    [Parameter] public EventCallback<(string?, VenueType?, PetType?)> OnSearch { get; set; }

    private string searchTerm = "";
    private string selectedVenueType = "";
    private string selectedPetType = "";

    protected override void OnParametersSet()
    {
        searchTerm = SearchTerm ?? "";
        selectedVenueType = SelectedVenueType?.ToString() ?? "";
        selectedPetType = SelectedPetType?.ToString() ?? "";
    }

    private async Task HandleSearch()
    {
        VenueType? venueType = string.IsNullOrEmpty(selectedVenueType) ? null : Enum.Parse<VenueType>(selectedVenueType);
        PetType? petType = string.IsNullOrEmpty(selectedPetType) ? null : Enum.Parse<PetType>(selectedPetType);
        
        await OnSearch.InvokeAsync((searchTerm, venueType, petType));
    }

    private async Task ClearSearch()
    {
        searchTerm = "";
        selectedVenueType = "";
        selectedPetType = "";
        await HandleSearch();
    }

    private async Task HandleKeyDown(KeyboardEventArgs e)
    {
        if (e.Key == "Enter")
        {
            await HandleSearch();
        }
        else if (e.Key == "Escape")
        {
            await ClearSearch();
        }
    }
}
'@

$searchFiltersCss = @'
.search-filters {
    background: var(--card-bg);
    padding: var(--space-6);
    border-radius: var(--radius-xl);
    box-shadow: var(--shadow-md);
    display: grid;
    grid-template-columns: 2fr 1fr 1fr auto;
    gap: var(--space-4);
}

.search-input-group {
    position: relative;
    display: flex;
    align-items: center;
}

.search-icon {
    position: absolute;
    left: var(--space-4);
    font-size: 1.25rem;
    pointer-events: none;
}

.search-input {
    width: 100%;
    padding: var(--space-3) var(--space-4) var(--space-3) var(--space-12);
    border: 2px solid var(--card-border);
    border-radius: var(--radius-lg);
    font-size: 1rem;
    background: var(--bg-secondary);
    color: var(--text-primary);
    transition: all var(--transition-base);
}

.search-input:focus {
    outline: none;
    border-color: var(--accent-primary);
    box-shadow: 0 0 0 4px rgba(219, 39, 119, 0.1);
}

.clear-button {
    position: absolute;
    right: var(--space-3);
    background: none;
    border: none;
    font-size: 1.25rem;
    cursor: pointer;
    color: var(--text-muted);
    transition: color var(--transition-fast);
}

.clear-button:hover {
    color: var(--accent-primary);
}

.filter-select {
    padding: var(--space-3) var(--space-4);
    border: 2px solid var(--card-border);
    border-radius: var(--radius-lg);
    font-size: 1rem;
    background: var(--bg-secondary);
    color: var(--text-primary);
    cursor: pointer;
    transition: all var(--transition-base);
}

.filter-select:focus {
    outline: none;
    border-color: var(--accent-primary);
    box-shadow: 0 0 0 4px rgba(219, 39, 119, 0.1);
}

.search-button {
    white-space: nowrap;
}

@media (max-width: 900px) {
    .search-filters {
        grid-template-columns: 1fr;
    }
}
'@

# Badge Components
$venueTypeBadgeRazor = @'
@using MyPetVenues.Models

<span class="venue-type-badge @GetTypeClass()">
    @GetEmoji() @Type
</span>

@code {
    [Parameter] public VenueType Type { get; set; }

    private string GetTypeClass() => Type switch
    {
        VenueType.Park => "type-park",
        VenueType.Restaurant => "type-restaurant",
        VenueType.Cafe => "type-cafe",
        VenueType.Hotel => "type-hotel",
        VenueType.Store => "type-store",
        VenueType.Beach => "type-beach",
        VenueType.DayCare => "type-daycare",
        VenueType.Grooming => "type-grooming",
        VenueType.VetClinic => "type-vet",
        _ => ""
    };

    private string GetEmoji() => Type switch
    {
        VenueType.Park => "🌳",
        VenueType.Restaurant => "🍽️",
        VenueType.Cafe => "☕",
        VenueType.Hotel => "🏨",
        VenueType.Store => "🛍️",
        VenueType.Beach => "🏖️",
        VenueType.DayCare => "🎨",
        VenueType.Grooming => "✂️",
        VenueType.VetClinic => "⚕️",
        _ => "📍"
    };
}
'@

$venueTypeBadgeCss = @'
.venue-type-badge {
    display: inline-flex;
    align-items: center;
    gap: var(--space-1);
    padding: var(--space-2) var(--space-4);
    border-radius: var(--radius-full);
    font-size: 0.875rem;
    font-weight: 600;
    position: absolute;
    bottom: var(--space-4);
    right: var(--space-4);
    backdrop-filter: blur(8px);
    box-shadow: var(--shadow-sm);
}

.type-park { background: rgba(34, 197, 94, 0.9); color: white; }
.type-restaurant { background: rgba(239, 68, 68, 0.9); color: white; }
.type-cafe { background: rgba(168, 85, 47, 0.9); color: white; }
.type-hotel { background: rgba(59, 130, 246, 0.9); color: white; }
.type-store { background: rgba(168, 85, 247, 0.9); color: white; }
.type-beach { background: rgba(6, 182, 212, 0.9); color: white; }
.type-daycare { background: rgba(251, 146, 60, 0.9); color: white; }
.type-grooming { background: rgba(236, 72, 153, 0.9); color: white; }
.type-vet { background: rgba(14, 165, 233, 0.9); color: white; }
'@

$petBadgeRazor = @'
@using MyPetVenues.Models

<span class="pet-badge" title="@Type">@GetEmoji()</span>

@code {
    [Parameter] public PetType Type { get; set; }

    private string GetEmoji() => Type switch
    {
        PetType.Dog => "🐕",
        PetType.Cat => "🐱",
        PetType.Bird => "🐦",
        PetType.Rabbit => "🐰",
        PetType.SmallPet => "🐹",
        PetType.All => "🐾",
        _ => "🐾"
    };
}
'@

$petBadgeCss = @'
.pet-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 32px;
    height: 32px;
    background: var(--bg-secondary);
    border: 2px solid var(--card-border);
    border-radius: var(--radius-full);
    font-size: 1.125rem;
    transition: all var(--transition-base);
}

.pet-badge:hover {
    transform: scale(1.15);
    border-color: var(--accent-primary);
}
'@

$amenityTagRazor = @'
<span class="amenity-tag">@Amenity</span>

@code {
    [Parameter] public string Amenity { get; set; } = "";
}
'@

$amenityTagCss = @'
.amenity-tag {
    display: inline-block;
    padding: var(--space-1) var(--space-3);
    background: var(--bg-secondary);
    border: 1px solid var(--card-border);
    border-radius: var(--radius-full);
    font-size: 0.75rem;
    color: var(--text-secondary);
    transition: all var(--transition-base);
}

.amenity-tag:hover {
    background: var(--accent-primary);
    color: white;
    border-color: var(--accent-primary);
}
'@

# Write all files to their respective worktrees
$venueCardRazor | Out-File "C:\Dev\wt-venuecard\MyPetVenues\Components\VenueCard.razor" -Encoding utf8
$venueCardCss | Out-File "C:\Dev\wt-venuecard\MyPetVenues\Components\VenueCard.razor.css" -Encoding utf8

$starRatingRazor | Out-File "C:\Dev\wt-starrating\MyPetVenues\Components\StarRating.razor" -Encoding utf8
$starRatingCss | Out-File "C:\Dev\wt-starrating\MyPetVenues\Components\StarRating.razor.css" -Encoding utf8

$reviewCardRazor | Out-File "C:\Dev\wt-reviewcard\MyPetVenues\Components\ReviewCard.razor" -Encoding utf8
$reviewCardCss | Out-File "C:\Dev\wt-reviewcard\MyPetVenues\Components\ReviewCard.razor.css" -Encoding utf8

$searchFiltersRazor | Out-File "C:\Dev\wt-searchfilters\MyPetVenues\Components\SearchFilters.razor" -Encoding utf8
$searchFiltersCss | Out-File "C:\Dev\wt-searchfilters\MyPetVenues\Components\SearchFilters.razor.css" -Encoding utf8

$venueTypeBadgeRazor | Out-File "C:\Dev\wt-badges\MyPetVenues\Components\VenueTypeBadge.razor" -Encoding utf8
$venueTypeBadgeCss | Out-File "C:\Dev\wt-badges\MyPetVenues\Components\VenueTypeBadge.razor.css" -Encoding utf8
$petBadgeRazor | Out-File "C:\Dev\wt-badges\MyPetVenues\Components\PetBadge.razor" -Encoding utf8
$petBadgeCss | Out-File "C:\Dev\wt-badges\MyPetVenues\Components\PetBadge.razor.css" -Encoding utf8
$amenityTagRazor | Out-File "C:\Dev\wt-badges\MyPetVenues\Components\AmenityTag.razor" -Encoding utf8
$amenityTagCss | Out-File "C:\Dev\wt-badges\MyPetVenues\Components\AmenityTag.razor.css" -Encoding utf8

Write-Host "✅ Wave 2 components created successfully"
