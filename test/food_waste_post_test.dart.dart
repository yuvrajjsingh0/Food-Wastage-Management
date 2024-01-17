import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/main.dart';
import '../lib/models/food_waste_post.dart';

void main() {
  test('Post created should have the correct values', () {
    final date = DateTime.now().toString();
    const imageUrl = 'None';
    const quantity = 5;
    const latitude = '2.0';
    const longitude = '3.0';

    final newPost = FoodWastePost(
      date: date, 
      imageUrl: imageUrl, 
      quantity: quantity, 
      latitude: latitude, 
      longitude: longitude
      );

    expect(newPost.date, date);
    expect(newPost.imageUrl, imageUrl);
    expect(newPost.quantity, quantity);
    expect(newPost.latitude, latitude);
    expect(newPost.longitude, longitude);
  });
  
}
