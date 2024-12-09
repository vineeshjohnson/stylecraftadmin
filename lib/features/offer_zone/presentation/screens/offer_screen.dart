import 'package:finalprojectadmin/core/usecases/common_widgets/snack_bar.dart';
import 'package:finalprojectadmin/features/offer_zone/presentation/bloc/offer_bloc.dart';
import 'package:finalprojectadmin/features/offer_zone/presentation/screens/adding_banner/adding_banner_screen.dart';
import 'package:finalprojectadmin/features/offer_zone/presentation/widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfferBloc()..add(OfferBannerFetchEvent()),
      child: BlocConsumer<OfferBloc, OfferState>(
        listener: (context, state) {
          if (state is NavigatedToAddBannerState) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const AddingBannerScreen(),
              ),
            )
                .then((_) {
              // Re-fetch banners when returning from AddingBannerScreen
              context.read<OfferBloc>().add(OfferBannerFetchEvent());
            });
          }

          if (state is OfferBannerDeletedState) {
            return snackBar(context, 'Banner Deleted SuccessFully');
          }
        },
        builder: (context, state) {
          if (state is OfferBannerFetchedState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Offer Banners',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey.shade800,
              ),
              backgroundColor: Colors.grey,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              BannerWidget(
                            image: state.banners[index],
                          ),
                          itemCount: state.banners.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<OfferBloc>().add(NavigateToAddBannerEvent());
                },
                tooltip: 'Add Banner',
                splashColor: Colors.blueAccent,
                child: const Icon(Icons.add),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
                title: Text(
                  'Offer Banners',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey.shade800,
              ),
              body: Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
