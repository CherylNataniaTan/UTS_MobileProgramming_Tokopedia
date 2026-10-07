import 'dart:async';
import 'package:flutter/material.dart';
class TickerBuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final Duration interval;

  const TickerBuilder({
    super.key,
    required this.builder,
    this.interval = const Duration(seconds: 1),
  });

  @override
  State<TickerBuilder> createState() => _TickerBuilderState();
}

class _TickerBuilderState extends State<TickerBuilder> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.interval, (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}