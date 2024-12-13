import 'package:finalprojectadmin/core/usecases/common_widgets/sized_boxes.dart';
import 'package:finalprojectadmin/features/auth/presentation/pages/login_screen/login_screen.dart';
import 'package:finalprojectadmin/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    int completed = 0;
    int incompleted = 0;
    int cancelled = 0;
    int total = 0;
    return BlocProvider(
      create: (context) =>
          DashboardBloc()..add(FetchAllOrdersForDashboardEvent()),
      child: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isloading = true;
          } else if (state is AllOrdersFetchedForDashboardState) {
            completed = state.completeorders;
            incompleted = state.incompletedorders;
            cancelled = state.cancelledorders;
            total = state.totalturnover;
            isloading = false;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            'Logout',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: const Text('Do you want to Logout?'),
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); 
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                removeUserId();
                                Navigator.of(context).pushAndRemoveUntil(
                                    (MaterialPageRoute(
                                        builder: (context) => LoginScreen())),
                                    (route) => false);
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.logout))
              ],
              automaticallyImplyLeading: false,
              title: const Text(
                "Dashboard",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.grey.shade800,
              elevation: 1,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: isloading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sales Performance",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        kheight20,
                        // Summary Cards Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSummaryCard("Total Sales",
                                completed.toString(), Colors.green),
                            _buildSummaryCard('Incompleted Orders',
                                incompleted.toString(), Colors.orange),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSummaryCard("Canceled Orders",
                                cancelled.toString(), Colors.red),
                            _buildSummaryCard("Total Turnover",
                                "₹${total.toString()}", Colors.blue),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Charts Section
                        const Text(
                          "Sales Performance",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: completed.toDouble(),
                                    title:
                                        '${((completed / (completed + incompleted + cancelled)) * 100).toStringAsFixed(1)}%',
                                    radius: 50,
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.orange,
                                    value: incompleted.toDouble(),
                                    title:
                                        '${((incompleted / (completed + incompleted + cancelled)) * 100).toStringAsFixed(1)}%',
                                    radius: 50,
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.red,
                                    value: cancelled.toDouble(),
                                    title:
                                        '${((cancelled / (completed + incompleted + cancelled)) * 100).toStringAsFixed(1)}%',
                                    radius: 50,
                                    titleStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                centerSpaceRadius: 40,
                                sectionsSpace: 4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Recent Activities Section
                        const Text(
                          "Recent Activities",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5, 
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.shade100,
                                child: const Icon(Icons.shopping_bag,
                                    color: Colors.blue),
                              ),
                              title: const Text("Order #12345"),
                              subtitle: const Text("Sold 3 items for ₹1,200"),
                              trailing: Text(
                                "Completed",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> removeUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id');
}
