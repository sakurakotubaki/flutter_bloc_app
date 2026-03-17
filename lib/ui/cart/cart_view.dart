import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_event.dart';
import '../../bloc/cart/cart_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const int _applePrice = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ショッピングカート'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final totalPrice = state.quantity * _applePrice;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProductCard(context, state),
                const SizedBox(height: 24),
                _BuildLeaveAtDoorOption(state: state),
                const Spacer(),
                _BuildTotalSection(totalPrice: totalPrice),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, CartState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.lime.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.apple,
                size: 48,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'りんご',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '¥$_applePrice',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.lime.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            _buildQuantitySelector(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context, CartState state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lime.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: state.quantity > 0
                ? () => context.read<CartBloc>().add(CartQuantityDecremented())
                : null,
            icon: const Icon(Icons.remove),
            color: Colors.lime.shade700,
          ),
          SizedBox(
            width: 40,
            child: Text(
              '${state.quantity}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          IconButton(
            onPressed: () =>
                context.read<CartBloc>().add(CartQuantityIncremented()),
            icon: const Icon(Icons.add),
            color: Colors.lime.shade700,
          ),
        ],
      ),
    );
  }
}

class _BuildLeaveAtDoorOption extends StatelessWidget {
  const _BuildLeaveAtDoorOption({required this.state});

  final CartState state;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: state.leaveAtDoor,
        onChanged: (_) =>
            context.read<CartBloc>().add(CartLeaveAtDoorToggled()),
        title: const Text('置き配 OK'),
        subtitle: const Text('不在時は玄関先に置いてください'),
        secondary: Icon(
          Icons.home_outlined,
          color: Colors.lime.shade700,
        ),
        activeColor: Colors.lime,
      ),
    );
  }
}

class _BuildTotalSection extends StatelessWidget {
  const _BuildTotalSection({required this.totalPrice});

  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lime.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '合計',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '¥$totalPrice',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lime.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}