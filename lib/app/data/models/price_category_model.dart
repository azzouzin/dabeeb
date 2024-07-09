
class PriceModel {
  int? id;
  dynamic oldId;
  String? createdDate;
  String? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  bool? deleted;
  String? name;
  int? number;
  String? libelle;
  bool? activated;

  PriceModel({this.id, this.oldId, this.createdDate, this.modifiedDate, this.createdBy, this.modifiedBy, this.deleted, this.name, this.number, this.libelle, this.activated});

  PriceModel.fromJson(Map<String, dynamic> json) {
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
    if(json["number"] is int) {
      number = json["number"];
    }
    if(json["libelle"] is String) {
      libelle = json["libelle"];
    }
    if(json["activated"] is bool) {
      activated = json["activated"];
    }
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
    _data["number"] = number;
    _data["libelle"] = libelle;
    _data["activated"] = activated;
    return _data;
  }
}