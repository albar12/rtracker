import 'package:flutter/material.dart';
import 'package:rtracker/realm/schemas.dart';

@immutable
abstract class InboxState {}

class InboxInitial extends InboxState {}

class InboxLoaded extends InboxState {
  final List<Inbox> inboxes;

  InboxLoaded(this.inboxes);
}
