using DAL.UnitOfWork.Implementation;
using System;
using System.Data;
using System.IO;
using System.Diagnostics;
using Xunit;
using Core.Entities;
using System.Collections.Generic;
using System.Linq;

namespace Tests.Performance
{
    public class UnitOfWorkTests
    {
        private const int WriteSampleSize = 100;
        private const int ReadSampleSize = 1000;
        private const int TriesCount = 3;

        private readonly ConnectedUnitOfWork _connectedUnitOfWork;
        private readonly DisconnectedUnitOfWork _disconnectedUnitOfWork;
        private readonly DapperUnitOfWork _dapperUnitOfWork;
        private readonly EfUnitOfWork _efUnitOfWork;
        private readonly string _logFilePath;
        private readonly List<Warehouse> _testWarehouses;

        public UnitOfWorkTests()
        {
            _connectedUnitOfWork = new ConnectedUnitOfWork();
            _disconnectedUnitOfWork = new DisconnectedUnitOfWork();
            _dapperUnitOfWork = new DapperUnitOfWork();
            _efUnitOfWork = new EfUnitOfWork();
            _logFilePath = GetLogFilePath();
            _testWarehouses = GenerateTestWarehouses(WriteSampleSize);
        }

        [Fact]
        public void Test_RepositoriesWriteMethods()
        {
            WriteToFile("___________________________________________________________", _logFilePath);
            WriteToFile($"{DateTime.Now} ->> Start Repositories Write Test", _logFilePath);

            var connectedWriteResults = new List<double>();
            var disconnectedWriteResults = new List<double>();
            var dapperWriteResults = new List<double>();
            var efWriteResults = new List<double>();

            for (var i = 0; i < TriesCount; i++)
            {
                var connectedResult = RunConnectedRepositoryWriteMethod(_testWarehouses);

                connectedWriteResults.Add(connectedResult);
                WriteToFile($"Connected Repository {i} Run ->> Write Speed = {connectedResult} ms", _logFilePath);

                var disconnectedResult = RunDisconnectedRepositoryWriteMethod(_testWarehouses);

                disconnectedWriteResults.Add(disconnectedResult);
                WriteToFile($"Disconnected Repository {i} Run ->> Write Speed = {disconnectedResult} ms", _logFilePath);

                var dapperWriteResult = RunDapperRepositoryWriteMethod(_testWarehouses);

                dapperWriteResults.Add(dapperWriteResult);
                WriteToFile($"Dapper Repository {i} Run ->> Write Speed = {dapperWriteResult} ms", _logFilePath);

                var efWriteResult = RunEfRepositoryWriteMethod(_testWarehouses);

                efWriteResults.Add(efWriteResult);
                WriteToFile($"Ef Repository {i} Run ->> Write Speed = {efWriteResult} ms", _logFilePath);
            }

            var connectedAverage = connectedWriteResults.Sum() / WriteSampleSize;
            var disconnectedAverage = disconnectedWriteResults.Sum() / WriteSampleSize;
            var dapperAverage = dapperWriteResults.Sum() / WriteSampleSize;
            var efAverage = efWriteResults.Sum() / WriteSampleSize;

            WriteToFile($"Connected Repository Average ->> Write Speed = {connectedAverage} ms", _logFilePath);
            WriteToFile($"Disconnected Repository Average ->> Write Speed = {disconnectedAverage} ms", _logFilePath);
            WriteToFile($"Dapper Repository Average ->> Write Speed = {dapperAverage} ms", _logFilePath);
            WriteToFile($"Ef Repository Average ->> Write Speed = {efAverage} ms", _logFilePath);

            WriteToFile($"{DateTime.Now} ->> End Repositories Write Test", _logFilePath);
            WriteToFile("___________________________________________________________", _logFilePath);
        }

        [Fact]
        public void Test_RepositoriesReadMethods()
        {
            WriteToFile("___________________________________________________________", _logFilePath);
            WriteToFile($"{DateTime.Now} ->> Start Repositories Read Test", _logFilePath);

            var connectedReadResults = new List<double>();
            var disconnectedReadResults = new List<double>();
            var dapperReadResults = new List<double>();
            var efReadResults = new List<double>();

            for (var i = 0; i < TriesCount; i++)
            {
                var connectedResult = RunConnectedRepositoryReadMethod(ReadSampleSize);

                connectedReadResults.Add(connectedResult);
                WriteToFile($"Connected Repository {i} Run ->> Read Speed = {connectedResult} ms", _logFilePath);

                var disconnectedResult = RunDisconnectedRepositoryReadMethod(ReadSampleSize);

                disconnectedReadResults.Add(disconnectedResult);
                WriteToFile($"Disconnected Repository {i} Run ->> Read Speed = {disconnectedResult} ms", _logFilePath);

                var dapperWriteResult = RunDapperRepositoryReadMethod(ReadSampleSize);

                dapperReadResults.Add(dapperWriteResult);
                WriteToFile($"Dapper Repository {i} Run ->> Read Speed = {dapperWriteResult} ms", _logFilePath);

                var efWriteResult = RunEfRepositoryReadMethod(ReadSampleSize);

                efReadResults.Add(efWriteResult);
                WriteToFile($"Ef Repository {i} Run ->> Read Speed = {efWriteResult} ms", _logFilePath);
            }

            var connectedAverage = connectedReadResults.Sum() / ReadSampleSize;
            var disconnectedAverage = disconnectedReadResults.Sum() / ReadSampleSize;
            var dapperAverage = dapperReadResults.Sum() / ReadSampleSize;
            var efAverage = efReadResults.Sum() / ReadSampleSize;

            WriteToFile($"Connected Repository Average ->> Read Speed = {connectedAverage} ms", _logFilePath);
            WriteToFile($"Disconnected Repository Average ->> Read Speed = {disconnectedAverage} ms", _logFilePath);
            WriteToFile($"Dapper Repository Average ->> Read Speed = {dapperAverage} ms", _logFilePath);
            WriteToFile($"Ef Repository Average ->> Read Speed = {efAverage} ms", _logFilePath);

            WriteToFile($"{DateTime.Now} ->> End Repositories Read Test", _logFilePath);
            WriteToFile("___________________________________________________________", _logFilePath);
        }

