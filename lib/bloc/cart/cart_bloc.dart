import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartQuantityIncremented>(_onQuantityIncremented);
    on<CartQuantityDecremented>(_onQuantityDecremented);
    on<CartLeaveAtDoorToggled>(_onLeaveAtDoorToggled);
  }

  void _onQuantityIncremented(
    CartQuantityIncremented event,
    Emitter<CartState> emit,
  ) {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _onQuantityDecremented(
    CartQuantityDecremented event,
    Emitter<CartState> emit,
  ) {
    if (state.quantity > 0) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void _onLeaveAtDoorToggled(
    CartLeaveAtDoorToggled event,
    Emitter<CartState> emit,
  ) {
    emit(state.copyWith(leaveAtDoor: !state.leaveAtDoor));
  }
}
