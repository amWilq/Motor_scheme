class PartData {
  int _id = 0;
  String _nameTypePart = "";
  String _imageUrl = "";
  String _partsImageUrl = "";
  List _parts = [];

  PartData({
    required int id,
    required String nameTypePart,
    required String imageUrl,
    required String partsImageUrl,
    required List parts,
  }) {
    _id = id;
    _nameTypePart = nameTypePart;
    _imageUrl = imageUrl;
    _partsImageUrl = partsImageUrl;
    _parts = parts;
  }

  int get id => _id;
  set id(int value) => _id = value;

  String get nameTypePart => _nameTypePart;
  set nameTypePart(String value) => _nameTypePart = value;

  String get imageUrl => _imageUrl;
  set imageUrl(String value) => _imageUrl = value;

  String get partsImageUrl => _partsImageUrl;
  set partsImageUrl(String value) => _partsImageUrl = value;

  List get parts => _parts;
  set parts(List value) => _parts = value;
}
