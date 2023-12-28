class ProductD{
  int pid;
  String name;
  String description;
  int quantity;
  double price;
  String img;
  String category;
  double total =0;

  ProductD(this.pid, this.name, this.description,this.quantity, this.price, this.img, this.category){
    total= price;
  }

  getTotal(){
    return total;
  }

  updateTotal(int val){
    total = price *val;


  }

  returnTotal(){
    return total;
  }


}