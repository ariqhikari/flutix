part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  Color colorTheme = accentColor2;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(primaryColor: colorTheme),
          ),
        );

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: Icon(Icons.arrow_back, color: Colors.black),
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create New\nYour Account',
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  (widget.registrationData.profileImage == null)
                                      ? AssetImage('assets/user_pic.png')
                                      : FileImage(
                                          widget.registrationData.profileImage),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profileImage ==
                                  null) {
                                widget.registrationData.profileImage =
                                    await getImage();
                              } else {
                                widget.registrationData.profileImage = null;
                              }

                              setState(() {});
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      (widget.registrationData.profileImage ==
                                              null)
                                          ? 'assets/btn_add_photo.png'
                                          : 'assets/btn_del_photo.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Full Name",
                      hintText: "Full Name",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email Address",
                      hintText: "Email Address",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: retypePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 30, bottom: 40),
                      width: 50,
                      height: 50,
                      child: FloatingActionButton(
                        elevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        hoverElevation: 0,
                        backgroundColor: mainColor,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (!(nameController.text.trim() != '' &&
                              emailController.text.trim() != '' &&
                              passwordController.text.trim() != '' &&
                              retypePasswordController.text.trim() != '')) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: 'Please fill all the fields',
                            )..show(context);
                          } else if (passwordController.text !=
                              retypePasswordController.text) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message:
                                  'Mismatch password and confirmed password',
                            )..show(context);
                          } else if (passwordController.text.length < 6) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: 'Password\'s length min 6 characters',
                            )..show(context);
                          } else if (!EmailValidator.validate(
                              emailController.text)) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Wrong formatted email address",
                            )..show(context);
                          } else {
                            widget.registrationData.name = nameController.text;
                            widget.registrationData.email =
                                emailController.text;
                            widget.registrationData.password =
                                passwordController.text;
                            widget.registrationData.selectedGenres = [];

                            context.bloc<PageBloc>().add(
                                GoToPreferencePage(widget.registrationData));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
