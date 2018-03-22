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
            var repository = new ConnectedRepository<Cargo>();

			//var entity = repository.ReadOne(1);
			//var entities = repository.ReadAll();

			var entity = new Cargo
			{
				Id = 1,
				Weight = 55555,
				Volume = 55555,
				SenderId = 1,
				RecipientId = 1,
				ShipmentId = 855
			};

	        repository.Create(entity);

	        //repository.Update(entity);
        }
	}
}
