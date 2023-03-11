class HttpSetup {
   Duration sendTimeout;
   Duration connectTimeout;
   Duration receiveTimeout;

  HttpSetup({this.sendTimeout = const Duration(seconds: 6) , this.connectTimeout = const Duration(seconds: 6), this.receiveTimeout = const Duration(seconds: 6)});
}