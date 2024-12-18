import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rtracker/constant.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/helper/preferences.dart';
import 'package:rtracker/module/forgot_password/forgot_password_page.dart';
import 'package:rtracker/module/sign_in/bloc/sign_in_bloc.dart';
import 'package:rtracker/module/sign_in/bloc/sign_in_event.dart';
import 'package:rtracker/module/sign_in/bloc/sign_in_state.dart';
import 'package:rtracker/module/synchronization/synchronization_page.dart';
import 'package:rtracker/widget/text_sheet.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignInPageState();
  }
}

class SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          context.loaderOverlay.show();
        } else if (state is SignInSuccess) {
          Navigators.pushAndRemoveAll(
            context,
            const SynchronizationPage(),
          );
        } else if (state is SignInFailed) {
          Dialogs.message(
            context: context,
            title: state.message,
          );
        } else if (state is SignInFinished) {
          context.loaderOverlay.hide();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                  bottom: 10,
                ),
                child: Center(
                  child: Column(
                    children: const [
                      TextSheet(
                        'FMS',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      TextSheet(
                        'JADIN TRACKER',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TextSheet(
                      'Sign in',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextSheet(
                      'with your account',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
              Form(
                child: AutofillGroup(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.account_box_sharp),
                        ),
                        autofillHints: const [AutofillHints.email],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        autofillHints: const [AutofillHints.password],
                        onEditingComplete: () =>
                            TextInput.finishAutofillContext(),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.key),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              !_passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: !_passwordVisible,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigators.push(
                          context,
                          const ForgotPasswordPage(),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextSheet(
                            'Forgot your password?',
                            textAlign: TextAlign.end,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<SignInBloc>().add(
                                  SignInClicked(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const TextSheet('SIGN IN'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Text(
                  'v1.2.12',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  bool mock = Preferences.getInstance()
                          .getBool(SharedPreferenceKey.MOCK) ??
                      false;

                  if (mock) {
                    Preferences.getInstance()
                        .setBool(SharedPreferenceKey.MOCK, false);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Base url dirubah ke ${ApiUrl.MAIN_BASE}."),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  } else {
                    Preferences.getInstance()
                        .setBool(SharedPreferenceKey.MOCK, true);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Base url dirubah ke ${ApiUrl.MOCK_LOCAL_BASE}.",
                        ),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
