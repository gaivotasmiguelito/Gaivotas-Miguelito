import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimePage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => TimePage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<TimePage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: _stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime =
            StopWatchTimer.getDisplayTime(value, hours: _isHours);
            return Row(
              children: <Widget>[
                Text(
                  displayTime,
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Roboto Mono',
                      fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                color: Colors.lightBlue,
                shape: StadiumBorder(),
                onPressed: () async {
                  _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                },
                child: Text(
                  'Começar',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),

              MaterialButton(
                color: Colors.red,
                shape: StadiumBorder(),
                onPressed: () async {
                  _stopWatchTimer.onExecute
                      .add(StopWatchExecute.reset);
                },
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}