// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiKey = '1ZRvKQlF'; // Replace with your actual API key
  String marketData = 'Loading...';

  @override
  void initState() {
    super.initState();
    getMarketData();
  }

  Future<void> getMarketData() async {
    const String baseUrl = 'https://api.angelone.in';

    try {
      // Replace '/market' with the specific API endpoint for market data
      final response = await http.get(Uri.parse('$baseUrl/market'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      });

      if (response.statusCode == 200) {
        // Parse and process the market data
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          marketData = 'Market Data: $data';
        });
      } else {
        setState(() {
          marketData =
              'Failed to fetch market data. Status code: ${response.statusCode}';
        });
        print('Response body: ${response.body}');
      }
    } catch (e) {
      setState(() {
        marketData = 'Error: $e';
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Angel One API Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            marketData,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
