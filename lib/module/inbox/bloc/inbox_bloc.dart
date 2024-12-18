import 'package:bloc/bloc.dart';
import 'package:rtracker/module/inbox/bloc/inbox_event.dart';
import 'package:rtracker/module/inbox/bloc/inbox_state.dart';

import 'package:rtracker/realm/inbox_dao.dart';
import 'package:rtracker/realm/schemas.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc() : super(InboxInitial()) {
    on<InboxStarted>(_onInboxLoad);
    on<InboxMarkAsRead>(_onInboxMarkAsRead);
  }

  _onInboxLoad(InboxStarted event, Emitter<InboxState> emit) {
    List<Inbox> inboxes = InboxDao.all();
    emit(InboxLoaded(inboxes));
  }

  _onInboxMarkAsRead(InboxMarkAsRead event, Emitter<InboxState> emit) {
    InboxDao.markAsRead(event.inbox);
  }
}
