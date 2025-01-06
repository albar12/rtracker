import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtracker/helper/extensions.dart';
import 'package:rtracker/helper/formats.dart';
import 'package:rtracker/helper/no_overscroll.dart';
import 'package:rtracker/module/inbox/bloc/inbox_event.dart';
import 'package:rtracker/module/inbox/bloc/inbox_state.dart';
import 'package:rtracker/widget/appbar/search_appbar.dart';

import 'package:rtracker/helper/app_colors.dart';
import 'package:rtracker/helper/bottom_sheets.dart';
import 'package:rtracker/helper/dimensions.dart';
import 'package:rtracker/realm/schemas.dart';
import 'package:rtracker/widget/text_sheet.dart';
import 'package:rtracker/module/inbox/bloc/inbox_bloc.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  List<Inbox> inboxes = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<InboxBloc>().add(InboxStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InboxBloc, InboxState>(
      listener: (context, state) {
        if (state is InboxLoaded) {
          setState(() {
            inboxes.clear();
            inboxes.addAll(state.inboxes);
          });
        }
      },
      child: Scaffold(
        appBar: SearchAppBar(
          title: const Text('Inbox'),
          height: MediaQuery.of(context).size.height * 0.14,
          bottomWidget: [
            Container(
              height: 10,
            ),
          ],
          controller: controller,
          onChanged: (p0) {
            setState(() {});
          },
        ),
        body: ScrollConfiguration(
          behavior: NoOverscrollBehavior(),
          child: ListView.builder(
            itemCount: inboxes.where((element) {
              String pattern = "${element.title}${element.body}".toLowerCase();

              return pattern.contains(controller.text.toLowerCase());
            }).length,
            itemBuilder: (context, index) {
              Inbox inbox = inboxes.where((element) {
                String pattern = "${element.title}${element.body}".toLowerCase();

                return pattern.contains(controller.text.toLowerCase());
              }).toList()[index];

              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height5,
                  horizontal: Dimensions.width10,
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  color: inbox.read ? Colors.white.darken(5) : Colors.blue.lighten(90),
                  child: InkWell(
                    onTap: () async {
                      BottomSheets.showInboxMessage(
                        context: context,
                        inbox: inbox,
                      );
                      context.read<InboxBloc>().add(InboxMarkAsRead(inbox));
                      context.read<InboxBloc>().add(InboxStarted());
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.width15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  inbox.read ? Icons.mark_email_read_outlined : Icons.mark_email_unread_outlined,
                                  color: inbox.read ? AppColors.success : AppColors.alert,
                                  size: 30,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextSheet(
                                      inbox.title,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Dimensions.height5),
                                    TextSheet(
                                      Formats.date(inbox.date),
                                      fontWeight: FontWeight.normal,
                                    ),
                                    SizedBox(height: Dimensions.height5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height5),
                          DottedLine(
                            dashGapLength: 2,
                            dashColor: AppColors.textSheet.lighten(50),
                          ),
                          SizedBox(height: Dimensions.height5),
                          TextSheet(
                            inbox.body,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
