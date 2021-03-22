import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oscar_interview/models/constant.dart';
import 'package:intl/intl.dart';

class Design extends StatefulWidget {
  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<Design> {
  String _uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,
          title: Text(
            "Design",
            style: GoogleFonts.muli(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        // backgroundColor: white,
        body: SafeArea(
            child: ListView(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.82,
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.documents.length != 0) {
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => _buildListItem(
                            context, snapshot.data.documents[index]),
                      );
                    } else {
                      return Center(
                        child: Image.asset(
                          'assets/images/nodata.png',
                          height: 200,
                          width: 250,
                        ),
                      );
                    }
                  } else {
                    return Center(
                        child: Container(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    kPrimaryColor))));
                  }
                }),
          )
        ])));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    DateTime now = DateTime.now();

    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: kPrimaryColor.withOpacity(0.2),
                    offset: Offset(3, 2),
                    blurRadius: 30)
              ]),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: DateFormat.yMMMMEEEEd().format(
                                      DateTime.parse(document['createdAt']
                                          .toDate()
                                          .toString())) +
                                  "\n",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Name :${document["name"]} " + "\n" + "\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "phone :${document["phone"]} " + "\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300)),
                          TextSpan(
                              text: "email :${document["email"]} ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
