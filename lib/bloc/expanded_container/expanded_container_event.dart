part of 'expanded_container_bloc.dart';

abstract class ExpandedContainerEvent extends Equatable {
  const ExpandedContainerEvent();

  @override
  List<Object> get props => [];
}

class ToggleExpandedContainer extends ExpandedContainerEvent {
  final int expandedContainerIndex;

  const ToggleExpandedContainer({required this.expandedContainerIndex});

  @override
  List<Object> get props => [expandedContainerIndex];
}
