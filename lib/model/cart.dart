class Cart {
  String? cart_id;
  String? cart_qty;
  String? subject_id;
  String? subject_name;
  String? subject_price;
  String? subject_sessions;
  String? pricetotal;

  Cart(
      {this.cart_id,
      this.cart_qty,
      this.subject_id,
      this.subject_name,
      this.subject_price,
      this.subject_sessions,
      this.pricetotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cart_id = json['cart_id'];
    cart_qty = json['cart_qty'];
    subject_id = json['subject_id'];
    subject_name = json['subject_name'];
    subject_price = json['subject_price'];
    subject_sessions = json['subject_sessions'];
    pricetotal = json['pricetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cart_id;
    data['cart_qty'] = cart_qty;
    data['subject_id'] = subject_id;
    data['subject_name'] = subject_name;
    data['subject_price'] = subject_price;
    data['subject_sessions'] = subject_sessions;
    data['pricetotal'] = pricetotal;
    return data;
  }
}
