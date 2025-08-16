double convertWeight(double value, String from, String to) {
  const weight = {
    'kg': 1.0,
    'lb': 0.453592,
    'oz': 0.0283495,
    'stone': 6.35029,
  };
  return value * weight[from]! / weight[to]!;
}
