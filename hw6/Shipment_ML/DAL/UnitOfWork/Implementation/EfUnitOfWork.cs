using Core.Entities;
using DAL.Context;
using DAL.Repositories.Implementations;
using DAL.Repositories.Interfaces;
using DAL.UnitOfWork.Interfaces;
using System;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;

namespace DAL.UnitOfWork.Implementation
{
    public class EfUnitOfWork : IRepositoryWrapper, IDisconnectedUnitOfWork, IDisposable
    {
        private readonly DbContext _context;
        private readonly Lazy<IRepository<Route>> _lazyRouteRepository;
        private readonly Lazy<IRepository<Warehouse>> _lazyWarehouseRepository;

        public EfUnitOfWork()
        {
            var connectionString = "data source=.;initial catalog=Shipment_ML;integrated security=True;MultipleActiveResultSets=True;App=EntityFramework";
            _context = new EfContext(connectionString);
            _lazyWarehouseRepository = new Lazy<IRepository<Warehouse>>(() => new EfRepository<Warehouse>(_context));
            _lazyRouteRepository = new Lazy<IRepository<Route>>(() => new EfRepository<Route>(_context));
        }

        public IRepository<Route> RouteRepository => _lazyRouteRepository.Value;

        public IRepository<Warehouse> WarehouseRepository => _lazyWarehouseRepository.Value;

        public void LoadEntities()
        {
            foreach (var entity in _context.ChangeTracker.Entries())
            {
                entity.Reload();
            }
        }

        public void SaveChanges()
        {
            try
            {
                _context.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw new InvalidOperationException("The entity you are trying to modify is outdated, try querying it again.");
            }
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
