class Resource<T> {
  final Status status;
  bool isLoading = false;
  final T? data;
  final String? message;

  Resource(this.status, this.message, this.data);

}

enum Status {
  success,
  badRequest,
  unexpectedError,
  unauthorized
}