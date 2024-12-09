import 'package:finalprojectadmin/features/categories/presentation/pages/category_page/category_page.dart';
import 'package:finalprojectadmin/features/bottom_nav/presentation/bloc/bottomnavcontrole_bloc.dart';
import 'package:finalprojectadmin/features/bottom_nav/presentation/widgets/bottom_navbar_widget.dart';
import 'package:finalprojectadmin/features/dashboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:finalprojectadmin/features/offer_zone/presentation/screens/offer_screen.dart';
import 'package:finalprojectadmin/features/user_orders/presentation/screens/all_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBars extends StatelessWidget {
  const BottomNavigationBars({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? widget;

    return BlocProvider(
      create: (context) => BottomnavcontroleBloc(),
      child: BlocBuilder<BottomnavcontroleBloc, BottomnavcontroleState>(
        builder: (context, state) {
          if (state is BottomnavcontroleInitial) {
            widget = const CategoryPage();
          } else if (state is BottomnavcontroleHomeState) {
            widget = const CategoryPage();
          } else if (state is BottomnavcontroleShopState) {
            widget = const OfferScreen();
          } else if (state is BottomnavcontroleCartState) {
            widget = const AllOrderScreen();
          } else if (state is BottomnavcontroleProfileState) {
            widget = DashboardScreen();
          }
          return SafeArea(
            child: Scaffold(
              // drawer: const AppBarDrawer(),
              // appBar: AppBar(
              //   backgroundColor: Colors.black,
              //   leading: Builder(
              //     builder: (context) {
              //       return IconButton(
              //         icon: const Icon(
              //           Icons.menu,
              //           color: Colors.white,
              //         ),
              //         onPressed: () {
              //           Scaffold.of(context).openDrawer();
              //         },
              //       );
              //     },
              //   ),
              // ),
              body: widget,
              bottomNavigationBar: BottomNavbarWidget(key: key),
            ),
          );
        },
      ),
    );
  }
}
