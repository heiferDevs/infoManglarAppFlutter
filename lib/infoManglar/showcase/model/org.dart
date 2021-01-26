import '../../../util/utility.dart';
import 'package:flutter/material.dart';

class Org {

  String name;
  String image;
  String principalActivity;
  String summary;

  String contactSellerName;
  String contactSellerMobile;
  String contactSellerAdress;
  String creation;

  int nSocios;

  List<String> importantPoints;

  List<Product> products;

  List<Service> services;

  List<Project> projects;

  List<Document> documents;

  Org({
    Key key,
    @required this.name,
    this.image,
    this.summary = '',
    this.principalActivity = '',
    this.contactSellerName,
    this.contactSellerMobile,
    this.contactSellerAdress,
    this.importantPoints,
    this.products,
    this.services,
    this.projects,
    this.documents,
  });

  factory Org.fromJson(Map<String, dynamic> json) {
    List<Product> productsFromJson = json['products'].map<Product>( (p) => Product.fromJson(p) ).toList();
    List<Service> servicesFromJson = json['services'].map<Service>( (p) => Service.fromJson(p) ).toList();
    List<Project> projectsFromJson = json['projects'].map<Project>( (p) => Project.fromJson(p) ).toList();
    List<Document> documentsFromJson = json['documents'].map<Document>( (p) => Document.fromJson(p) ).toList();
    return Org(
      name: json['name'],
      image: json['image'],
      summary: json['summary'],
      principalActivity: json['principalActivity'],
      contactSellerName: json['contactSellerName'],
      contactSellerMobile: json['contactSellerMobile'],
      contactSellerAdress: json['contactSellerAdress'],
      importantPoints: json['importantPoints'].cast<String>(),
      products: Utility.filterNull(productsFromJson),
      services: Utility.filterNull(servicesFromJson),
      projects: Utility.filterNull(projectsFromJson),
      documents: Utility.filterNull(documentsFromJson),
    );
  }

  hasProducts(){
    return products != null && products.length > 0;
  }

  hasServices(){
    return services != null && services.length > 0;
  }

  hasProjects(){
    return projects != null && projects.length > 0;
  }

  hasDocuments(){
    return documents != null && documents.length > 0;
  }

  hasImportantPoints(){
    return importantPoints != null && importantPoints.length > 0;
  }
}


class Product {

  String image;
  String name;
  String quality;
  String price; // String like $18.00/Sarta | $10.00/Ciento

  int stock;

  Product({
    @required this.name,
    @required this.image,
    @required this.quality,
    @required this.stock,
    @required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['image'],
      quality: json['quality'],
      stock: json['stock'],
      price: json['price'],
    );
  }

}

class Service {

  String image;
  String name;
  String desc;
  String price; // String like $18.00/Sarta | $10.00/Ciento

  Service({
    Key key,
    @required this.name,
    @required this.image,
    @required this.desc,
    @required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      image: json['image'],
      desc: json['desc'],
      price: json['price'],
    );
  }

}

class Project {

  String image;
  String name;
  String desc;

  Project({
    Key key,
    @required this.name,
    @required this.image,
    @required this.desc,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      image: json['image'],
      desc: json['desc'],
    );
  }

}

class Document {

  String image;
  String name;
  String desc;

  Document({
    Key key,
    @required this.name,
    @required this.image,
    @required this.desc,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      name: json['name'],
      image: json['image'],
      desc: json['desc'],
    );
  }

}
