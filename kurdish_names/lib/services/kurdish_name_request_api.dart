import 'package:http/http.dart' as http;
import 'package:kurdish_names/model/name_data_modal.dart';

class RequestNames {
// https://github.com/DevelopersTree/nawikurdi
// https://nawikurdi.com/

//API end point : https://nawikurdi.com/api
  Future<KurdishNamesModal> getnames(String limit, String gender) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'nawikurdi.com',
      path: 'api',
      queryParameters: {
        'limit': limit,
        'gender': gender,
        'offset': '0',
      },
    );

    http.Response response =
        await http.get(Uri.parse(url.toString())).catchError(
              (err) => print(err),
            );
    return KurdishNamesModal.fromJson(response.body);
  }
}
