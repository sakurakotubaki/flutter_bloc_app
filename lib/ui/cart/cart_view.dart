import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/ui/widget/count_button.dart';

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
                _BuildProductCard(state: state, applePrice: _applePrice),
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
}

class _BuildProductCard extends StatelessWidget {
  const _BuildProductCard({required this.state, required int applePrice})
      : _applePrice = applePrice;

  final CartState state;
  final int _applePrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child: Image.asset('assets/images/apple.jpg', fit: BoxFit.cover),
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
          _BuildQuantitySelector(state: state),
        ],
      ),
    );
  }
}

class _BuildQuantitySelector extends StatelessWidget {
  const _BuildQuantitySelector({required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    return QuantitySelector(
      quantity: state.quantity,
      onIncrement: () =>
          context.read<CartBloc>().add(CartQuantityIncremented()),
      onDecrement: () =>
          context.read<CartBloc>().add(CartQuantityDecremented()),
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