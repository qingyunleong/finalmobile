class User {
  String? id;
  String? name;
  String? email;
  String? regdate;
  String? phone;
  String? address;
  String? otp;
  String? cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.regdate,
    required this.otp,
    required this.cart,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    regdate = json['regdate'];
    otp = json['otp'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['regdate'] = regdate;
    data['otp'] = otp;
    data['cart'] = cart;
    return data;
  }
}
