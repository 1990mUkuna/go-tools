class RequestError {
  String message;

  RequestError({
    this.message,
  });

  @override
  String toString() => 'Request(message: $message)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
