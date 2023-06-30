class UnauthorizedException implements Exception {
  const UnauthorizedException();
}

class UnexpectedException implements Exception {
  final String? message;

  const UnexpectedException([this.message]);

  @override
  String toString() {
    if (message == null) return "Unexpected Exception";
    return "Unexpected Exception: $message";
  }

}

class NetworkErrorException implements Exception {
  final String? message;

  const NetworkErrorException([this.message]);

  @override
  String toString() {
    if (message == null) return "Network Exception";
    return "Network Exception: $message";
  }

}

class BadRequestException implements Exception {
  final String? message;

  const BadRequestException([this.message]);

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }

}

class ForbiddenException implements Exception {
  final String? message;

  const ForbiddenException([this.message]);

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }

}

class NotAcceptableException implements Exception {
  final String? message;

  const NotAcceptableException([this.message]);

  @override
  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }

}

class PreferncesException implements Exception {
  final String? message;

  const PreferncesException([this.message]);

  @override
  String toString() {
    if (message == null) return "Pref Exception";
    return "Pref Exception: $message";
  }

}