using Core.Entities;
using Core.Exceptions;
using DAL.DatabaseConfiguration;
using DAL.Repositories.Implementations;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Tests.Repositories
{
    [TestFixture]
    public class RepositoryTests
    {
        private const int ValidId = 1;
        private const int InvalidId = 2;

        private readonly Mock<DietAssistantContext> _contextMock;
        private readonly Mock<DbSet<Dish>> _dbSetMock;
        private readonly Repository<Dish> _target;

        public RepositoryTests()
        {
            _contextMock = new Mock<DietAssistantContext>();
            _dbSetMock = new Mock<DbSet<Dish>>();

            _contextMock.Setup(m => m.Set<Dish>()).Returns(_dbSetMock.Object);

            _target = new Repository<Dish>(_contextMock.Object);
        }

        [Test]
        public void Create_ReturnsEntityCreatedByDbSet_WhenAnyEntityIsPassed()
        {
            var newEntity = new Dish();
            var entity = new Dish();

            _dbSetMock.Setup(m => m.Add(entity)).Returns(newEntity);

            var result = _target.Create(entity);

            Assert.AreEqual(newEntity, result);
        }

        [Test]
        public void Read_ReturnsEntityFoundByDbSet_WhenAnyIdIsPassed()
        {
            var entity = new Dish();

            _dbSetMock.Setup(m => m.Find(InvalidId)).Returns(entity);

            var result = _target.Read(InvalidId);

            Assert.AreEqual(entity, result);
        }

        [Test]
        public void Update_ThrowsException_WhenEntityWithInvalidIdIsPassed()
        {
            var entity = new Dish
            {
                Id = InvalidId
            };

            _dbSetMock.Setup(m => m.Find(InvalidId)).Throws<NotFoundException>();

            Assert.Throws<NotFoundException>(() => _target.Update(entity));
        }

        [Test]
        public void Delete_ThrowsException_WhenInvalidIdIsPassed()
        {
            _dbSetMock.Setup(m => m.Find(InvalidId)).Throws<NotFoundException>();

            Assert.Throws<NotFoundException>(() => _target.Delete(InvalidId));
        }

        [Test]
        public void Delete_CallsDeleteOnce_WhenValidIdIsPassed()
        {
            var entity = new Dish();

            _dbSetMock.Setup(m => m.Find(ValidId)).Returns(entity);

            _target.Delete(ValidId);

            _dbSetMock.Verify(m => m.Remove(entity), Times.Once);
        }
    }
}
