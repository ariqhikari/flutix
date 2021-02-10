part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subTitle;
  final int discount;

  Promo({
    @required this.title,
    @required this.subTitle,
    @required this.discount,
  });

  @override
  List<Object> get props => [title, subTitle, discount];
}

List<Promo> dummyPromos = [
  Promo(
    title: 'Student Holiday',
    subTitle: 'Maximal only for two people',
    discount: 50,
  ),
  Promo(
    title: 'Family Club',
    subTitle: 'Minimal for three members',
    discount: 70,
  ),
  Promo(
    title: 'Subscription Promo',
    subTitle: 'Min. one year',
    discount: 40,
  ),
];
