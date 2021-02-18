part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: FutureBuilder(
            future: ticket != null
                ? processingTicketOrder(context)
                : processingTopUp(context),
            builder: (_, snapshot) => (snapshot.connectionState ==
                    ConnectionState.done)
                ? ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 136,
                            margin: EdgeInsets.only(top: 100),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage((ticket != null)
                                    ? 'assets/ticket_done.png'
                                    : 'assets/top_up_done.png'),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 70, bottom: 16),
                            child: Text(
                              (ticket != null)
                                  ? 'Happy Watching!'
                                  : 'Emmm Yummy!',
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                          Text(
                            (ticket != null)
                                ? 'You have successfully\nbought the ticket'
                                : 'You have successfully\ntop up the wallet',
                            textAlign: TextAlign.center,
                            style: greyTextFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 45,
                            margin: EdgeInsets.only(top: 70, bottom: 20),
                            child: RaisedButton(
                              elevation: 0,
                              focusElevation: 0,
                              highlightElevation: 0,
                              hoverElevation: 0,
                              child: Text(
                                (ticket != null) ? 'My Tickets' : 'My Wallet',
                                style: whiteTextFont.copyWith(fontSize: 16),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: mainColor,
                              onPressed: () {
                                print('Amount : ' +
                                    transaction.amount.toString());
                                context.bloc<PageBloc>().add(GoToMainPage(1));
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Discover new movie?',
                                style: greyTextFont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                child: Text(
                                  'Back To Home',
                                  style: purpleTextFont.copyWith(fontSize: 14),
                                ),
                                onTap: () {
                                  context.bloc<PageBloc>().add(GoToMainPage(0));
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 70),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: SpinKitFadingCircle(
                      color: mainColor,
                      size: 50,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTicket(transaction.userID, ticket));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {}
}
