import 'package:flutter/material.dart';
import 'package:shop_app/presentation_layer/layout/shop_layout.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              navigatePushTo(context: context, navigateTo: ShopLayout());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 15,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: defaultTextFormField(),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
