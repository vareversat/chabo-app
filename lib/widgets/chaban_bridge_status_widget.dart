import 'package:chabo/models/chaban_bridge_status.dart';
import 'package:flutter/material.dart';

class ChabanBridgeStatusWidget extends StatelessWidget {
  final ChabanBridgeStatus bridgeStatus;

  const ChabanBridgeStatusWidget({Key? key, required this.bridgeStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Wrap(
            runSpacing: 3,
            alignment: WrapAlignment.start,
            children: [
              Text(bridgeStatus.currentStatus,
                  style: const TextStyle(fontSize: 30)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    bridgeStatus.currentStatusShort,
                    style: TextStyle(
                      fontSize: 30,
                      color: bridgeStatus.getBackgroundColor(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            runSpacing: 3,
            alignment: WrapAlignment.start,
            children: [
              Text(bridgeStatus.nextStatusMessagePrefix,
                  style: const TextStyle(fontSize: 30)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    bridgeStatus.remainingTime,
                    style: TextStyle(
                      fontSize: 30,
                      color: bridgeStatus.getBackgroundColor(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
