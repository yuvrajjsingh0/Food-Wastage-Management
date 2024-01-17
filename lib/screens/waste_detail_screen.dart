import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';
import '../widgets/waste_scaffold.dart';


class WasteDetail extends StatelessWidget {
  const WasteDetail({Key? key}) : super(key: key);

    static const routeName = 'wasteDetailScreen';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FoodWastePost;

    return WasteScaffold
      (title: Text('Wasteagram'), 
      backButton: true,
      fab: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(args.date, style: TextStyle(fontSize: 25)),
          const SizedBox(height: 35),
          Image.network(args.imageUrl),
          const SizedBox(height: 35),
          Text('${args.quantity.toString()} items', 
            style: TextStyle(fontSize: 25)),
          const SizedBox(height: 50),
          Text('Location: (${args.latitude}, ${args.longitude})', 
            style: TextStyle(fontSize: 15))
        ]
        ), 
      );
  }


}