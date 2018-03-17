using Core.Entities;
using DAL.Repositories.Implementations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntryPoint
{
    class Program
    {
        static void Main(string[] args)
        {
            var repository = new Repository<Cargo>();

            //var entity = repository.ReadOne(1);
            //var entities = repository.ReadAll();

            //var entity = new Cargo
            //{
            //    Id = 1,
            //    Weight = 11111,
            //    Volume = 42,
            //    SenderId = 1,
            //    RecipientId = 1,
            //    ShipmentId = 855
            //};

            //repository.Update(entity);
        }
    }
}
