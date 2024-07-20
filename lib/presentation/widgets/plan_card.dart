import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;

  PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan['name'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Precio: \$${plan['price']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Duración: ${plan['duration']} mes(es)',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Descripción: ${plan['description']}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
