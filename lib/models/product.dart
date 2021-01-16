import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  String id;
  String barcode;
  String packaging;
  int used;
  double height;
  double length;
  double width;
  double weight;
  bool isFood;
  Timestamp time;
  Timestamp expiration;

  DocumentReference reference;

Product({this.name, this.id, this.barcode, this.packaging, this.used, this.height, this.length, this.width, this.weight, this.isFood, this.time, this.expiration});

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    Product newProduct = Product.fromJson(snapshot.data());
    newProduct.reference = snapshot.reference;
    return newProduct;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      id: json['id'] as String,
      barcode: json['barcode'] as String,
      packaging: json['packaging'] as String,
      used: json['used'] as int,
      height: json['height'] as double,
      length: json['length'] as double,
      width: json['width'] as double,
      weight: json['weight'] as double,
      isFood: json['isFood'] as bool,
      time: json['time'] as Timestamp,
      expiration: json['expiration'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => _ProductToJson(this);

  Map<String, dynamic> _ProductToJson(Product instance) {
    return <String, dynamic> {
      'name': instance.name,
      'id': instance.id,
      'barcode': instance.barcode,
      'packaging': instance.packaging,
      'used': instance.used,
      'height': instance.height,
      'length': instance.length,
      'width': instance.width,
      'weight': instance.weight,
      'isFood': instance.isFood,
      'time': instance.time,
      'expiration': instance.expiration,
    };
  }
}