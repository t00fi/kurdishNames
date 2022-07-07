import 'package:flutter/material.dart';
import 'package:kurdish_names/model/name_data_modal.dart';
import 'package:kurdish_names/services/kurdish_name_request_api.dart';

class Names extends StatefulWidget {
  Names({Key? key}) : super(key: key);

  @override
  State<Names> createState() => _NamesState();
}

class _NamesState extends State<Names> {
  //list of gender to map through its index dynamically
  List<String> _genders = [
    'Male',
    'Female',
  ];

  List<String> _limits = ['10', '20', '30', '40'];
  String _genderValue = 'M';
  String _limitValue = '10';
  //create object for clas requestNAmes which is in kurdish_name_request.dart file
  RequestNames _requestNames = RequestNames();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //row is used for dropDown buttons
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
        //the responded data showed in expanstion tile
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            //Directionality widget used to set widgets directions.
            child: Directionality(
              textDirection: TextDirection.rtl,
              //futureBuilder widget is used when we have some data we get it from api, sfter the value we want is know .etc.
              child: FutureBuilder(
                //call getnames() method with help of object to send request to api.
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
                        leading: Text('${snapshot.data!.names[index].nameId}'),
                        title: Text(
                          snapshot.data!.names[index].name,
                        ),
                        children: [
                          Text(snapshot.data!.names[index].desc),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _requestNames
                                      .vote(
                                    snapshot.data!.names[index].nameId
                                        .toString(),
                                    true,
                                  )
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                icon: const Icon(Icons.thumb_up),
                                label: Text(
                                  '${snapshot.data!.names[index].positiveVotes}',
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _requestNames
                                      .vote(
                                    snapshot.data!.names[index].nameId
                                        .toString(),
                                    false,
                                  )
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                icon: const Icon(Icons.thumb_down),
                                label: Text(
                                  '${snapshot.data!.names[index].negativeVotes}',
                                ),
                              ),
                            ],
                          )
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
