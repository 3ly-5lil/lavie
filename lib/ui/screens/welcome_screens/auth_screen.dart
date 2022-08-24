import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lavie/helper/bloc/auth/auth_cubit.dart';
import 'package:lavie/helper/bloc/log_screen/log_screen_cubit.dart';

import '../../../shared/components/default_form_field.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
            backgroundColor: Colors.white,
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LogScreenCubit()),
            BlocProvider(create: (context) => AuthCubit()),
          ],
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              debugPrint(state.runtimeType.toString());
              if (state is LoggingInFinishedState) {
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is SigningUpFinishedState) {
                Navigator.pushReplacementNamed(context, '/claimSeed');
              }
            },
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/sign_background.svg',
                  fit: BoxFit.fill,
                ),
                Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: BlocBuilder<LogScreenCubit, LogScreenState>(
                    builder: (logScreenContext, state) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          SvgPicture.asset('assets/images/logo.svg'),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  decoration: !state.inLogScreen
                                      ? const BoxDecoration(
                                          border: BorderDirectional(
                                            bottom: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      : null,
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: !state.inLogScreen
                                          ? Colors.blue
                                          : Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  BlocProvider.of<LogScreenCubit>(
                                          logScreenContext)
                                      .switchScreen();
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  decoration: state.inLogScreen
                                      ? const BoxDecoration(
                                          border: BorderDirectional(
                                            bottom: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      : null,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: state.inLogScreen
                                          ? Colors.blue
                                          : Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  BlocProvider.of<LogScreenCubit>(
                                          logScreenContext)
                                      .switchScreen();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          state.inLogScreen
                              ? _logInForm(logScreenContext)
                              : _signUpForm(logScreenContext),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              children: const <Widget>[
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                Text(
                                  " or continue with ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.facebook)),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.face),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logInForm(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: [
          defaultTextFormField(
            label: 'Email',
            controller: email,
            textInputType: TextInputType.emailAddress,
            validate: (value) {
              if (value == null || value.isEmpty) {
                return "email can't be empty";
              } else if (value.contains(
                RegExp(
                  //confirm email regex to confirm the email contain ___@__.com
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                ),
              )) {
                return null;
              } else {
                return "email isn't valid";
              }
            },
          ),
          const SizedBox(height: 20),
          defaultTextFormField(
            label: 'Password',
            controller: password,
            obscure: true,
            textInputType: TextInputType.text,
            validate: (value) {
              if (value == null || value.isEmpty) {
                return "password can't be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState != null) {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<AuthCubit>(context).signIn(
                      buildContext: context,
                      email: email.text,
                      password: password.text);
                }
              } else {
                debugPrint(
                    '!!!probably forgot to wrap the scaffold with form and give it the form key as key!!!');
              }
            },
            textColor: Colors.white,
            color: Colors.green[400],
            minWidth: double.infinity,
            height: 40,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return state.runtimeType == LoggingInStartedState
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login');
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _signUpForm(BuildContext context) {
    var firstName = TextEditingController();
    var lastName = TextEditingController();
    var email = TextEditingController();
    var password = TextEditingController();
    var confirmPassword = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: defaultTextFormField(
                  label: 'First Name',
                  controller: firstName,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return "First Name should not be empty";
                    } else if (value.length < 3) {
                      return "First Name must be longer than or equal to 3 characters";
                    } else if (value.length > 32) {
                      return "First Name must be shorter than or equal to 32 characters";
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: defaultTextFormField(
                  label: 'Last Name',
                  controller: lastName,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return "Last Name should not be empty";
                    } else if (value.length < 3) {
                      return "Last Name must be longer than or equal to 3 characters";
                    } else if (value.length > 32) {
                      return "Last Name must be shorter than or equal to 32 characters";
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          defaultTextFormField(
            label: 'Email',
            controller: email,
            textInputType: TextInputType.emailAddress,
            validate: (value) {
              if (value == null || value.isEmpty) {
                return "email should not be empty";
              } else if (!value.contains(
                RegExp(
                  //confirm email regex to confirm the email contain ___@__.com
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                ),
              )) {
                return "email isn't valid must contain @any.com";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          defaultTextFormField(
            label: 'Password',
            controller: password,
            //todo
            obscure: true,
            validate: (value) {
              if (value == null || value.isEmpty) {
                return "password should not be empty";
              } else if (value.length < 8) {
                return "password must be longer than or equal to 8 characters";
              } else if (value.length > 32) {
                return "password must be shorter than or equal to 32 characters";
              }
              // else if (value.contains(RegExp("^(?=.*[A-Z])(?=.*[0-9])$"))) {
              //   return "password too weak must contain at least 1 upper case and 1 number";
              // }
              return null;
            },
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          defaultTextFormField(
            label: 'Confirm Password',
            controller: confirmPassword,
            obscure: true,
            validate: (value) {
              if (value == null || value != password.text) {
                return "password doesn't match";
              }
              return null;
            },
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () {
              if (formKey.currentState != null) {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<AuthCubit>(context).signUp(
                    buildContext: context,
                    firstName: firstName.text,
                    lastName: lastName.text,
                    email: email.text,
                    password: password.text,
                  );
                }
              } else {
                debugPrint(
                    '!!!probably forgot to wrap the scaffold with form and give it the form key as key!!!');
              }
            },
            textColor: Colors.white,
            color: Colors.green[400],
            minWidth: double.infinity,
            height: 40,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return state.runtimeType == SigningUpStartedState
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign Up');
              },
            ),
          ),
        ],
      ),
    );
  }
}
