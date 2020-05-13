class MyTrack {

  int _id;
  String _name;
  String _uri;

  // Constructors
  MyTrack(this._name, this._uri);
  MyTrack.withId(this._id, this._name, this._uri);

  // getters
  int get id => _id;
  String get name => _name;
  String get uri => _uri;

  // setters
  set name(String newName) {
    this._name = newName;
  }

  set uri(String newUri) {
    this._uri = uri;
  }

  // Convert a MyTrack object to a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['name'] = _name;
    map['uri'] = _uri;

    return map;
  }

  // Extract a MyTrack object from a Map object
  MyTrack.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._uri = map['uri'];
  }

}
