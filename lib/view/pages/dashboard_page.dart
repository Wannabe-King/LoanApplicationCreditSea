import 'package:client_app/config/color.dart';
import 'package:client_app/view/screens/applyforloan.dart';
import 'package:client_app/view/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/loan_application_controller.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final LoanApplicationController controller = Get.put(
    LoanApplicationController(),
    permanent: true,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchApplications(); // ✅ safe after build
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorX.buttonBlue,
        title: const Text(
          'My Applications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: ColorX.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.red.shade600,
              size: 26,
            ),
          ),
        ],
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.applications.isEmpty) {
            return const Center(child: Text('No applications found'));
          }
          return ListView.builder(
            itemCount: controller.applications.length,
            itemBuilder: (context, index) {
              final app = controller.applications[index];
              return Container(
                decoration: BoxDecoration(
                  color: ColorX.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 0.1,
                      blurRadius: 6,
                      offset: const Offset(-1, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loan Type',
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            letterSpacing: 2,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          app.loanType,
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Application Status',
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            letterSpacing: 2,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          app.status.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: _getStatusColor(app.status),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            letterSpacing: 2,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '₹ ${app.amount}',
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorX.green,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tenure',
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            letterSpacing: 2,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          '${app.tenure} Months',
                          style: TextStyle(
                            fontFamily: 'Comic Sans MS',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => ApplyForLoan()));
        },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: ColorX.buttonBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: ColorX.white, weight: 2),
              SizedBox(width: 10),
              Text(
                'Apply for New Loan',
                style: TextStyle(
                  fontSize: 18,
                  color: ColorX.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
