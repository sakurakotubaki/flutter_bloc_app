sealed class CartEvent {}

final class CartQuantityIncremented extends CartEvent {}

final class CartQuantityDecremented extends CartEvent {}

final class CartLeaveAtDoorToggled extends CartEvent {}
