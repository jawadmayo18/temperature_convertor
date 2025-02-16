import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  double _convertedTemp = 0.0;

  // Temperature Units
  final List<String> units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';

  void _convertTemperature() {
    double temp = double.tryParse(_tempController.text) ?? 0.0;

    double tempInCelsius;

    // Convert input temperature to Celsius first
    if (_fromUnit == 'Celsius') {
      tempInCelsius = temp;
    } else if (_fromUnit == 'Fahrenheit') {
      tempInCelsius = (temp - 32) * 5 / 9;
    } else {
      tempInCelsius = temp - 273.15;
    }

    // Convert Celsius to desired unit
    if (_toUnit == 'Celsius') {
      _convertedTemp = tempInCelsius;
    } else if (_toUnit == 'Fahrenheit') {
      _convertedTemp = (tempInCelsius * 9 / 5) + 32;
    } else {
      _convertedTemp = tempInCelsius + 273.15;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Temperature Converter"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _tempController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Temperature",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Dropdowns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton<String>(
                          value: _fromUnit,
                          onChanged: (value) {
                            setState(() {
                              _fromUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: units.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),

                        Icon(Icons.arrow_forward, color: Colors.deepOrange),

                        DropdownButton<String>(
                          value: _toUnit,
                          onChanged: (value) {
                            setState(() {
                              _toUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: units.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Convert",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Converted Temperature Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.deepOrange,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Converted Temperature: ${_convertedTemp.toStringAsFixed(2)} $_toUnit",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
