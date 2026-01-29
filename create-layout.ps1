# Create Header.razor
$headerContent = @'
@using MyPetVenues.Services
@inject IThemeService ThemeService
@inject NavigationManager NavigationManager

<header class="header">
    <a href="#main-content" class="skip-link">Skip to content</a>
    
    <div class="header-container">
        <a href="/" class="logo">
            <span class="logo-icon">🐾</span>
            <span class="logo-text">MyPetVenues</span>
        </a>
        
        <nav class="nav" aria-label="Main navigation">
            <a href="/" class="nav-link @(IsActive("/") ? "active" : "")">Home</a>
            <a href="/venues" class="nav-link @(IsActive("/venues") ? "active" : "")">Venues</a>
            <a href="/booking" class="nav-link @(IsActive("/booking") ? "active" : "")">Book Now</a>
            <a href="/profile" class="nav-link @(IsActive("/profile") ? "active" : "")">Profile</a>
        </nav>
        
        <button class="theme-toggle" @onclick="ThemeService.ToggleTheme" aria-label="Toggle theme">
            @if (ThemeService.IsDarkMode)
            {
                <span>☀️</span>
            }
            else
            {
                <span>🌙</span>
            }
        </button>
        
        <button class="mobile-menu-toggle" @onclick="ToggleMobileMenu" aria-label="Toggle menu">
            <span class="hamburger"></span>
        </button>
    </div>
    
    @if (isMobileMenuOpen)
    {
        <div class="mobile-menu">
            <a href="/" class="mobile-nav-link" @onclick="CloseMobileMenu">Home</a>
            <a href="/venues" class="mobile-nav-link" @onclick="CloseMobileMenu">Venues</a>
            <a href="/booking" class="mobile-nav-link" @onclick="CloseMobileMenu">Book Now</a>
            <a href="/profile" class="mobile-nav-link" @onclick="CloseMobileMenu">Profile</a>
        </div>
    }
</header>

@code {
    private bool isMobileMenuOpen;
    
    private bool IsActive(string path)
    {
        return NavigationManager.Uri.EndsWith(path) || 
               (path != "/" && NavigationManager.Uri.Contains(path));
    }
    
    private void ToggleMobileMenu()
    {
        isMobileMenuOpen = !isMobileMenuOpen;
    }
    
    private void CloseMobileMenu()
    {
        isMobileMenuOpen = false;
    }
}
'@

# Create Header.razor.css
$headerCss = @'
.header {
    background: var(--card-bg);
    backdrop-filter: blur(10px);
    border-bottom: 1px solid var(--card-border);
    position: sticky;
    top: 0;
    z-index: 1000;
    box-shadow: var(--shadow-sm);
}

.header-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 1400px;
    margin: 0 auto;
    padding: var(--space-4) var(--space-6);
}

.logo {
    display: flex;
    align-items: center;
    gap: var(--space-2);
    text-decoration: none;
    font-size: 1.5rem;
    font-weight: 800;
    transition: transform var(--transition-fast);
}

.logo:hover {
    transform: scale(1.05);
}

.logo-icon {
    font-size: 2rem;
}

