part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectedAmount = 0;

  Color colorTheme = Color(0xFFE4E4E4);

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        (MediaQuery.of(context).size.width - (2 * defaultMargin) - 40) / 3;

    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(primaryColor: colorTheme),
          ),
        );

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            color: Colors.white,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Arrow, Title Page
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      height: 56,
                      child: Stack(
                        children: [
                          // * Arrow
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                              onTap: () {
                                context.bloc<PageBloc>().add(widget.pageEvent);
                              },
                            ),
                          ),
                          // * Title Page
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Top Up',
                              textAlign: TextAlign.center,
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // * Input TopUp
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Amount",
                        hintText: "Amount",
                      ),
                      onChanged: (text) {
                        String amount = '';

                        for (int i = 0; i < text.length; i++) {
                          amount += text.isDigit(i) ? text[i] : '';
                        }

                        setState(() {
                          selectedAmount = int.tryParse(amount) ?? 0;
                        });

                        amountController.text = NumberFormat.currency(
                          locale: 'id_ID',
                          decimalDigits: 0,
                          symbol: 'IDR ',
                        ).format(selectedAmount);

                        amountController.selection = TextSelection.fromPosition(
                            TextPosition(offset: amountController.text.length));
                      },
                    ),
                    SizedBox(height: 20),
                    // * Template TopUp
                    Text(
                      'Choose by Template',
                      style: blackTextFont.copyWith(fontSize: 14),
                    ),
                    SizedBox(height: 14),
                    Wrap(
                      spacing: 20,
                      runSpacing: 14,
                      children: generateMoneyCardWidgets(cardWidth),
                    ),
                    SizedBox(height: 102),
                    // * Top Up Button
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 46,
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) => RaisedButton(
                              elevation: 0,
                              focusElevation: 0,
                              highlightElevation: 0,
                              hoverElevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                "Top Up My Wallet",
                                style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: (selectedAmount > 0)
                                        ? Colors.white
                                        : Color(0xFFBEBEBE)),
                              ),
                              disabledColor: Color(0xFFE4E4E4),
                              color: Color(0xFF3E9D9D),
                              onPressed: (selectedAmount > 0)
                                  ? () {
                                      context.bloc<PageBloc>().add(GoToSuccessPage(
                                          null,
                                          FlutixTransaction(
                                              userID: (userState as UserLoaded)
                                                  .user
                                                  .id,
                                              title: "Top Up Wallet",
                                              amount: selectedAmount,
                                              subtitle:
                                                  "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}",
                                              time: DateTime.now())));
                                    }
                                  : null),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> generateMoneyCardWidgets(double width) {
    List<int> amounts = [
      50000,
      100000,
      150000,
      200000,
      250000,
      500000,
      1000000,
      2500000,
      5000000
    ];

    return amounts
        .map((amount) => MoneyCard(
              amount: amount,
              width: width,
              isSelected: selectedAmount == amount,
              onTap: () {
                setState(() {
                  if (selectedAmount != amount) {
                    selectedAmount = amount;
                  } else {
                    selectedAmount = 0;
                  }

                  amountController.text = NumberFormat.currency(
                    locale: 'id_ID',
                    decimalDigits: 0,
                    symbol: 'IDR ',
                  ).format(selectedAmount);

                  amountController.selection = TextSelection.fromPosition(
                      TextPosition(offset: amountController.text.length));
                });
              },
            ))
        .toList();
  }
}
