import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/cubit.dart';
import 'package:shop_app/data_layer/bloc/states.dart';
import 'package:shop_app/presentation_layer/modules/search/search.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            leading: const Image(
              height: 20,
              image: AssetImage('assets/images/salla.png'),
            ),
            title: Text(
              'Salla',
              style: fontAppStyle.copyWith(fontSize: 25),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigatePushTo(
                      context: context,
                      navigateTo: const SearchScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bottomNavBarIndex,
            onTap: (index) {
              cubit.bottomNavigationBarIndex(index);
            },
            items: cubit.bottomNavBarItem,
          ),
          body: cubit.screens[cubit.bottomNavBarIndex],
        );
      },
    );
  }
}
