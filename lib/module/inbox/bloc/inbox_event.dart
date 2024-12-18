import 'package:flutter/material.dart';
import 'package:rtracker/realm/schemas.dart';

@immutable
abstract class InboxEvent {}

class InboxStarted extends InboxEvent {}

class InboxMarkAsRead extends InboxEvent {
  final Inbox inbox;

  InboxMarkAsRead(this.inbox);
}
