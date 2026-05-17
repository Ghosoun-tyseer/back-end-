using System;
using System.Collections.Generic;

namespace OYIL.Models;

public partial class Product
{
    public int ProductId { get; set; }

    public string Name { get; set; } = null!;

    public string Description { get; set; } = null!;

    public string? ImageUrl { get; set; }

    public int? CategoryId { get; set; }

    public virtual Category? Category { get; set; }
}
