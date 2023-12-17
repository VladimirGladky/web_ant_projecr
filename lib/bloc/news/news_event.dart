part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

class LoadNews extends NewsEvent {}

class RefreshNews extends NewsEvent {}