        private double RunConnectedRepositoryWriteMethod(List<Warehouse> warehousesToInsert)
        {
            using (var uow = new ConnectedUnitOfWork())
            {
                uow.BeginTransaction(IsolationLevel.ReadUncommitted);

                var sw = new Stopwatch();

                sw.Start();

                foreach (var warehouse in warehousesToInsert)
                {
                    uow.WarehouseRepository.Create(warehouse);
                }

                sw.Stop();
                uow.RollbackTransaction();

                var averageTime = (double)sw.ElapsedMilliseconds / WriteSampleSize;

                return averageTime;
            }
        }

        private double RunDisconnectedRepositoryWriteMethod(List<Warehouse> warehousesToInsert)
        {
            using (var uow = new DisconnectedUnitOfWork())
            {
                var sw = new Stopwatch();

                uow.LoadEntities();
                sw.Start();

                foreach (var warehouse in warehousesToInsert)
                {
                    uow.WarehouseRepository.Create(warehouse);
                }

                sw.Stop();

                var averageTime = (double)sw.ElapsedMilliseconds / WriteSampleSize;

                return averageTime;
            }
        }

        private double RunDapperRepositoryWriteMethod(List<Warehouse> warehousesToInsert)
        {
            using (var uow = new DapperUnitOfWork())
            {
                uow.BeginTransaction(IsolationLevel.ReadUncommitted);

                var sw = new Stopwatch();

                sw.Start();

                foreach (var warehouse in warehousesToInsert)
                {
                    uow.WarehouseRepository.Create(warehouse);
                }

                sw.Stop();
                uow.RollbackTransaction();

                var averageTime = (double)sw.ElapsedMilliseconds / WriteSampleSize;

                return averageTime;
            }
        }

        private double RunEfRepositoryWriteMethod(List<Warehouse> warehousesToInsert)
        {
            using (var uow = new EfUnitOfWork())
            {
                var sw = new Stopwatch();

                sw.Start();

                foreach (var warehouse in warehousesToInsert)
                {
                    uow.WarehouseRepository.Create(warehouse);
                }

                sw.Stop();

                var averageTime = (double)sw.ElapsedMilliseconds / WriteSampleSize;

                return averageTime;
            }
        }

        private double RunConnectedRepositoryReadMethod(int readsCount)
        {
            using (var uow = new ConnectedUnitOfWork())
            {
                uow.BeginTransaction(IsolationLevel.ReadUncommitted);

                var sw = new Stopwatch();

                sw.Start();

                for (var i = 0; i < readsCount; i++)
                {
                    var entity = uow.WarehouseRepository.ReadOne(1);
                }

                sw.Stop();

                var averageTime = (double)sw.ElapsedMilliseconds / ReadSampleSize;

                return averageTime;
            }
        }

        private double RunDisconnectedRepositoryReadMethod(int readsCount)
        {
            using (var uow = new DisconnectedUnitOfWork())
            {
                var sw = new Stopwatch();

                uow.LoadEntities();
                sw.Start();

                for (var i = 0; i < readsCount; i++)
                {
                    var entity = uow.WarehouseRepository.ReadOne(1);
                }

                sw.Stop();

                var averageTime = (double)sw.ElapsedMilliseconds / ReadSampleSize;

                return averageTime;
            }
        }

        private double RunDapperRepositoryReadMethod(int readsCount)
        {
            using (var uow = new DapperUnitOfWork())
            {
                uow.BeginTransaction(IsolationLevel.ReadUncommitted);

                var sw = new Stopwatch();

                sw.Start();

                for (var i = 0; i < readsCount; i++)
                {
                    var entity = uow.WarehouseRepository.ReadOne(1);
                }

                sw.Stop();

                var averageTime = (double)sw.ElapsedMilliseconds / ReadSampleSize;

                return averageTime;
            }
        }

        private double RunEfRepositoryReadMethod(int readsCount)
        {
            using (var uow = new EfUnitOfWork())
            {
                var sw = new Stopwatch();

                sw.Start();

                for (var i = 0; i < readsCount; i++)
                {
                    var entity = uow.WarehouseRepository.ReadOne(1);
                }

                sw.Stop();

                var averageTime = (double)sw.ElapsedMilliseconds / ReadSampleSize;

                return averageTime;
            }
        }

        private string GetLogFilePath()
        {
            var projectPath = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName;
            var filePath = "Performance\\log.txt";
            var fullPath = $"{projectPath}\\{filePath}";

            return fullPath;
        }

        private void WriteToFile(string message, string path)
        {
            using (var streamWriter = new StreamWriter(path, true))
            {
                streamWriter.WriteLine(message);
            }
        }

        private List<Warehouse> GenerateTestWarehouses(int count)
        {
            var warehouse = new Warehouse
            {
                City = "Test City",
                State = "Test State"
            };

            var warehouseList = new List<Warehouse>();

            for (var i = 0; i < count; i++)
            {
                warehouseList.Add(warehouse);
            }

            return warehouseList;
        }
    }
}
