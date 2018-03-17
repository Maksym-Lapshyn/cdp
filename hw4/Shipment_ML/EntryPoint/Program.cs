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

            var entity = repository.ReadOne(1);
            var entities = repository.ReadAll();

            var entity1 = new Cargo { Id = 1 };
            repository.Update(entity1);
        }
    }
}
