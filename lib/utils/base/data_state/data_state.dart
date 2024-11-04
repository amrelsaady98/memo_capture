abstract class DataState<T> {
  final T? data;
  final Exception? exception;

  const DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataField<T> extends DataState<T> {
  DataField(Exception exception) : super(exception: exception);
}
