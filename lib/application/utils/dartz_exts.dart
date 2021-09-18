import 'package:dartz/dartz.dart';

extension EitherHelpers<L, R> on Either<L, R> {
  R? unwrapRight() {
    return toOption().toNullable();
  }
}
