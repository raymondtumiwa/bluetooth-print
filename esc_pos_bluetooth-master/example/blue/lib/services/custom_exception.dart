class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message, "Unauthorised: ");
}

class InvalidToken extends CustomException {
  InvalidToken([message]) : super(message, "Invalid Token: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InvalidParameter extends CustomException {
  InvalidParameter([message]) : super(message, "Invalid Parameter: ");
}
