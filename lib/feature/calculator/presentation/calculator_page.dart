import 'package:flutter/material.dart';
import 'package:mam/feature/calculator/presentation/widgets/properties_form.dart';
import 'package:mam/feature/calculator/presentation/widgets/vehicle_form.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kalkulator Premi'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.home)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: VehicleForm()),
            Center(child: PropertiesForm()),
          ],
        ),
      ),
    );
  }
}
