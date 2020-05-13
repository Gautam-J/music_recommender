class MyTrack {

  int _id;
  String _name;
  String _sId;

  // Constructors
  MyTrack(this._name, this._sId);
  MyTrack.withId(this._id, this._name, this._sId);

  // getters
  int get id => _id;
  String get name => _name;
  String get sId => _sId;

  // setters
  set name(String newName) {
    this._name = newName;
  }

  set sId(String newSId) {
    this._sId = sId;
  }

  // Convert a MyTrack object to a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map['name'] = _name;
    map['sId'] = _sId;

    return map;
  }

  // Extract a MyTrack object from a Map object
  MyTrack.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._sId = map['sId'];
  }

}
