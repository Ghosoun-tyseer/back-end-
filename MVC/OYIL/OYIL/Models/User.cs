using System;
using System.Collections.Generic;

namespace OYIL.Models;

public partial class User
{
    public int UserId { get; set; }

    public string? Email { get; set; }

    public string Password { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string? Role { get; set; }
}
