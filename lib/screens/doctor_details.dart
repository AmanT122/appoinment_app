import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Doctor Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade800,
        elevation: 1,
        shadowColor: Colors.grey.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Image
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/doctor_image.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Doctor Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Avani Dubey',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.medical_services, 
                                  size: 16, 
                                  color: Colors.blue.shade700),
                              const SizedBox(width: 4),
                              Text(
                                'Orthopaedic Surgeon',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Rating and Experience
                          Row(
                            children: [
                              _buildInfoChip(
                                icon: Icons.star,
                                color: Colors.amber,
                                text: '4.5 (120 reviews)',
                              ),
                              const SizedBox(width: 8),
                              _buildInfoChip(
                                icon: Icons.work,
                                color: Colors.blue.shade700,
                                text: '10+ years',
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Hospital Info
                          Row(
                            children: [
                              Icon(Icons.location_on, 
                                  size: 16, 
                                  color: Colors.blue.shade700),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Wockhardt Hospitals, Mumbai',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // About Section
            Text(
              'About Doctor',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Consultant Orthopaedic Surgeon at Sunrise Multispeciality Hospital, Mumbai.\n\n'
                  'My name is Dr. Avani Dubey. I am a board-certified orthopaedic surgeon with over 10 years of experience in treating a wide range of musculoskeletal conditions, including joint replacement surgeries, trauma management, sports injuries, and arthroscopic procedures.\n\n'
                  'I have experience in treating both adults and children with comprehensive care for patients of all ages. I completed my MBBS from Government Medical College in Mumbai and my M.S. in Orthopaedics from King Edward Memorial (KEM) Hospital. To enhance my surgical expertise, I pursued a fellowship in Joint Replacement Surgery at the University.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Specializations
            Text(
              'Specializations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSpecializationChip('Joint Replacement'),
                _buildSpecializationChip('Sports Injuries'),
                _buildSpecializationChip('Arthroscopic Surgery'),
                _buildSpecializationChip('Trauma Care'),
                _buildSpecializationChip('Pediatric Orthopedics'),
              ],
            ),
            const SizedBox(height: 32),
            // Book Appointment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add booking functionality
                  _showBookingDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializationChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.blue.shade50,
      labelStyle: TextStyle(
        color: Colors.blue.shade800,
        fontSize: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.blue.shade100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select appointment date and time:'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // In a real app, you would navigate to a booking screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment booked successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Confirm Booking'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}