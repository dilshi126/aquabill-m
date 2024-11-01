import 'package:flutter/material.dart';
import 'package:flutter_auth/services/auth.dart';
import 'view_customers_page.dart'; // Placeholder for view customers page
import 'add_customer_page.dart'; // Placeholder for add customer page
import 'add_area_manager_page.dart'; // Placeholder for add area manager page
import 'change_pricing_page.dart'; // Placeholder for change pricing page
import 'view_area_managers_page.dart'; // Placeholder for view area managers page
import 'footer.dart'; // Import the footer

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    const String adminEmail =
        'admin@example.com'; // Replace with actual admin email

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Admin Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/logo.png', // Replace with your logo asset
              height: 60,
            ),
          ],
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile section with image and email
            Row(
              children: [
                Image.asset(
                  'assets/images/admin.png', // Replace with admin image
                  height: 60,
                  width: 60,
                ),
                const SizedBox(width: 10),
                Text(
                  adminEmail,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Dashboard functions in a grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _dashboardTile(context, 'Add Customer', Icons.person_add,
                    const AddCustomerPage()),
                _dashboardTile(context, 'Add Area Manager',
                    Icons.supervisor_account, const AddAreaManagerPage()),
                _dashboardTile(context, 'Change Pricing', Icons.money,
                    const ChangePricingPage()),
                _dashboardTile(context, 'View Customers', Icons.visibility,
                    const ViewCustomersPage()),
                _dashboardTile(context, 'View Area Managers', Icons.people,
                    const ViewAreaManagersPage()),
              ],
            ),
            const SizedBox(height: 20),

            // Logout button
            _logoutButton(context, _auth),
            const SizedBox(height: 20),

            // Footer section
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context, AuthServices auth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () async {
          await auth.signOut();
        },
        child: const Text(
          "LOGOUT",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  GestureDetector _dashboardTile(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Card(
        color: Colors.blue, // Blue box color for uniformity
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
