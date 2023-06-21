import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          // Remplacez par vos propres widgets
          _DashboardCard(title: 'Calendar', icon: Icons.calendar_today, onTap: () {
            // Naviguer vers la page du calendrier
          }),
          _DashboardCard(title: 'Inspections', icon: Icons.search, onTap: () {
            // Naviguer vers la page des inspections
          }),
          _DashboardCard(title: 'Evaluations', icon: Icons.check_circle, onTap: () {
            // Naviguer vers la page des évaluations
          }),
          _DashboardCard(title: 'Settings', icon: Icons.settings, onTap: () {
            // Naviguer vers la page des paramètres
          }),
          // Ajoutez autant de cartes que nécessaire
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DashboardCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 70),
              Text(title, style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
