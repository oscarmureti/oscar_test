import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oscar_interview/models/constant.dart';
import 'package:oscar_interview/models/dictionary.dart';

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  String _uid;
  List<Dictionary1> fields = [
    new Dictionary1(
      '34',
      'thirty-four',
    ),
    new Dictionary1(
      '90',
      'ninety',
    ),
    new Dictionary1(
      '91',
      'ninety-one',
    ),
    new Dictionary1(
      '21',
      'twenty-one',
    ),
    new Dictionary1(
      '61',
      'sixty-one',
    ),
    new Dictionary1('9', 'nine'),
    new Dictionary1('2', 'two'),
    new Dictionary1('6', 'six'),
    new Dictionary1('3', 'three'),
    new Dictionary1('8', 'eight'),
    new Dictionary1('80', 'eighty'),
    new Dictionary1('81', 'eighty-one'),
    new Dictionary1('99', 'Ninety-Nine'),
    new Dictionary1('900', 'nine-hundred'),
  ];
// Dictionary = {'34': 'thirty-four', '90': 'ninety',
// '91': 'ninety-one''21': 'twenty-one',
// '61': 'sixty-one', '9': 'nine',
// '2': 'two', '6': 'six', '3': 'three',
// '8': 'eight', '80': 'eighty', '81': 'eighty-one',
// 'Ninety-Nine': '99', 'nine-hundred': '900'}
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          "Dictionary",
          style: GoogleFonts.muli(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            setState(() {
              fields.sort(
                  (a, b) => int.parse(a.title).compareTo(int.parse(b.title)));
            });
          },
          label: Text('press to sort in ascending')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: fields.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: new Text("${fields[index].title}"),
                            subtitle: new Text(fields[index].number),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
