import 'package:flutter/material.dart';
import '../services/shared_location.dart';
import '../widgets/waste_scaffold.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_waste_post.dart';
import 'waste_detail_screen.dart';
import 'package:intl/intl.dart';
import '../widgets/total_wasted_items.dart';


class WasteList extends StatelessWidget {
   WasteList({Key? key}) : super(key: key);

    static const routeName = '/';
    late List posts;
    Widget totalItems = TotalWastedItems();


  @override
  Widget build(BuildContext context) {
    return  WasteScaffold(
      title: totalItems,
      backButton: false, 
      fab: true, 
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            posts = snapshot.data!.docs;
            posts.sort(((a, b) {
              return a['date'].compareTo(b['date']);
            }));
            return Column(
              children: [
               displayPosts(snapshot),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator())
              ],
            );
          }
        }));
  }

  Widget displayPosts(snapshot) {
    return Expanded(
      child: ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          return Semantics(
            label: 'Post with date and quantity of items, press to see more details',
            onTapHint: 'See details of post',
            child: ListTile(
                leading: Text(formatDate(posts[index]['date']), style: TextStyle(fontSize: 20)),
                trailing: Text(posts[index]['quantity'].toString(), style: TextStyle(fontSize: 25),),
                onTap: () {
                  Navigator.pushNamed(context, WasteDetail.routeName, arguments: FoodWastePost(
                    date: formatDate(posts[index]['date']), 
                    imageUrl: posts[index]['imageUrl'], 
                    quantity: posts[index]['quantity'], 
                    latitude: posts[index]['latitude'].toString(),
                    longitude: posts[index]['longitude'].toString()
                  ));
                }
            ),
          );
        },
      ),
    );
  }

  String formatDate(date) {
    DateTime date1 = DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
    return DateFormat('EEEE, MMMM d, y').format(date1).toString();
  }
}