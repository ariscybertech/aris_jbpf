import 'package:http/http.dart' as http;

class APIService<T> {
  final String url;
  final dynamic body;
  T Function(http.Response response) parse;
  APIService({this.url, this.body, this.parse});  
}

class APIWeb{
  final String urlHost = 'http://192.168.102.95:3001/'; 
  Future<T> load<T>(APIService<T> resource) async {
      final response = await http.get(urlHost + resource.url);
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception('Failed to load data!');
      }
  }

  Future<T> post<T>(APIService<T> resource) async {
      final response = await http.post(urlHost + resource.url, body: resource.body);
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception('Failed to post data!');
      }
  }
}