import 'package:bloc/bloc.dart';
import 'package:rtracker/module/profile/profile_event.dart';
import 'package:rtracker/module/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
}
