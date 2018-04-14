using Core.Entities;
using DAL.UnitOfWork.Implementation;
using System;
using Xunit;

namespace Tests.DAL
{
    public class EfUnitOfWorkTests : IDisposable
    {
        private readonly int _testEntityId;
        private readonly EfUnitOfWork _firstUow;
        private readonly EfUnitOfWork _secondUow;

        public EfUnitOfWorkTests()
        {
            _firstUow = new EfUnitOfWork();
            _secondUow = new EfUnitOfWork();

            var testEntity = new Warehouse
            {
                City = "Initial City",
                State = "Initial State"
            };

            testEntity = _firstUow.WarehouseRepository.Create(testEntity);

            _firstUow.SaveChanges();

            _testEntityId = testEntity.Id;
        }

        public void Dispose()
        {
            _firstUow.WarehouseRepository.Delete(_testEntityId);
            _firstUow.SaveChanges();
        }

        [Fact]
        public void OnlyStoreWinsStrategy_Works()
        {
            var firstEntityCopy = _firstUow.WarehouseRepository.ReadOne(_testEntityId);
            var secondEntityCopy = _secondUow.WarehouseRepository.ReadOne(_testEntityId);
            firstEntityCopy.City = "Changed City";
            secondEntityCopy.State = "Changed State";

            _firstUow.WarehouseRepository.Update(firstEntityCopy);
            _secondUow.WarehouseRepository.Update(secondEntityCopy);
            _firstUow.SaveChanges();

            Assert.Throws<InvalidOperationException>(() =>
            {
                _secondUow.SaveChanges();
            });

            firstEntityCopy = _firstUow.WarehouseRepository.ReadOne(_testEntityId);

            Assert.Equal("Initial State", firstEntityCopy.State);
        }
    }
}
