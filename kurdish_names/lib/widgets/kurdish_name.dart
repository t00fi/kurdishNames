import 'package:flutter/material.dart';
import 'package:kurdish_names/model/name_data_modal.dart';
import 'package:kurdish_names/services/kurdish_name_request_api.dart';

class Names extends StatefulWidget {
  Names({Key? key}) : super(key: key);

  @override
  State<Names> createState() => _NamesState();
}

class _NamesState extends State<Names> {
  List<String> _genders = [
    'Male',
    'Female',
  ];

  List<String> _limits = ['10', '20', '30', '40'];
  String _genderValue = 'M';
  String _limitValue = '10';
  RequestNames _requestNames = RequestNames();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
              hint: const Text(
                'Gender',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              items: _genders
                  .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                  .toList(),
              onChanged: (dropValue) {
                setState(() {
                  if (dropValue == 'Male') {
                    _genderValue = 'M';
                  } else {
                    _genderValue = 'F';
                  }
                });
              },
            ),
            DropdownButton(
              hint: const Text(
                'limit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              items: _limits
                  .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                  .toList(),
              onChanged: (dropValue) {
                setState(() {
                  _limitValue = dropValue.toString();
                });
              },
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: FutureBuilder(
                future: _requestNames.getnames(_limitValue, _genderValue),
                builder: ((ctx, AsyncSnapshot<KurdishNamesModal> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.data == null) {
                    return const Text('No Data');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.names.length,
                    itemBuilder: (ctx, index) {
                      return ExpansionTile(
                        title: Text(
                          snapshot.data!.names[index].name,
                        ),
                        children: [
                          Text(snapshot.data!.names[index].desc),
                        ],
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        )
      ],
    );
  }
}
