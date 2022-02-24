import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data_layer/bloc/cubit.dart';
import 'package:shop_app/data_layer/bloc/states.dart';
import 'package:shop_app/presentation_layer/shared/style/style/style/style.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition:
              State is! ShopGetFavouriteLoading || cubit.favouriteModel != null,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => favouriteItem(
                  cubit.favouriteModel!.data!.data[index].product, context),
              itemCount: cubit.favouriteModel!.data!.data.length,
            ),
          ),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget favouriteItem(model, BuildContext context) {
    var cubit = ShopCubit.get(context);
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: Image(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.contain,
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: fontAppStyle.copyWith(fontSize: 16, height: 1.3),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${model.price.round()}" '\$',
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 16,
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
                            "${model.oldPrice.round()}" '\$',
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
                          radius: 20,
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
            ),
          ],
        ),
      ),
    );
  }
}
