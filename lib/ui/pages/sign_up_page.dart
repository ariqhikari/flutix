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

  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isRetypePasswordValid = false;

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
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
                    onChanged: (text) {
                      setState(() {
                        widget.registrationData.name = text.trim();
                        isNameValid = widget.registrationData.name.length >= 3;

                        if (!isNameValid) {
                          colorTheme = Color(0xFFFF5C83);
                        } else {
                          colorTheme = accentColor2;
                        }
                      });
                    },
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
                    onChanged: (text) {
                      setState(() {
                        widget.registrationData.email = text.trim();
                        isEmailValid = EmailValidator.validate(
                            widget.registrationData.email);

                        if (!isEmailValid) {
                          colorTheme = Color(0xFFFF5C83);
                        } else {
                          colorTheme = accentColor2;
                        }
                      });
                    },
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
                    onChanged: (text) {
                      setState(() {
                        widget.registrationData.password = text.trim();
                        isPasswordValid =
                            widget.registrationData.password.length >= 6;

                        if (!isPasswordValid) {
                          colorTheme = Color(0xFFFF5C83);
                        } else {
                          colorTheme = accentColor2;
                        }
                      });
                    },
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
                    onChanged: (text) {
                      setState(() {
                        isRetypePasswordValid =
                            widget.registrationData.password == text.trim();

                        if (!isRetypePasswordValid) {
                          colorTheme = Color(0xFFFF5C83);
                        } else {
                          colorTheme = accentColor2;
                        }
                      });
                    },
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
                        backgroundColor: (isNameValid &&
                                isEmailValid &&
                                isPasswordValid &&
                                isRetypePasswordValid)
                            ? mainColor
                            : Color(0xFFE4E4E4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: (isNameValid &&
                                  isEmailValid &&
                                  isPasswordValid &&
                                  isRetypePasswordValid)
                              ? Colors.white
                              : Color(0xFFBEBEBE),
                        ),
                        onPressed: (isNameValid &&
                                isEmailValid &&
                                isPasswordValid &&
                                isRetypePasswordValid)
                            ? () {
                                context.bloc<PageBloc>().add(GoToPreferencePage(
                                    widget.registrationData));
                              }
                            : null,
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
