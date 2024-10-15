import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _resultMessage;
  String? _startMeasure;
  String? _convertedMeasure;
  double _numberFrom = 0;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds(lbs)',
    'ounces',
  ];
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds(lbs)': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  @override
  void initState() {
    _numberFrom = 0.0;
    _startMeasure = _measures[0]; // Initialize with the first measure
    _convertedMeasure = _measures[1]; // Initialize with a different measure
    super.initState();
  }

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from]!;
    int nTo = _measuresMap[to]!;
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
      '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(fontSize: 20, color: Colors.blue[900]);
    final TextStyle labelStyle = TextStyle(fontSize: 24, color: Colors.grey[700]);

    return MaterialApp(
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Measures Converter'),
          centerTitle: true,
          backgroundColor: Colors.teal, // Change the appBar color for a more modern look
        ),
        body: Padding(
          padding: const EdgeInsets.all(20), // Uniform padding for the entire page
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start for a clean layout
            children: [
              const Spacer(),
              Text('Enter Value:', style: labelStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8), // Add space between label and input
              TextField(
                style: inputStyle,
                decoration: InputDecoration(
                  hintText: 'Please insert the measure to be converted',
                  border: OutlineInputBorder(), // Outline border for better input field visibility
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
              ),
              const SizedBox(height: 16), // Add space between fields
              Text('From:', style: labelStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                isExpanded: true,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startMeasure = value;
                  });
                },
                value: _startMeasure,
                style: inputStyle, // Match the dropdown style with the input field
              ),
              const SizedBox(height: 16),
              Text('To:', style: labelStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                isExpanded: true,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _convertedMeasure = value;
                  });
                },
                value: _convertedMeasure,
                style: inputStyle,
              ),
              const SizedBox(height: 24), // Increase space before the button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40), // Add padding to the button
                    backgroundColor: Colors.teal, // Match the button color with app theme
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners for a modern feel
                    ),
                  ),
                  child: Text('Convert', style: inputStyle.copyWith(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (_startMeasure == null ||
                        _convertedMeasure == null ||
                        _numberFrom == 0) {
                      return;
                    } else {
                      convert(_numberFrom, _startMeasure!, _convertedMeasure!);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  (_resultMessage == null) ? '' : _resultMessage!,
                  style: labelStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(flex: 8),
            ],
          ),
        ),
      )
    );
  }
}
