import 'package:flutter/cupertino.dart';

class BattleVoteCell extends StatefulWidget {
  const BattleVoteCell({super.key, required this.item});

  final dynamic item;

  @override
  State<BattleVoteCell> createState() => _BattleVoteCellState();
}

class _BattleVoteCellState extends State<BattleVoteCell> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Battle Vote Cell"),
    );
  }
}
