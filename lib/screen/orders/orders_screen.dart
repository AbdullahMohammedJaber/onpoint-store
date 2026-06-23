import 'package:ecommerce_one/core/localization/app_localizations.dart';
import 'package:ecommerce_one/core/widgets/app_title_bar.dart';
import 'package:ecommerce_one/controller/orders_cubit.dart';
import 'package:ecommerce_one/controller/orders_state.dart';
import 'package:ecommerce_one/utils/services/defulat_text.dart';
import 'package:ecommerce_one/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTitleBar(title: context.tr('orders')),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state.orders.isEmpty) {
            return Center(
              child: DefaultText(
                context.tr('orders_empty'),
                fontSize: 14,
                color: ColorManager.textGrey,
              ),
            );
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: ListView.separated(
              key: ValueKey(state.orders.length),
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 180 + index * 45),
                  tween: Tween(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 16 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            order.id,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 8),
                          DefaultText(
                            '${order.items.length} products',
                            fontSize: 12,
                            color: ColorManager.textGrey,
                          ),
                          const SizedBox(height: 8),
                          DefaultText(
                            '\$${order.total.toStringAsFixed(2)}',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
