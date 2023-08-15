import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/expanded_container/expanded_container_bloc.dart';
import 'package:janganan/bloc/quantity_counter/quantity_counter_bloc.dart';
import 'package:janganan/bloc/total_price/total_price_bloc.dart';
import 'package:janganan/data/models/janganan_item_model.dart';
import 'package:janganan/presentation/widgets/janganan_list_widgets/janganan_add_to_cart.dart';
import 'package:janganan/presentation/widgets/janganan_list_widgets/janganan_detail.dart';
import 'package:janganan/presentation/widgets/janganan_list_widgets/janganan_quantity.dart';

class JangananListItems extends StatelessWidget {
  const JangananListItems({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.filteredItems,
  });

  final int index;
  final bool isExpanded;
  final List<JangananItem> filteredItems;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuantityCounterBloc(
              isIntType: filteredItems[index].category.title == 'Vegetable'),
        ),
        BlocProvider(
          create: (context) => TotalPriceBloc(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          context
              .read<ExpandedContainerBloc>()
              .add(ToggleExpandedContainer(expandedContainerIndex: index));
        },
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: isExpanded ? 250 : 125,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.asset(
                            filteredItems[index].itemImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                        _buildItemDetailInfo(),
                      ],
                    ),
                  ),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BlocListener<QuantityCounterBloc,
                                  QuantityCounterState>(
                                listenWhen: (prev, curr) =>
                                    prev.quantity != curr.quantity,
                                listener: (context, state) {
                                  context.read<TotalPriceBloc>().add(
                                      TotalPriceCounterEvent(
                                          price: filteredItems[index].price,
                                          quantity: state.quantity.toDouble()));
                                },
                                child: BlocBuilder<TotalPriceBloc,
                                    TotalPriceCounterState>(
                                  builder: (context, totalPriceState) => Text(
                                    'Total: ${totalPriceState.totalPrice}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildQuantityCounter(),
                              _buildAddToCartButton(context),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              '*harga dapat berubah sewaktu-waktu, jika ada perbedaan harga, maka harga di tempat adalah harga yang berlaku',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Item detail info widget
  Widget _buildItemDetailInfo() => JangananDetail(
        itemName: filteredItems[index].itemName,
        itemCategory: filteredItems[index].category.title,
        catImage: filteredItems[index].category.catIcon,
        itemStock: 'stok: ${filteredItems[index].stock.toString()}',
        itemPrice: 'harga: Rp ${filteredItems[index].price.toString()}',
      );

  // Quantity counter widget
  Widget _buildQuantityCounter() =>
      BlocBuilder<QuantityCounterBloc, QuantityCounterState>(
        builder: (context, countState) {
          return JangananQuantity(
            quantityDecrement: () {
              context.read<QuantityCounterBloc>().add(DecrementEvent());
            },
            quantity: '${countState.quantity}',
            quantityIncrement: () {
              context.read<QuantityCounterBloc>().add(IncrementEvent());
            },
          );
        },
      );

  // Add to cart button widget
  Widget _buildAddToCartButton(BuildContext context) =>
      JangananAddToCart(addToCart: () {}, buttonText: 'Add to Cart');
}
