import 'package:equatable/equatable.dart';

import 'failure.dart';

class DataObject<T> extends Equatable {
  final T? data;
  final Failure? failure;

  const DataObject(this.data, {this.failure});

  @override
  List<Object?> get props => [data];
}
