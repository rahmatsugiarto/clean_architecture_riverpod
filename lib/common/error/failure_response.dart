import 'package:equatable/equatable.dart';

class FailureResponse extends Equatable {
  final String errorMessage;
  const FailureResponse({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ServerFailure extends FailureResponse {
  const ServerFailure(String errorMessage) : super(errorMessage: errorMessage);
}

class ConnectionFailure extends FailureResponse {
  const ConnectionFailure(String errorMessage)
      : super(errorMessage: errorMessage);
}
