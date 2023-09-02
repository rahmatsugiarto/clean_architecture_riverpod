class AppConstants {
  const AppConstants();

  static AppApi appApi = const AppApi();
  static ErrorMessage errorMessage = const ErrorMessage();
}

class AppApi {
  const AppApi();

  String get baseUrl => 'https://my-json-server.typicode.com';

  String get listMovie => '/horizon-code-academy/fake-movies-api/movies';
}

class ErrorMessage {
  const ErrorMessage();

  String get noInternet => "Can't connect, please check your connection";

  String get errorCommon => "Opss.. Sorry, Something went wrong";
}
