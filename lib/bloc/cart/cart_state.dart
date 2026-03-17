class CartState {
  const CartState({
    this.quantity = 1,
    this.leaveAtDoor = false,
  });

  final int quantity;
  final bool leaveAtDoor;

  CartState copyWith({
    int? quantity,
    bool? leaveAtDoor,
  }) {
    return CartState(
      quantity: quantity ?? this.quantity,
      leaveAtDoor: leaveAtDoor ?? this.leaveAtDoor,
    );
  }
}
