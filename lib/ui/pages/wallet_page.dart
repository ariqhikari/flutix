part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                User user = userState.user;

                return Stack(
                  children: [
                    // * Content
                    ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // * Arrow, Title Page
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: Stack(
                                children: [
                                  // * Arrow
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      child: Icon(Icons.arrow_back,
                                          color: Colors.black),
                                      onTap: () {
                                        context.bloc<PageBloc>().add(pageEvent);
                                      },
                                    ),
                                  ),
                                  // * Title Page
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'My Wallet',
                                      textAlign: TextAlign.center,
                                      style:
                                          blackTextFont.copyWith(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // * ID Card
                            Container(
                              height: 185,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFF382A74),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipPath(
                                    clipper: CardReflectionClipper(15),
                                    child: Container(
                                      height: 185,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft,
                                          colors: [
                                            Colors.white.withOpacity(0.1),
                                            Colors.white.withOpacity(0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 18,
                                              height: 18,
                                              margin: EdgeInsets.only(right: 4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFFFFF2CB),
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: accentColor2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID',
                                            decimalDigits: 0,
                                            symbol: 'IDR ',
                                          ).format(user.balance),
                                          style: whiteNumberFont.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 28,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Card Holder',
                                                  style: whiteTextFont.copyWith(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      user.name,
                                                      style: whiteTextFont
                                                          .copyWith(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(width: 4),
                                                    SizedBox(
                                                      width: 14,
                                                      height: 14,
                                                      child: Image.asset(
                                                          'assets/ic_check.png'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Card ID',
                                                  style: whiteTextFont.copyWith(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      user.id
                                                          .substring(0, 10)
                                                          .toUpperCase(),
                                                      style: whiteNumberFont
                                                          .copyWith(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(width: 4),
                                                    SizedBox(
                                                      width: 14,
                                                      height: 14,
                                                      child: Image.asset(
                                                          'assets/ic_check.png'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            // * Transactions
                            Text(
                              'Recent Transactions',
                              style: blackTextFont.copyWith(fontSize: 14),
                            ),
                            SizedBox(height: 12),
                            FutureBuilder(
                              future: FlutixTransactionServices.getTransactions(
                                  user.id),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  return generateTransactionList(
                                      context, snapshot.data);
                                } else {
                                  return SpinKitFadingCircle(
                                    color: mainColor,
                                    size: 50,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    // * Button
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 250,
                        height: 45,
                        margin: EdgeInsets.only(bottom: 40),
                        child: RaisedButton(
                          elevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                          hoverElevation: 0,
                          child: Text(
                            'Top Up My Wallet',
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: mainColor,
                          onPressed: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Column generateTransactionList(
      BuildContext context, List<FlutixTransaction> transactions) {
    var sortedTransactions = transactions;
    sortedTransactions.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));

    return Column(
      children: sortedTransactions
          .map(
            (transaction) => Container(
              margin: EdgeInsets.only(
                  bottom: (transaction != sortedTransactions.last) ? 12 : 87),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * Poster
                  Container(
                    width: 70,
                    height: 90,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (transaction.picture != null)
                            ? NetworkImage(
                                imageBaseURL + 'w500' + transaction.picture)
                            : AssetImage('assets/bg_topup.png'),
                      ),
                    ),
                  ),
                  // * Title, Amount, Date / Theater
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // * Title
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            70 -
                            20,
                        child: Text(
                          transaction.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextFont.copyWith(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 6),
                      // * Amount
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(transaction.amount),
                        style: whiteNumberFont.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: (transaction.picture != null)
                              ? Color(0xFFFF5C83)
                              : Color(0xFF3E9D9D),
                        ),
                      ),
                      SizedBox(height: 6),
                      // * Theater
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            70 -
                            20,
                        child: Text(
                          transaction.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  final double offset;

  CardReflectionClipper(this.offset);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - this.offset);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
