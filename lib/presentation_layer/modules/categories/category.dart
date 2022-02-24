import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/cubit.dart';
import 'package:shop_app/data_layer/bloc/states.dart';
import 'package:shop_app/presentation_layer/models/categories_model/categories_model.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

class category extends StatelessWidget {
  const category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoryModel != null,
          builder: (BuildContext context) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                categoryItem(cubit.categoryModel!.data!.category[index]),
            itemCount: cubit.categoryModel!.data!.category.length,
          ),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget categoryItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                '${model.image}',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              child: Text(
                "${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                style: fontAppStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            )
          ],
        ),
      ),
    );
  }
}
