import 'package:http/http.dart' as http;

  Future<void> sendRequestToFeeder(String ipOfFeeder, String endpoint) async{
    try {
      final response = await http.get(Uri.parse('http://$ipOfFeeder:8000$endpoint'));
      if (response.statusCode == 4){
        print("request: cool1");
      }
      else{
        print('request bad');
      }
    } catch (e){
      print('error sending packet: $e');
    }
  

}