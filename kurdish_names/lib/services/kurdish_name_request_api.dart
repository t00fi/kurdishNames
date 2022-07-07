import 'package:http/http.dart' as http;
import 'package:kurdish_names/model/name_data_modal.dart';

class RequestNames {
// https://github.com/DevelopersTree/nawikurdi
// https://nawikurdi.com/
//API end point : https://nawikurdi.com/api

//create method with type future to send request to the api .
  Future<KurdishNamesModal> getnames(String limit, String gender) async {
    //create url to send request for it.
    Uri url = Uri(
      scheme: 'https',
      host: 'nawikurdi.com',
      path: 'api',
      //query paramaeter are used for get request.
      queryParameters: {
        'limit': limit,
        'gender': gender,
        'offset': '0',
      },
    );

    //get response from the api if there is any data
    //send get() request to the api
    http.Response response =
        await http.get(Uri.parse(url.toString())).catchError(
              (err) => print(err),
            );
    return KurdishNamesModal.fromJson(response.body);
  }

//method to vote for names
  Future vote(String id, bool isPosative) async {
    //url path for vote
    String url = "https://nawikurdi.com/api/vote";
    //define a variable for impact if its posative or negative used for voting.

    //body property because  postman software i used body and send request inside postman's body to test the api .
    await http.post(
      Uri.parse(url),
      body: {
        "name_id": id,
        "uid": '${id}abc',
        "impact": isPosative == true ? 'positive' : 'negative',
      },
    );
  }
}