.logo-text {
    background: var(--text-gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.nav {
    display: flex;
    gap: var(--space-6);
}

.nav-link {
    color: var(--text-secondary);
    text-decoration: none;
    font-weight: 600;
    padding: var(--space-2) var(--space-3);
    border-radius: var(--radius-md);
    transition: all var(--transition-base);
    position: relative;
}

.nav-link:hover {
    color: var(--accent-primary);
    transform: translateY(-2px);
}

.nav-link.active {
    background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
    color: white;
    box-shadow: var(--shadow-sm);
}

.theme-toggle {
    background: none;
    border: 2px solid var(--card-border);
    border-radius: var(--radius-full);
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    font-size: 1.25rem;
    transition: all var(--transition-base);
}

.theme-toggle:hover {
    border-color: var(--accent-primary);
    transform: rotate(15deg) scale(1.1);
}

.mobile-menu-toggle {
    display: none;
    background: none;
    border: none;
    cursor: pointer;
    padding: var(--space-2);
}

.mobile-menu {
    display: none;
}

@media (max-width: 900px) {
    .nav {
        display: none;
    }
    
    .mobile-menu-toggle {
        display: block;
    }
    
    .mobile-menu {
        display: flex;
        flex-direction: column;
        padding: var(--space-4);
        gap: var(--space-2);
        background: var(--bg-secondary);
        animation: fadeIn 0.3s ease-out;
    }
    
    .mobile-nav-link {
        padding: var(--space-3) var(--space-4);
        border-radius: var(--radius-md);
        color: var(--text-primary);
        text-decoration: none;
        font-weight: 600;
        transition: all var(--transition-base);
    }
    
    .mobile-nav-link:hover {
        background: var(--accent-primary);
        color: white;
    }
}
'@

# Create Footer.razor
$footerContent = @'
<footer class="footer">
    <div class="footer-container">
        <div class="footer-section">
            <div class="footer-brand">
                <span class="footer-logo">🐾</span>
                <h3>MyPetVenues</h3>
                <p>Discover the best pet-friendly places near you</p>
            </div>
        </div>
        
        <div class="footer-section">
            <h4>Explore</h4>
            <ul>
                <li><a href="/venues?type=Park">Parks</a></li>
                <li><a href="/venues?type=Cafe">Cafés</a></li>
                <li><a href="/venues?type=Restaurant">Restaurants</a></li>
                <li><a href="/venues?type=Hotel">Hotels</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h4>Resources</h4>
            <ul>
                <li><a href="#">Pet Care Tips</a></li>
                <li><a href="#">Travel Guides</a></li>
                <li><a href="#">Blog</a></li>
                <li><a href="#">Help Center</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h4>Company</h4>
            <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Contact</a></li>
                <li><a href="#">Careers</a></li>
                <li><a href="#">Press</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h4>Connect</h4>
            <div class="social-links">
                <a href="#" aria-label="Facebook">📘</a>
                <a href="#" aria-label="Twitter">🐦</a>
                <a href="#" aria-label="Instagram">📷</a>
                <a href="#" aria-label="TikTok">🎵</a>
            </div>
        </div>
    </div>
    
    <div class="footer-bottom">
        <p>© 2026 MyPetVenues. Made with 💖 for pets and their humans 🐾</p>
    </div>
</footer>
'@

# Create Footer.razor.css
$footerCss = @'
.footer {
    background: var(--bg-secondary);
    border-top: 1px solid var(--card-border);
    margin-top: var(--space-16);
}

.footer-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: var(--space-12) var(--space-6) var(--space-8);
    display: grid;
    grid-template-columns: 2fr repeat(4, 1fr);
    gap: var(--space-8);
}

.footer-section h3,
.footer-section h4 {
    margin-bottom: var(--space-4);
    color: var(--text-primary);
}

.footer-brand {
    display: flex;
    flex-direction: column;
    gap: var(--space-2);
}

.footer-logo {
    font-size: 3rem;
}

.footer-section ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    flex-direction: column;
    gap: var(--space-2);
}

.footer-section a {
    color: var(--text-secondary);
    text-decoration: none;
    transition: color var(--transition-fast);
}

.footer-section a:hover {
    color: var(--accent-primary);
}

.social-links {
    display: flex;
    gap: var(--space-3);
    font-size: 1.5rem;
}

.footer-bottom {
    border-top: 1px solid var(--card-border);
    padding: var(--space-6);
    text-align: center;
    color: var(--text-muted);
}

@media (max-width: 900px) {
    .footer-container {
        grid-template-columns: 1fr;
        gap: var(--space-6);
    }
}
'@

# Write files
$headerContent | Out-File -FilePath "C:\Dev\wt-layout\MyPetVenues\Layout\Header.razor" -Encoding utf8
$headerCss | Out-File -FilePath "C:\Dev\wt-layout\MyPetVenues\Layout\Header.razor.css" -Encoding utf8
$footerContent | Out-File -FilePath "C:\Dev\wt-layout\MyPetVenues\Layout\Footer.razor" -Encoding utf8
$footerCss | Out-File -FilePath "C:\Dev\wt-layout\MyPetVenues\Layout\Footer.razor.css" -Encoding utf8

Write-Host "✅ Layout files created successfully"
