import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponible = true,
    this.fotoUrl,
  });

  String id;
  String titulo;
  double valor;
  bool disponible;
  String fotoUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id         : json["id"],
        titulo     : json["titulo"],
        valor      : json["valor"],
        disponible : json["disponible"],
        fotoUrl    : json["fotoUrl"],
      );

  /*We comment the id vablue to avoid to overwrite the id on firebase*/
  Map<String, dynamic> toJson() => {
//        "id"         : id,
        "titulo"     : titulo,
        "valor"      : valor,
        "disponible" : disponible,
        "fotoUrl"    : fotoUrl,
      };
}
