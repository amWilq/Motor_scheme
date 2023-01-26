class PartData {
  int _id = 0;
  String _nameTypePart = "";
  String _imageUrl = "";
  List _parts = [];

  PartData({
    required int id,
    required String nameTypePart,
    required String imageUrl,
    required List parts,
  }) {
    this._id = id;
    this._nameTypePart = nameTypePart;
    this._imageUrl = imageUrl;
    this._parts = parts;
  }

  int get id => _id;
  set id(int value) => _id = value;

  String get nameTypePart => _nameTypePart;
  set nameTypePart(String value) => _nameTypePart = value;

  String get imageUrl => _imageUrl;
  set imageUrl(String value) => _imageUrl = value;

  List get parts => _parts;
  set parts(List value) => _parts = value;
}
