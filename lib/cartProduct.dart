class CartProduct{
  int id;
  String name;
  double price;
  String img;
  double total;




  CartProduct(this.id, this.name, this.price,this.total, this.img);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartProduct &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              price == other.price &&
              img == other.img ;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      img.hashCode ;

  void booly(bool x, List<dynamic> y){
    if(x){
      y.clear();
    }
  }




}





List<CartProduct> cartproducts=[];