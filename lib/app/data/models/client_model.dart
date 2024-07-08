
class ClientModel {
  int? id;
  dynamic oldId;
  String? createdDate;
  String? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  bool? deleted;
  String? code;
  String? societe;
  int? mobileId;
  dynamic numRegistre;
  dynamic fiscal;
  String? artImpo;
  dynamic tel;
  dynamic tel2;
  dynamic fax;
  dynamic activite;
  dynamic type;
  dynamic banque;
  dynamic adresse;
  dynamic email;
  int? credit;
  int? creditInitial;
  int? creditMax;
  dynamic nif;
  dynamic nis;
  dynamic numAssurance;
  bool? active;
  int? category;
  int? echaience;
  Region? region;
  dynamic activity;
  int? remise;
  int? resteCreance;
  dynamic livreur;
  bool? mc;
  int? taux;
  dynamic dateNaissance;
  dynamic sexe;
  dynamic wilaya;

  ClientModel({this.id, this.oldId, this.createdDate, this.modifiedDate, this.createdBy, this.modifiedBy, this.deleted, this.code, this.societe, this.mobileId, this.numRegistre, this.fiscal, this.artImpo, this.tel, this.tel2, this.fax, this.activite, this.type, this.banque, this.adresse, this.email, this.credit, this.creditInitial, this.creditMax, this.nif, this.nis, this.numAssurance, this.active, this.category, this.echaience, this.region, this.activity, this.remise, this.resteCreance, this.livreur, this.mc, this.taux, this.dateNaissance, this.sexe, this.wilaya});

  ClientModel.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    oldId = json["oldId"];
    if(json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if(json["modifiedDate"] is String) {
      modifiedDate = json["modifiedDate"];
    }
    if(json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if(json["modifiedBy"] is String) {
      modifiedBy = json["modifiedBy"];
    }
    if(json["deleted"] is bool) {
      deleted = json["deleted"];
    }
    if(json["code"] is String) {
      code = json["code"];
    }
    if(json["societe"] is String) {
      societe = json["societe"];
    }
    if(json["mobileId"] is int) {
      mobileId = json["mobileId"];
    }
    numRegistre = json["numRegistre"];
    fiscal = json["fiscal"];
    if(json["artImpo"] is String) {
      artImpo = json["artImpo"];
    }
    tel = json["tel"];
    tel2 = json["tel2"];
    fax = json["fax"];
    activite = json["activite"];
    type = json["type"];
    banque = json["banque"];
    adresse = json["adresse"];
    email = json["email"];
    if(json["credit"] is int) {
      credit = json["credit"];
    }
    if(json["creditInitial"] is int) {
      creditInitial = json["creditInitial"];
    }
    if(json["creditMax"] is int) {
      creditMax = json["creditMax"];
    }
    nif = json["nif"];
    nis = json["nis"];
    numAssurance = json["numAssurance"];
    if(json["active"] is bool) {
      active = json["active"];
    }
    if(json["category"] is int) {
      category = json["category"];
    }
    if(json["echaience"] is int) {
      echaience = json["echaience"];
    }
    if(json["region"] is Map) {
      region = json["region"] == null ? null : Region.fromJson(json["region"]);
    }
    activity = json["activity"];
    if(json["remise"] is int) {
      remise = json["remise"];
    }
    if(json["resteCreance"] is int) {
      resteCreance = json["resteCreance"];
    }
    livreur = json["livreur"];
    if(json["mc"] is bool) {
      mc = json["mc"];
    }
    if(json["taux"] is int) {
      taux = json["taux"];
    }
    dateNaissance = json["dateNaissance"];
    sexe = json["sexe"];
    wilaya = json["wilaya"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["oldId"] = oldId;
    _data["createdDate"] = createdDate;
    _data["modifiedDate"] = modifiedDate;
    _data["createdBy"] = createdBy;
    _data["modifiedBy"] = modifiedBy;
    _data["deleted"] = deleted;
    _data["code"] = code;
    _data["societe"] = societe;
    _data["mobileId"] = mobileId;
    _data["numRegistre"] = numRegistre;
    _data["fiscal"] = fiscal;
    _data["artImpo"] = artImpo;
    _data["tel"] = tel;
    _data["tel2"] = tel2;
    _data["fax"] = fax;
    _data["activite"] = activite;
    _data["type"] = type;
    _data["banque"] = banque;
    _data["adresse"] = adresse;
    _data["email"] = email;
    _data["credit"] = credit;
    _data["creditInitial"] = creditInitial;
    _data["creditMax"] = creditMax;
    _data["nif"] = nif;
    _data["nis"] = nis;
    _data["numAssurance"] = numAssurance;
    _data["active"] = active;
    _data["category"] = category;
    _data["echaience"] = echaience;
    if(region != null) {
      _data["region"] = region?.toJson();
    }
    _data["activity"] = activity;
    _data["remise"] = remise;
    _data["resteCreance"] = resteCreance;
    _data["livreur"] = livreur;
    _data["mc"] = mc;
    _data["taux"] = taux;
    _data["dateNaissance"] = dateNaissance;
    _data["sexe"] = sexe;
    _data["wilaya"] = wilaya;
    return _data;
  }
}

class Region {
  int? id;
  dynamic oldId;
  String? createdDate;
  String? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  bool? deleted;
  String? name;
  bool? splitBon;
  dynamic livreur;

  Region({this.id, this.oldId, this.createdDate, this.modifiedDate, this.createdBy, this.modifiedBy, this.deleted, this.name, this.splitBon, this.livreur});

  Region.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    oldId = json["oldId"];
    if(json["createdDate"] is String) {
      createdDate = json["createdDate"];
    }
    if(json["modifiedDate"] is String) {
      modifiedDate = json["modifiedDate"];
    }
    if(json["createdBy"] is String) {
      createdBy = json["createdBy"];
    }
    if(json["modifiedBy"] is String) {
      modifiedBy = json["modifiedBy"];
    }
    if(json["deleted"] is bool) {
      deleted = json["deleted"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["splitBon"] is bool) {
      splitBon = json["splitBon"];
    }
    livreur = json["livreur"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["oldId"] = oldId;
    _data["createdDate"] = createdDate;
    _data["modifiedDate"] = modifiedDate;
    _data["createdBy"] = createdBy;
    _data["modifiedBy"] = modifiedBy;
    _data["deleted"] = deleted;
    _data["name"] = name;
    _data["splitBon"] = splitBon;
    _data["livreur"] = livreur;
    return _data;
  }
}