import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String? code;
  int? prixAchat;
  int? prixVente;
  int? prixVente2;
  int? prixVente3;
  int? prixVente4;
  int? prixVenteMin;
  int? qte;
  int? qte1;
  int? qte2;
  int? qte3;
  int? qte4;
  int? qte5;
  int? qte6;
  int? qte7;
  dynamic dateExpiration;
  Product? product;
  bool? bloque;
  dynamic barcode;
  String? fournisseur;
  String? codeAchat;
  String? dateAchat;
  int? quantity;
  int? qteUniteMesure;
  String? refFournisseur;
  TextEditingController textEditingController = TextEditingController();

  ProductModel(
      {this.id,
      this.code,
      required this.textEditingController,
      this.prixAchat,
      this.quantity = 0,
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
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["prixAchat"] is int) {
      prixAchat = json["prixAchat"];
    }
    if (json["prixVente"] is int) {
      prixVente = json["prixVente"];
    }
    if (json["prixVente2"] is int) {
      prixVente2 = json["prixVente2"];
    }
    if (json["prixVente3"] is int) {
      prixVente3 = json["prixVente3"];
    }
    if (json["prixVente4"] is int) {
      prixVente4 = json["prixVente4"];
    }
    if (json["prixVenteMin"] is int) {
      prixVenteMin = json["prixVenteMin"];
    }
    if (json["qte"] is int) {
      qte = json["qte"];
    }
    if (json["qte1"] is int) {
      qte1 = json["qte1"];
    }
    if (json["qte2"] is int) {
      qte2 = json["qte2"];
    }
    if (json["qte3"] is int) {
      qte3 = json["qte3"];
    }
    if (json["qte4"] is int) {
      qte4 = json["qte4"];
    }
    if (json["qte5"] is int) {
      qte5 = json["qte5"];
    }
    if (json["qte6"] is int) {
      qte6 = json["qte6"];
    }
    if (json["qte7"] is int) {
      qte7 = json["qte7"];
    }
    dateExpiration = json["dateExpiration"];
    if (json["product"] is Map) {
      product =
          json["product"] == null ? null : Product.fromJson(json["product"]);
    }
    if (json["bloque"] is bool) {
      bloque = json["bloque"];
    }
    barcode = json["barcode"];
    if (json["fournisseur"] is String) {
      fournisseur = json["fournisseur"];
    }
    if (json["codeAchat"] is String) {
      codeAchat = json["codeAchat"];
    }
    if (json["dateAchat"] is String) {
      dateAchat = json["dateAchat"];
    }
    if (json["qteUniteMesure"] is int) {
      qteUniteMesure = json["qteUniteMesure"];
    }
    if (json["refFournisseur"] is String) {
      refFournisseur = json["refFournisseur"];
    }

    textEditingController = TextEditingController();
    quantity = 0;
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
  int? qte;
  int? qte1;
  int? qte2;
  int? qte3;
  int? qte4;
  int? qte5;
  int? qte6;
  int? qte7;
  int? prixUnitaire;
  int? prixDetail;
  int? prixGros;
  int? prixSpecial;
  int? prix4;
  int? tva;
  dynamic barcode;
  bool? bloque;
  String? shortDesignation;

  Product(
      {this.id,
      this.code,
      this.designation,
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
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["designation"] is String) {
      designation = json["designation"];
    }
    if (json["qte"] is int) {
      qte = json["qte"];
    }
    if (json["qte1"] is int) {
      qte1 = json["qte1"];
    }
    if (json["qte2"] is int) {
      qte2 = json["qte2"];
    }
    if (json["qte3"] is int) {
      qte3 = json["qte3"];
    }
    if (json["qte4"] is int) {
      qte4 = json["qte4"];
    }
    if (json["qte5"] is int) {
      qte5 = json["qte5"];
    }
    if (json["qte6"] is int) {
      qte6 = json["qte6"];
    }
    if (json["qte7"] is int) {
      qte7 = json["qte7"];
    }
    if (json["prixUnitaire"] is int) {
      prixUnitaire = json["prixUnitaire"];
    }
    if (json["prixDetail"] is int) {
      prixDetail = json["prixDetail"];
    }
    if (json["prixGros"] is int) {
      prixGros = json["prixGros"];
    }
    if (json["prixSpecial"] is int) {
      prixSpecial = json["prixSpecial"];
    }
    if (json["prix4"] is int) {
      prix4 = json["prix4"];
    }
    if (json["tva"] is int) {
      tva = json["tva"];
    }
    barcode = json["barcode"];
    if (json["bloque"] is bool) {
      bloque = json["bloque"];
    }
    if (json["shortDesignation"] is String) {
      shortDesignation = json["shortDesignation"];
    }
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
