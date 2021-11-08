import 'package:flutter/material.dart';

enum ExpandableState {
  EXPANDED,
  COLLAPSED,
  NOTVISIBLE,
}

class ExpandableViewController {
  ExpandableState initialState;
  void Function(ExpandableState) setExpandableState;
  ExpandableViewController(ExpandableState state) {
    initialState = state;
  }
}

class ExpandableView extends StatefulWidget {
  final Widget expandedWidget;
  final Widget collapseWidget;
  final ExpandableViewController controller;
  const ExpandableView(
      {Key key,
      @required this.expandedWidget,
      @required this.collapseWidget,
      @required this.controller})
      : super(key: key);

  @override
  _ExpandableViewState createState() => _ExpandableViewState(this.controller);
}

class _ExpandableViewState extends State<ExpandableView>
    with TickerProviderStateMixin {
  ExpandableState currentState;
  AnimationController _controller;
  Animation<Offset> _animation;
  _ExpandableViewState(ExpandableViewController controller) {
    this.currentState = controller.initialState;
    controller.setExpandableState = this.setExpandableState;
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween<Offset>(begin: Offset(0.0, 1.5), end: Offset.zero)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  setExpandableState(ExpandableState state) {
    setState(() {
      currentState = state;
    });
    if (currentState == ExpandableState.EXPANDED) {
      _controller.forward();
    } else if (currentState == ExpandableState.NOTVISIBLE) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _animation,
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 400),
          firstChild: widget.expandedWidget,
          secondChild: widget.collapseWidget,
          crossFadeState: currentState == ExpandableState.EXPANDED
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ));
  }
}
