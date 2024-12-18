import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rtracker/helper/dialogs.dart';
import 'package:rtracker/module/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:rtracker/module/forgot_password/bloc/forgot_password_event.dart';
import 'package:rtracker/module/forgot_password/bloc/forgot_password_state.dart';
import 'package:rtracker/widget/appbar/standard_appbar.dart';
import 'package:rtracker/widget/text_sheet.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoading) {
          context.loaderOverlay.show();
        } else if (state is ForgotPasswordSuccess) {
          Dialogs.message(
            context: context,
            title: state.forgotPasswordResponse.message,
          );
        } else if (state is ForgotPasswordFailed) {
          Dialogs.message(
            context: context,
            title: state.message,
          );
        } else if (state is ForgotPasswordFinished) {
          context.loaderOverlay.hide();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        appBar: StandardAppBar(
          title: Container(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
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
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TextSheet(
                      'Forgot password',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextSheet(
                      'input your username',
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<ForgotPasswordBloc>().add(
                              ForgotPasswordClicked(
                                username: _usernameController.text,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const TextSheet('SUBMIT'),
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
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('v${snapshot.data!.version}');
                  } else {
                    return SizedBox.shrink();
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
