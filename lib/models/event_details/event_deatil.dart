class DetailItem{
  String value;
  bool isSelected;
  DetailItem({this.value="",this.isSelected=false});
  @override
  bool operator ==(Object other) {
    if (other is DetailItem) {
      return other.value == value;}
    return false;
  }
  @override
  int get hashCode => value.hashCode;
}