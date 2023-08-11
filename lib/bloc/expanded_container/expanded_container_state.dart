part of 'expanded_container_bloc.dart';

sealed class ExpandedContainerState extends Equatable {
  const ExpandedContainerState();

  @override
  List<Object> get props => [];
}

final class ExpandedContainerInitial extends ExpandedContainerState {
  final int expandedIndex;

  const ExpandedContainerInitial({required this.expandedIndex});

  @override
  List<Object> get props => [expandedIndex];
}
