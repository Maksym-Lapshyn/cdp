using Core.Entities;
using System.Data.Entity;

namespace DAL.DatabaseConfiguration
{
    public class DietAssistantContext : DbContext
    {
        public DietAssistantContext()
            : base("name=DietAssistantContext")
        {
        }

        public virtual DbSet<Dish> Dishes { get; set; }

        public virtual DbSet<Parameter> Parameters { get; set; }

        public virtual DbSet<Preference> Preferences { get; set; }

        public virtual DbSet<Report> Reports { get; set; }
    }
}