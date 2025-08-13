const List<String> buttonLabelsEnglish = ['Currency', 'Height', 'Weight', 'Temp.', 'Time'];
const List<String> buttonLabelsBangla = ['মুদ্রা', 'উচ্চতা', 'ওজন', 'তাপমাত্রা', 'সময়'];

const List<String> buttonIcons = [
  'assets/icons/currency.png',
  'assets/icons/height.png',
  'assets/icons/weight.png',
  'assets/icons/temperature.png',
  'assets/icons/time.png',
];

// Keys are constant identifiers
const Map<int, List<String>> optionKeys = {
  0: ['USD', 'EUR', 'BDT', 'INR', 'GBP', 'CAD'],
  1: ['feet', 'meters', 'inches', 'centimeters'],
  2: ['kg', 'lb', 'oz', 'stone'],
  3: ['celsius', 'fahrenheit', 'kelvin'],
  4: ['seconds', 'minutes', 'hours', 'days'],
};

// Display mapping
const Map<int, Map<String, String>> optionLabelsEnglish = {
  0: {'USD': 'USD', 'EUR': 'EUR', 'BDT': 'BDT', 'INR': 'INR', 'GBP': 'GBP', 'CAD': 'CAD'},
  1: {'feet': 'Feet', 'meters': 'Meters', 'inches': 'Inches', 'centimeters': 'Centimeters'},
  2: {'kg': 'Kg', 'lb': 'Lb', 'oz': 'Oz', 'stone': 'Stone'},
  3: {'celsius': 'Celsius', 'fahrenheit': 'Fahrenheit', 'kelvin': 'Kelvin'},
  4: {'seconds': 'Seconds', 'minutes': 'Minutes', 'hours': 'Hours', 'days': 'Days'},
};

const Map<int, Map<String, String>> optionLabelsBangla = {
  0: {'USD': 'USD', 'EUR': 'EUR', 'BDT': 'BDT', 'INR': 'INR', 'GBP': 'GBP', 'CAD': 'CAD'},
  1: {'feet': 'ফুট', 'meters': 'মিটার', 'inches': 'ইঞ্চি', 'centimeters': 'সেন্টিমিটার'},
  2: {'kg': 'কেজি', 'lb': 'পাউন্ড', 'oz': 'আউন্স', 'stone': 'স্টোন'},
  3: {'celsius': 'সেলসিয়াস', 'fahrenheit': 'ফারেনহাইট', 'kelvin': 'কেলভিন'},
  4: {'seconds': 'সেকেন্ড', 'minutes': 'মিনিট', 'hours': 'ঘণ্টা', 'days': 'দিন'},
};
