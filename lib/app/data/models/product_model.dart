import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String? code;
  double? prixAchat;
  double? prixVente;
  double? prixVente2;
  double? prixVente3;
  double? prixVente4;
  double? prixVenteMin;
  double? qte;
  double? qte1;
  double? qte2;
  double? qte3;
  double? qte4;
  double? qte5;
  double? qte6;
  double? qte7;
  dynamic dateExpiration;
  Product? product;
  bool? bloque;
  dynamic barcode;
  dynamic fournisseur;
  dynamic codeAchat;
  String? description;
  dynamic dateAchat;
  double? qteUniteMesure;
  String? refFournisseur;
  double? quantity;
  TextEditingController? qtyController;
  TextEditingController? priceController;
  List<String> images = [];
  ProductModel(
      {this.id,
      this.code,
      this.quantity = 1,
      this.qtyController,
      this.images = const [],
      this.priceController,
      this.description,
      this.prixAchat,
      this.prixVente,
      this.prixVente2,
      this.prixVente3,
      this.prixVente4,
      this.prixVenteMin,
      this.qte,
      this.qte1,
      this.qte2,
      this.qte3,
      this.qte4,
      this.qte5,
      this.qte6,
      this.qte7,
      this.dateExpiration,
      this.product,
      this.bloque,
      this.barcode,
      this.fournisseur,
      this.codeAchat,
      this.dateAchat,
      this.qteUniteMesure,
      this.refFournisseur});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    prixAchat = json["prixAchat"];
    prixVente = json["prixVente"];
    prixVente2 = json["prixVente2"];
    prixVente3 = json["prixVente3"];
    prixVente4 = json["prixVente4"];
    prixVenteMin = json["prixVenteMin"];
    qte = json["qte"];
    qte1 = json["qte1"];
    qte2 = json["qte2"];
    qte3 = json["qte3"];
    qte4 = json["qte4"];
    qte5 = json["qte5"];
    qte6 = json["qte6"];
    qte7 = json["qte7"];
    description = json["description"];
    dateExpiration = json["dateExpiration"];
    product =
        json["product"] == null ? null : Product.fromJson(json["product"]);
    bloque = json["bloque"];
    barcode = json["barcode"];
    fournisseur = json["fournisseur"];
    codeAchat = json["codeAchat"];
    dateAchat = json["dateAchat"];
    qteUniteMesure = json["qteUniteMesure"] ?? 1.0;
    refFournisseur = json["refFournisseur"];
    quantity = 1;
    qtyController = TextEditingController(text: '1');
    priceController = TextEditingController();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["code"] = code;
    _data["prixAchat"] = prixAchat;
    _data["prixVente"] = prixVente;
    _data["prixVente2"] = prixVente2;
    _data["prixVente3"] = prixVente3;
    _data["prixVente4"] = prixVente4;
    _data["prixVenteMin"] = prixVenteMin;
    _data["qte"] = qte;
    _data["qte1"] = qte1;
    _data["qte2"] = qte2;
    _data["qte3"] = qte3;
    _data["qte4"] = qte4;
    _data["qte5"] = qte5;
    _data["qte6"] = qte6;
    _data["qte7"] = qte7;
    _data["dateExpiration"] = dateExpiration;
    if (product != null) {
      _data["product"] = product?.toJson();
    }
    _data["bloque"] = bloque;
    _data["barcode"] = barcode;
    _data["fournisseur"] = fournisseur;
    _data["codeAchat"] = codeAchat;
    _data["dateAchat"] = dateAchat;
    _data["qteUniteMesure"] = qteUniteMesure;
    _data["refFournisseur"] = refFournisseur;
    return _data;
  }
}

class Product {
  int? id;
  String? code;
  String? designation;
  double? qte;
  double? qte1;
  double? qte2;
  double? qte3;
  double? qte4;
  String? description;
  double? qte5;
  double? qte6;
  double? qte7;
  double? prixUnitaire;
  double? prixDetail;
  double? prixGros;
  double? prixSpecial;
  double? prix4;
  int? tva;
  dynamic barcode;
  bool? bloque;
  String? shortDesignation;

  Product(
      {this.id,
      this.code,
      this.designation,
      this.description,
      this.qte,
      this.qte1,
      this.qte2,
      this.qte3,
      this.qte4,
      this.qte5,
      this.qte6,
      this.qte7,
      this.prixUnitaire,
      this.prixDetail,
      this.prixGros,
      this.prixSpecial,
      this.prix4,
      this.tva,
      this.barcode,
      this.bloque,
      this.shortDesignation});

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    description = json["description"];
    designation = json["designation"];
    qte = json["qte"];
    qte1 = json["qte1"];
    qte2 = json["qte2"];
    qte3 = json["qte3"];
    qte4 = json["qte4"];
    qte5 = json["qte5"];
    qte6 = json["qte6"];
    qte7 = json["qte7"];
    prixUnitaire = json["prixUnitaire"];
    prixDetail = json["prixDetail"];
    prixGros = json["prixGros"];
    prixSpecial = json["prixSpecial"];
    prix4 = json["prix4"];
    tva = json["tva"];
    barcode = json["barcode"];
    bloque = json["bloque"];
    shortDesignation = json["shortDesignation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["code"] = code;
    _data["designation"] = designation;
    _data["qte"] = qte;
    _data["qte1"] = qte1;
    _data["qte2"] = qte2;
    _data["qte3"] = qte3;
    _data["qte4"] = qte4;
    _data["qte5"] = qte5;
    _data["qte6"] = qte6;
    _data["qte7"] = qte7;
    _data["prixUnitaire"] = prixUnitaire;
    _data["prixDetail"] = prixDetail;
    _data["prixGros"] = prixGros;
    _data["prixSpecial"] = prixSpecial;
    _data["prix4"] = prix4;
    _data["tva"] = tva;
    _data["barcode"] = barcode;
    _data["bloque"] = bloque;
    _data["shortDesignation"] = shortDesignation;
    return _data;
  }
}
