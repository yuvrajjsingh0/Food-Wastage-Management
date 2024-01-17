import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalWastedItems extends StatelessWidget {
  TotalWastedItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          num totalItems = 0;
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            for(int i = 0; i < snapshot.data!.docs.length; i++) {
              totalItems += snapshot.data!.docs[i]['quantity'];
          }
          }
          return Text('Wasteagram - ${totalItems.toString()}');
        }
    );
  }
}

