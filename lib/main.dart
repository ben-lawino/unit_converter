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
  final List<String> _measures  = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds(lbs)',
    'ounces',
  ];
   double? _numberFrom;
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Center(
          child: Column(
            children: [
              DropdownButton(items: _measures.map((String value){
                return DropdownMenuItem<String>(value :value,child: Text(value),);
        },).toList(),
            onChanged:(_){},),
              TextField(
                onChanged: (text){
                  var rv =double.tryParse(text);
                  if(rv != null ) {
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
              ),
              Text((_numberFrom == null)?'':_numberFrom.toString())
            ],
          ),

        ),
      ),
    );
  }
}
