import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final String id;
  final String imageAsset;

  const BannerModel({required this.id, required this.imageAsset});

  @override
  List<Object?> get props => [id, imageAsset];
}
