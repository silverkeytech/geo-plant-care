using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using EdgeDB;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;
using System;
using System.Text.Json.Serialization;
using System.Text;
using Microsoft.AspNetCore.Identity;



namespace GeoPlantCare.Pages;

public class SignUpModel : PageModel
{
    private readonly ILogger<PlantModel> _logger;
    private readonly EdgeDBClient _client;
    private readonly PasswordHasher<User> _passwordHasher;

    [BindProperty]
    public User SignUpUser { get; set; }

    public SignUpModel(ILogger<PlantModel> logger, EdgeDBClient client, PasswordHasher<User> passwordHasher)
    {
        _logger = logger;
        _client = client;
        _passwordHasher = passwordHasher;
    }

    // public async Task<IActionResult> OnPostSignUpAsync()
    // {
    //     if (!ModelState.IsValid)
    //     {
    //         // Return the page with validation errors.
    //         return Page();
    //     }

    //     // Hash the user's password.
    //     var passwordHasher = new PasswordHasher<User>();
    //     SignUpUser.Password = passwordHasher.HashPassword(null, SignUpUser.Password);

    //     // Save the user to the database.
    //     //var result = await _client.QueryAsync<User>()

    //     if (result)
    //     {
    //         // Redirect the user to a confirmation page.
    //         return RedirectToPage("Confirmation");
    //     }
    //     else
    //     {
    //         // Add an error message to the model and return the page.
    //         ModelState.AddModelError("", "An error occurred while creating the account.");
    //         return Page();
    //     }
    // }
}

public class User
{
    public string Username { get; set; }
    public string FirstName { get; set; }

    public string LastName { get; set; }
    public string Email { get; set; }
    public string Password { get; set; }
    
}