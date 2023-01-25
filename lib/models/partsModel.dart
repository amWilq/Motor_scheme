class PartsModel {
  int id;
  String marka;
  int rokProdukcji;
  String typ;
  String Partsmodel;
  List<Czesc> czesci;

  PartsModel({
    required this.id,
    required this.marka,
    required this.rokProdukcji,
    required this.typ,
    required this.Partsmodel,
    required this.czesci,
  });

  factory PartsModel.fromJson(Map<String, dynamic> json) => PartsModel(
        id: json["id"],
        marka: json["marka"],
        rokProdukcji: json["rok_produkcji"],
        typ: json["typ"],
        Partsmodel: json["Partsmodel"],
        czesci: List<Czesc>.from(json["czesci"].map((x) => Czesc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "marka": marka,
        "rok_produkcji": rokProdukcji,
        "typ": typ,
        "Partsmodel": Partsmodel,
        "częsci": List<dynamic>.from(czesci.map((x) => x.toJson())),
      };
}

class Czesc {
  int id;
  String numerCzesci;
  String url;

  Czesc({
    required this.id,
    required this.numerCzesci,
    required this.url,
  });

  factory Czesc.fromJson(Map<String, dynamic> json) => Czesc(
        id: json["id"],
        numerCzesci: json["numer_części"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numer_części": numerCzesci,
        "url": url,
      };
}
