import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Color color;
  final Function()? onTap; // Add this

  CustomCard({
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.color,
    this.onTap, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 6.0,
      child: Container(
        height: 100, // Set the height to whatever you want
        child: ListTile(
          contentPadding: EdgeInsets.all(15.0),
          leading: CircleAvatar(
            backgroundColor: color,
            child: Icon(iconData, color: Colors.white),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
          onTap: onTap, // Add this
        ),
      ),
    );
  }
}

