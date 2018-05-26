using System;
using System.Linq;
using System.Text;

namespace Calculator.Library
{
    public class CalculatorClass
    {
        private const string NewLineDelimeter = "\n";
        private const string CommaDelimeter = ",";
        private const string CustomDelimterPrefix = "//";

        public string Add(string input)
        {
            if (String.IsNullOrEmpty(input))
            {
                return String.Empty;
            }

            var customDelimiter = input.Split(new[] { NewLineDelimeter }, StringSplitOptions.None)
                .ToList()
                .Where(segment => segment.StartsWith(CustomDelimterPrefix))
                .Select(segment => segment.Substring(2))
                .FirstOrDefault();

            string[] delimeters;

            if (customDelimiter != null)
            {
                delimeters = new[]
                {
                    customDelimiter,
                    NewLineDelimeter,
                    CustomDelimterPrefix
                };
            }
            else
            {
                delimeters = new[]
                {
                    CommaDelimeter,
                    NewLineDelimeter
                };
            }

            var numberArray = input.Split(delimeters, StringSplitOptions.RemoveEmptyEntries).ToList();
            var negativeNumbers = numberArray.Where(numString => numString.StartsWith("-")).ToList();

            if (negativeNumbers.Any())
            {
                var sb = new StringBuilder();

                sb.Append("Negatives Not Allowed: ");
                negativeNumbers.ForEach(numString => sb.Append($"{numString}, "));

                var message = sb.ToString(0, sb.Length - 1);

                throw new ArgumentException(sb.ToString());
            }

            var sum = 0;

            numberArray.ForEach(numString =>
            {
                sum += Int32.Parse(numString);
            });

            return sum.ToString();
        }
    }
}
