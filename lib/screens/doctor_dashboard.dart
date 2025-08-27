import 'package:appoinment_app/screens/pages_doctor/AppointmentScreen.dart';
import 'package:appoinment_app/screens/pages_doctor/MessageScreen.dart';
import 'package:appoinment_app/screens/pages_doctor/ProfileScreen.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DoctorMainDashboard();
  }
}

class DoctorMainDashboard extends StatefulWidget {
  @override
  _DoctorMainDashboardState createState() => _DoctorMainDashboardState();
}

class _DoctorMainDashboardState extends State<DoctorMainDashboard> 
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isOnline = true;
  bool _aiAssistantActive = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Updated color scheme with medical theme
  final Color _scaffoldBg = Color(0xFFF8FAFC);
  final Color _primaryBlue = Color(0xFF2A77DE);
  final Color _primaryBlueLight = Color(0xFFE8F1FF);
  final Color _accentPurple = Color(0xFF7B61FF);
  final Color _accentPurpleLight = Color(0xFFF0EDFF);
  final Color _accentGreen = Color(0xFF34C759);
  final Color _accentGreenLight = Color(0xFFE6F8EB);
  final Color _accentRed = Color(0xFFFF3B30);
  final Color _accentRedLight = Color(0xFFFFECEb);
  final Color _textPrimary = Color(0xFF1D2939);
  final Color _textSecondary = Color(0xFF667085);
  final Color _cardBg = Colors.white;
  final Color _shadowColor = Color(0x0D000000);

  final List<Widget> _pages = [
    Appointmentscreen_doctor(),
    Messagescreen_doctor(),
    Profilescreen_doctor(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: _primaryBlue,
                scaffoldBackgroundColor: _scaffoldBg,
                fontFamily: 'Inter',
              ),
              home: Scaffold(
                backgroundColor: _scaffoldBg,
                appBar: _buildAppBar(context),
                body: _pages[_selectedIndex],
                bottomNavigationBar: _buildBottomNavBar(),
                floatingActionButton: _buildFloatingActions(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 0),
          _buildNavItem(Icons.calendar_today_outlined, Icons.calendar_today, 'Appointments', 1),
          SizedBox(width: 40), // Space for central FAB
          _buildNavItem(Icons.message_outlined, Icons.message, 'Messages', 2),
          _buildNavItem(Icons.person_outline, Icons.person, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _primaryBlueLight : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 24,
              color: isSelected ? _primaryBlue : _textSecondary,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? _primaryBlue : _textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _shadowColor,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.menu, color: _textPrimary),
              onPressed: () {
                _showSideMenu(context);
              },
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _primaryBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/Logo.png',
              height: 28,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr. Asmit Vishwakarma',
                style: TextStyle(
                  color: _textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                'Orthopedic Specialist',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        _buildAIAssistantToggle(),
        SizedBox(width: 8),
        _buildOnlineStatusToggle(),
        SizedBox(width: 8),
        _buildNotificationButton(),
        SizedBox(width: 8),
        _buildProfileButton(context),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildAIAssistantToggle() {
    return Container(
      decoration: BoxDecoration(
        color: _aiAssistantActive ? _accentPurpleLight : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            _aiAssistantActive = !_aiAssistantActive;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_aiAssistantActive 
                ? 'AI Medical Assistant Activated' 
                : 'AI Medical Assistant Deactivated'),
              backgroundColor: _aiAssistantActive ? _accentPurple : _textSecondary,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
        icon: Icon(Icons.auto_awesome, size: 16, 
                 color: _aiAssistantActive ? _accentPurple : _textSecondary),
        label: Text(
          'AI Assistant',
          style: TextStyle(
            fontSize: 12,
            color: _aiAssistantActive ? _accentPurple : _textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineStatusToggle() {
    return Container(
      decoration: BoxDecoration(
        color: _isOnline ? _accentGreenLight : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _isOnline = !_isOnline;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_isOnline 
                ? 'You are now available for consultations' 
                : 'You are now offline'),
              backgroundColor: _isOnline ? _accentGreen : _textSecondary,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _isOnline ? _accentGreen : _textSecondary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6),
            Text(
              _isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                fontSize: 12,
                color: _isOnline ? _accentGreen : _textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.notifications_none, color: _textPrimary),
              onPressed: () {
                _showNotifications(context);
              },
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _accentRed,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: _primaryBlue,
        child: IconButton(
          icon: Icon(Icons.person, color: Colors.white, size: 20),
          onPressed: () {
            _showProfileMenu(context);
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "voiceAssistant",
          onPressed: () {
            _showVoiceAssistant(context);
          },
          backgroundColor: _accentPurple,
          mini: true,
          child: Icon(Icons.mic, color: Colors.white, size: 20),
        ),
        SizedBox(height: 12),
        FloatingActionButton(
          heroTag: "emergency",
          onPressed: () {
            _showEmergencyOptions(context);
          },
          backgroundColor: _accentRed,
          child: Icon(Icons.emergency, color: Colors.white),
        ),
      ],
    );
  }

  void _showSideMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick Access Menu',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: _textPrimary
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: _textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(16),
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuButton('Medical Records', Icons.medical_services, _primaryBlue),
                  _buildMenuButton('Patient List', Icons.people, _accentGreen),
                  _buildMenuButton('Prescriptions', Icons.description, Colors.orange),
                  _buildMenuButton('Lab Results', Icons.science, _accentPurple),
                  _buildMenuButton('Billing', Icons.payment, _accentRed),
                  _buildMenuButton('Settings', Icons.settings, _textSecondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.w500, 
                color: _textPrimary
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: _primaryBlue,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Dr. Asmit Vishwakarma',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: _textPrimary
                ),
              ),
              Text(
                'Orthopedic Specialist',
                style: TextStyle(color: _textSecondary),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildProfileAction('Settings', Icons.settings, _primaryBlue),
                  _buildProfileAction('Profile', Icons.person, _accentGreen),
                  _buildProfileAction('Schedule', Icons.calendar_today, Colors.orange),
                  _buildProfileAction('Logout', Icons.logout, _accentRed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAction(String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: _textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: _textPrimary
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: _textSecondary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ..._buildNotificationList(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNotificationList() {
    return [
      _buildNotificationItem('AI detected abnormal pattern in patient ECG', '10 mins ago', Icons.auto_awesome, _accentPurple),
      _buildNotificationItem('New lab results available', '30 mins ago', Icons.assignment, _primaryBlue),
      _buildNotificationItem('Patient rescheduled appointment', '2 hours ago', Icons.calendar_today, Colors.orange),
    ];
  }

  Widget _buildNotificationItem(String title, String time, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _shadowColor.withOpacity(0.1),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(title, style: TextStyle(fontSize: 14, color: _textPrimary)),
        subtitle: Text(time, style: TextStyle(fontSize: 12, color: _textSecondary)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: _textSecondary),
      ),
    );
  }

  void _showEmergencyOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emergency Actions',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: _textPrimary
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: _textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildEmergencyOption('Critical Alert', Icons.warning, _accentRed),
                _buildEmergencyOption('Teleconsult', Icons.video_call, _primaryBlue),
                _buildEmergencyOption('Prescription', Icons.medical_services, _accentGreen),
                _buildEmergencyOption('Hospital', Icons.local_hospital, _accentPurple),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyOption(String title, IconData icon, Color color) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12, 
                color: _textPrimary,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVoiceAssistant(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AI Medical Voice Assistant',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: _textPrimary
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: _textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Say "Hey Doc" followed by your command',
              style: TextStyle(color: _textSecondary),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _accentPurpleLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _shadowColor,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.mic, size: 40, color: _accentPurple),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Listening...',
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: _textPrimary
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Try saying:\n"Add notes for patient Ankita Tiwari"\n"Search for drug interactions"',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.medical_services, color: _primaryBlue),
                  label: Text('Medical Query'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today, color: _accentGreen),
                  label: Text('Schedule'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}