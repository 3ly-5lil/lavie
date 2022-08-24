part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressSentError extends AddressState {
  ClaimFreeSeedResponse response;

  AddressSentError(this.response);
}

class AddressSentSuccessful extends AddressState {
  ClaimFreeSeedResponse response;

  AddressSentSuccessful(this.response);
}
