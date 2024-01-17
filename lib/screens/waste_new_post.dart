import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/waste_scaffold.dart';
import '../services/shared_location.dart';
import 'waste_list_screen.dart';


class WasteNewPost extends StatefulWidget {
  final analytics;
  
  const WasteNewPost({Key? key, required this.analytics}) : super(key: key);

    static const routeName = 'newWastePost';

  @override
  State<WasteNewPost> createState() => _WasteNewPostState();
}

class _WasteNewPostState extends State<WasteNewPost> {
  File? image;
  String? url;
  int? wastedItems;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path); 
    setState(() {});
    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    url = await storageReference.getDownloadURL();
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return WasteScaffold(
      title: Text('New Post'), 
      backButton: true, 
      fab: false,
      child: postBody(),
      );
  }

  Widget postBody() {
    if(image == null && url == null){
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.file(image!),
              const SizedBox(height: 40),
              wasteQuantityForm(),
              SizedBox(height: 30),
              uploadPostButton()
            ]
            ),
        ),
      );
    }
  }

  Widget wasteQuantityForm() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: formKey,
        child: Semantics(
          label: 'Enter number of wasted items',
          textField: true,
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            autocorrect: true,
            decoration: const InputDecoration(
              hintText: 'Number of Wasted Items',
            ),
            style: TextStyle(fontSize: 25),
            onSaved: (value) {
              wastedItems = int.parse(value!);
            },
            validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter amount of wasted items';
            } else {
              return null;
            }
            },
          ),
        )
      ),
    );
  }

  Widget uploadPostButton() {
    return SizedBox(
      width: double.infinity,
      child: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Press the button to post',
        label: 'Pressing the button saves the post',
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()){
              formKey.currentState?.save();
              _setUserId();
              _sendAnalyticsEvent();
              uploadData(url, wastedItems);
                Navigator.pushNamed(context, WasteList.routeName);
            }
          }, 
          child: Column(
            children: const [
              Icon(Icons.cloud_upload_rounded, size: 75,),
              Text('Upload Post'),
              SizedBox(height: 15,)
            ],
          )),
      ),
    );
  }

  Future<void> _setUserId() async {
    await widget.analytics.setUserId(id: '@John_Doe@');
  }

  Future<void> _sendAnalyticsEvent() async {
    await widget.analytics.logEvent(
      name: 'new_post_event',
      parameters: <String, dynamic>{
        'string': 'Quantity of wasted items:',
        'int': wastedItems,
      },
    );
  }

  void uploadData(url, wastedItems) async {
    final coordinates = await SharedLocation().retrieveLocation();
    final double latitude = coordinates.latitude;
    final double longitude = coordinates.longitude;
    final DateTime date = DateTime.now();
    FirebaseFirestore.instance
        .collection('posts')
        .add({ 'date': date, 'imageUrl': url, 'quantity': wastedItems, 'latitude' : latitude, 'longitude': longitude});
  }

}


