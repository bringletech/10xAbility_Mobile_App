import 'package:flutter/material.dart';
import 'package:ten_x_app/common/colors/colors.dart';
import 'package:video_player/video_player.dart';

import '../patientHome/patient_dashboard.dart';


class RegistrationDoneScreen extends StatefulWidget {
  @override
  _RegistrationDoneScreenState createState() => _RegistrationDoneScreenState();
}

class _RegistrationDoneScreenState extends State<RegistrationDoneScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/shortVideo/completed.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context)=>PatientDashboard()),
    //   );
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _controller.value.isInitialized
              ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          )
              : Container(color: AppColors.redOrange),
        ],
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Next Screen')),
    );
  }
}
