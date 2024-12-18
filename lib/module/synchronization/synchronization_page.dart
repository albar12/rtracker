import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/helper/navigators.dart';
import 'package:rtracker/module/home/home_page.dart';
import 'package:rtracker/module/synchronization/synchronization_bloc.dart';
import 'package:rtracker/module/synchronization/synchronization_event.dart';
import 'package:rtracker/module/synchronization/synchronization_state.dart';
import 'package:rtracker/widget/text_sheet.dart';

class SynchronizationPage extends StatefulWidget {
  const SynchronizationPage({Key? key}) : super(key: key);

  @override
  State<SynchronizationPage> createState() => SynchronizationPageState();
}

class SynchronizationPageState extends State<SynchronizationPage> {
  int progress = 0;
  int total = 0;
  String currentMessage = "";

  @override
  void initState() {
    super.initState();

    context.read<SynchronizationBloc>().add(SynchronizationLoad());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: BlocListener<SynchronizationBloc, SynchronizationState>(
          listener: (context, state) {
            if (state is SynchronizationMessageChanged) {
              setState(() {
                currentMessage = state.message;
              });
            } else if (state is SynchronizationProgressChanged) {
              setState(() {
                progress = state.progress;
                total = state.total;
              });
            } else if (state is SynchronizationSuccess) {
              Navigators.pushReplacement(
                context,
                HomePage(
                  loginResponse: state.loginResponse,
                  syncStatuses: state.syncStatuses,
                ),
              );
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: content(),
          ),
        ),
      ),
    );
  }

  Widget content() {
    if (total == 0) {
      return const Center(
        child: TextSheet(
          "Mohon tunggu",
          fontWeight: FontWeight.bold,
          fontSize: 14,
          textAlign: TextAlign.center,
          color: Colors.white,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              TextSheet(
                "${(progress / total * 100).toInt()} %",
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.size20,
                textAlign: TextAlign.center,
                color: Colors.white,
              ),
              SizedBox(
                height: Dimensions.height50 * 4,
                width: Dimensions.height50 * 4,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(
                    begin: 0,
                    end: progress / total,
                  ),
                  builder: (context, value, child) {
                    return CircularProgressIndicator(
                      value: value,
                      color: Colors.white,
                      strokeWidth: Dimensions.width10,
                    );
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          TextSheet(
            currentMessage,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.size16,
            textAlign: TextAlign.center,
            color: Colors.white,
          )
        ],
      );
    }
  }
}
