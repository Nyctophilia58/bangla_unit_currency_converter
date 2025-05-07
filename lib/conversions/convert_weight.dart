double convertWeight(double value, String from, String to) {
  const weight = {
    'Kg': 1.0,
    'Lb': 0.453592,
    'Oz': 0.0283495,
    'Stone': 6.35029,
  };
  return value * weight[from]! / weight[to]!;
}
