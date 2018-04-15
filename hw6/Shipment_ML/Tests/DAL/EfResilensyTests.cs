using DAL.UnitOfWork.Implementation;
using Xunit;

namespace Tests.DAL
{
    public class EfResilensyTests
    {
        private readonly EfUnitOfWork _unitOfWork;

        public EfResilensyTests()
        {
            _unitOfWork = new EfUnitOfWork();
        }

        [Fact]
        public void ConnectionResilency_Works()
        {
            var entity = _unitOfWork.WarehouseRepository.ReadOne(1);

            Assert.NotNull(entity);
        }
    }
}
