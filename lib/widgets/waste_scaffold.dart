import 'package:flutter/material.dart';
import '../screens/waste_new_post.dart';

class WasteScaffold extends StatelessWidget {
  final Widget title;
  final Widget child;
  final bool backButton;
  final bool fab;

  const WasteScaffold({Key? key, 
  required this.title, 
  required this.child, 
  required this.backButton,
  required this.fab})
   : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: backButton ? placeBackButton(context) : null,
          centerTitle: true,
          title: title,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: fab ? Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Make a new Post',
          label: 'Button to make a new Post',
          child: floatingButton(context)
        ) : null ,
        body: Center(
          child: child
          )
    );
  }

  Widget floatingButton(context) {
    return FloatingActionButton(
      onPressed: () {Navigator.pushNamed(context, WasteNewPost.routeName); },
      child: const Icon(Icons.photo_camera),
    );
  }

  Widget placeBackButton(context) {
    return Semantics(
      button: true,
      enabled: true,
      onTapHint: 'Return to previous page',
      label: 'Back Button to return to previous page',
      child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
    );
  }
}