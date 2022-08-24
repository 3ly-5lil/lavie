import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api_models/products/Product.dart';
import '../../../helper/bloc/filters/filters_cubit.dart';
import '../../../helper/bloc/products/products_cubit.dart';
import '../../../shared/app_constants.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final controller = TextEditingController();
  var filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FiltersCubit(),
          ),
          BlocProvider(
            create: (context) => ProductsCubit(),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //the logo
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: SvgPicture.asset('assets/images/logo.svg'),
            ),
            Row(
              children: [
                //search
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        label: Text('Search'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
                //cartButton
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff1ABC00),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: IconButton(
                        onPressed: () {
                          //todo
                        },
                        icon: SvgPicture.asset('assets/icons/Cart.svg')),
                  ),
                ),
              ],
            ),
            //tab bar
            BlocBuilder<FiltersCubit, FiltersState>(
              buildWhen: (previous, current) =>
                  current is FiltersFetchSuccessState,
              builder: (filterContext, state) {
                var filters = filterContext.read<FiltersCubit>().filters;

                const selectedColor = Color(0xff1ABC00);
                const unselectedColor = Color(0xff979797);
                return (state is FiltersFetchSuccessState &&
                        filterContext.read<FiltersCubit>().filters.isNotEmpty)
                    ? DefaultTabController(
                        length: filters.length,
                        child: ButtonsTabBar(
                          backgroundColor: const Color(0xffF8F8F8),
                          unselectedBackgroundColor: const Color(0xffF8F8F8),
                          labelStyle: const TextStyle(color: selectedColor),
                          unselectedLabelStyle:
                              const TextStyle(color: unselectedColor),
                          borderWidth: 3,
                          borderColor: selectedColor,
                          unselectedBorderColor: Colors.transparent,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          onTap: (index) {
                            filterIndex = index;
                            filterContext.read<ProductsCubit>().switchFilter();
                          },
                          tabs: [
                            ...filters.map((e) => Tab(text: e)),
                          ],
                        ),
                      )
                    : const CircularProgressIndicator();
              },
            ),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (kDebugMode) {
                  print(state.runtimeType);
                }
                var productsList = [
                  context.read<ProductsCubit>().products,
                  context.read<ProductsCubit>().plants,
                  context.read<ProductsCubit>().seeds,
                  context.read<ProductsCubit>().tools,
                ];
                List<Product>? products = productsList[filterIndex];
                return state is ProductsFetchedSuccessfullyState ||
                        state is SwitchFilterState
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              var item = products[index];
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    item.imageUrl != null
                                        ? Expanded(
                                            child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Image.network(
                                                    '${AppConstants.apiBaseUrl}${products[index].imageUrl!}',
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    GestureDetector(
                                                      child: const Icon(
                                                        Icons.remove,
                                                        size: 15,
                                                      ),
                                                    ),
                                                    const Text(
                                                      '1',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    GestureDetector(
                                                      child: const Icon(
                                                        Icons.add,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ))
                                        : const CircularProgressIndicator(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 4),
                                      child: Text(
                                        item.name ?? '',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 4.0),
                                      child: Text(
                                        '${item.price ?? ''} EGP',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: MaterialButton(
                                          onPressed: () {},
                                          color: const Color(0xff1ABC00),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Text(
                                            'Add To Cart',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 3 / 4),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
