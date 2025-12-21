class AuthSignInDTO {
  late String email;
  late String password;

  AuthSignInDTO({required this.email, required this.password});

  AuthSignInDTO.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class AuthSignUpDTO {
  late String email;
  late String password;

  AuthSignUpDTO({required this.email, required this.password});

  AuthSignUpDTO.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
