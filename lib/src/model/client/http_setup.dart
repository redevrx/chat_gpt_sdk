class HttpSetup {
  Duration sendTimeout;
  Duration connectTimeout;
  Duration receiveTimeout;
  String proxy;

  HttpSetup({
    this.sendTimeout = const Duration(seconds: 6),
    this.connectTimeout = const Duration(seconds: 6),
    this.receiveTimeout = const Duration(seconds: 6),
    this.proxy = '',
  });
}
