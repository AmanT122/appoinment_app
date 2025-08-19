import 'package:flutter/material.dart';
import 'doctor_details.dart'; // Import your DoctorDetails screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Card
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 20, color: Colors.blue[700]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '8RWV+7XH, near Bassein Catholic Bank, Virar West',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),

          // You can paste all the rest of your dashboard UI here...
          // (Symptoms, Appointment, Specialists, Doctors Near You, etc.)
        ],
      ),
    );
  }
}
