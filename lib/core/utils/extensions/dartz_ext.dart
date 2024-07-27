import 'package:dartz/dartz.dart';

extension EitherX<L, R> on Either<L, R> {
  R asSuccess() => (this as Right).value;

  L asFailure() => (this as Left).value;

  bool get isError => isLeft();

  bool get isSuccess => isRight();
}
