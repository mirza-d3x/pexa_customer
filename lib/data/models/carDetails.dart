class CarDetails {
  CarDetails({
    this.id,
    this.name,
    this.carImages,
    this.carThumbnail,
    this.logoImages,
    this.logoThumbnail,
    this.v,
    this.carType,
    this.carThumbUrl,
    this.carImageUrl,
    this.logoThumbUrl,
    this.logoImageUrl,
  });

  String? id;
  String? name;
  List<String>? carImages;
  List<String>? carThumbnail;
  List<String>? logoImages;
  List<String>? logoThumbnail;
  num? v;
  String? carType;
  List<String>? carThumbUrl;
  List<String>? carImageUrl;
  List<String>? logoThumbUrl;
  List<String>? logoImageUrl;
}
