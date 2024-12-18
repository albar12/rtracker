import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtracker/api/api_manager.dart';
import 'package:rtracker/api/endpoint/general/general_response.dart';
import 'package:rtracker/module/home/bloc/home_event.dart';
import 'package:rtracker/module/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeSignOut>(_onHomeSignOut);
  }

  _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
  }

  _onHomeSignOut(HomeSignOut event, Emitter<HomeState> emit) async {
    try {
      var response = await ApiManager().logout();

      if (response.statusCode == 200) {
        emit(HomeSignedOut());
      } else {
        var defaultResponse = GeneralResponse.fromJson(response.data);

        emit(
          HomeError(
            defaultResponse.errorMessage,
          ),
        );
      }
    } catch (e) {
      emit(HomeSignedOut());
    }
  }
}
