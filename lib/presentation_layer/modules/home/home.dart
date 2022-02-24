import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/cubit.dart';
import 'package:shop_app/data_layer/bloc/states.dart';
import 'package:shop_app/presentation_layer/models/categories_model/categories_model.dart';
import 'package:shop_app/presentation_layer/models/home_model/home_model.dart';
import 'package:shop_app/presentation_layer/shared/components/components.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopFavouriteSuccess) {
          if (state.favouriteModel!.status == true) {
            showToast(
              message: '${state.favouriteModel!.message}',
              state: ToastState.SUCCESS,
            );
          } else if (state.favouriteModel!.status == false) {
            showToast(
              message: '${state.favouriteModel!.message}',
              state: ToastState.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (BuildContext context) =>
              productBuilder(cubit.homeModel, cubit.categoryModel, context),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(
      HomeModel? model, CategoryModel? categoryModel, BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data!.banners.map((e) {
              return Image(
                image: NetworkImage("${e.image}"),
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 195,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(
                seconds: 4,
              ),
              reverse: false,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  textAlign: TextAlign.center,
                  style: fontAppStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        categoryItem(categoryModel!.data!.category[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 7,
                    ),
                    itemCount: categoryModel!.data!.category.length,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'New Products',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: fontAppStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.59,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: List.generate(
                model.data!.products.length,
                (index) => productGridItem(
                    model.data!.products[index], index, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryItem(model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          width: 110,
          height: 110,
          child: Image.network('${model.image}', fit: BoxFit.cover),
        ),
        Container(
          width: 110,
          height: 23,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: fontAppStyle.copyWith(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget productGridItem(ProductModel model, int index, BuildContext context) {
    var cubit = ShopCubit.get(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                height: 180,
                child: Image(
                  image: NetworkImage(model.image),
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red[400]!.withOpacity(0.9),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${model.price.round()}" + '\$',
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.3,
                        fontWeight: FontWeight.w900,
                        //color: defaultAppColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.oldPrice.round()}" + '\$',
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          cubit.addOrDeleteItemFromFavourite(model.id);
                        },
                        icon: cubit.favourite[model.id] == true
                            ? Icon(
                                Icons.favorite,
                                size: 20,
                                color: Colors.red[400],
                              )
                            : Icon(
                                Icons.favorite_border,
                                size: 20,
                                color: Colors.red[400],
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
