import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finalprojectadmin/features/bottom_nav/presentation/bloc/bottomnavcontrole_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarWidget extends StatelessWidget {
  BottomNavbarWidget({
    super.key,
  });

  final List<Widget> _list = [
    const Icon(Icons.category_outlined),
    const Icon(Icons.supervised_user_circle_rounded),
    const Icon(Icons.discount_outlined),
    const Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      buttonBackgroundColor: Colors.grey,
      animationCurve: Curves.easeInOutCubicEmphasized,
      // buttonBackgroundColor: Colors.black,
      backgroundColor: Colors.grey,
      color: Colors.grey.shade300,
      height: 75,
      items: _list,
      index: 0,
      onTap: (index) {
        final bloc = BlocProvider.of<BottomnavcontroleBloc>(context);
        if (index == 0) {
          bloc.add(HomeEvent());
        } else if (index == 1) {
          bloc.add(ShopEvent());
        } else if (index == 2) {
          bloc.add(CartEvent());
        } else if (index == 3) {
          bloc.add(ProfileEvent());
        }
      },
    );
  }
}
