using Calculator.Library;
using NUnit.Framework;
using System;

namespace Calculator.Tests.Calculator
{
    [TestFixture]
    public class CalculatorClassTests
    {
        private const string NumberString = "5";
        private const int NumberInt = 5;
        private const int NegativeNumberInt = -5;

        private CalculatorClass _target;

        [SetUp]
        public void SetUp()
        {
            _target = new CalculatorClass();
        }

        [Test]
        public void Add_ReturnsEmptyString_WhenEmptyStringPassed()
        {
            var input = String.Empty;

            var result = _target.Add(input);

            Assert.AreEqual(String.Empty, result);
        }

        [Test]
        public void Add_ReturnsOneNumber_WhenOneNumberPassed()
        {
            var input = NumberString;

            var result = _target.Add(input);

            Assert.AreEqual(NumberString, result);
        }

        [Test]
        public void Add_ReturnsSumOfNumbers_WhenTwoNumbersPassed()
        {
            var input = $"{NumberString},{NumberString}";
            var expectedResult = Convert.ToString(NumberInt + NumberInt);

            var result = _target.Add(input);

            Assert.AreEqual(expectedResult, result);
        }

        [Test]
        public void Add_ReturnsSumOfNumbers_WhenMoreThanTwoNumbersPassed()
        {
            var input = $"{NumberString},{NumberString},{NumberString}";
            var expectedResult = Convert.ToString(NumberInt + NumberInt + NumberInt);

            var result = _target.Add(input);

            Assert.AreEqual(expectedResult, result);
        }

        [Test]
        public void Add_ReturnsSumOfNumbers_WhenDelimetersAndNumbersPassed()
        {
            var input = $"//;\n{NumberString};{NumberString}";
            var expectedResult = Convert.ToString(NumberInt + NumberInt);

            var result = _target.Add(input);

            Assert.AreEqual(expectedResult, result);
        }

        [Test]
        public void Add_ThrowsExceptionWithNegativeNumber_WhenNegativeNumberPassed()
        {
            var input = $"{NegativeNumberInt}";
            var exceptionMessage = $"Negatives Not Allowed: {NegativeNumberInt}";

            Assert.Throws<ArgumentException>(() =>
            {
                _target.Add(input);
            }, exceptionMessage);
        }

        [Test]
        public void Add_ThrowsExceptionWithNegativeNumbers_WhenMultipleNegativeNumbersPassed()
        {
            var input = $"{NegativeNumberInt},{NegativeNumberInt}";
            var exceptionMessage = $"Negatives Not Allowed: {NegativeNumberInt}, {NegativeNumberInt}";

            Assert.Throws<ArgumentException>(() =>
            {
                _target.Add(input);
            }, exceptionMessage);
        }
    }
}
