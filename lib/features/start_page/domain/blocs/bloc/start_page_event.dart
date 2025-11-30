part of 'start_page_bloc.dart';

sealed class StartPageEvent extends Equatable {
  const StartPageEvent();

  @override
  List<Object> get props => [];
}

final class FetchData extends StartPageEvent {}
