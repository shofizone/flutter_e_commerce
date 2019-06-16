
import 'package:e_commerce_flutter/util/auth_helper.dart';

class Product {
  String id;
  String name;
  String description;
  double price;
  Null user;
  int createdAt;
  int updatedAt;
  Picture picture;


  Product(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.picture});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    description = json['description'];
    price = json['price'] != null ? json['price'].toDouble(): 0.0;
    user = json['user'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    picture =
    json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['user'] = this.user;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.picture != null) {
      data['picture'] = this.picture.toJson();
    }
    return data;
  }
}

class Picture {
  int id;
  String name;
  String hash;
  String sha256;
  String ext;
  String mime;
  String size;
  String url;
  String provider;
  Null publicId;
  int createdAt;
  int updatedAt;

  Picture(
      {this.id,
        this.name,
        this.hash,
        this.sha256,
        this.ext,
        this.mime,
        this.size,
        this.url,
        this.provider,
        this.publicId,
        this.createdAt,
        this.updatedAt});

  Picture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hash = json['hash'];
    sha256 = json['sha256'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = "${AuthHelper.baseUrl}${json['url']}";
    provider = json['provider'];
    publicId = json['public_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['sha256'] = this.sha256;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
    data['url'] = this.url;
    data['provider'] = this.provider;
    data['public_id'] = this.publicId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}