import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 36, 182, 121),
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      );
}

class FirebaseApi {
  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException {
      return null;
    }
  }
}

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final String title = 'Firebase Upload';
  UploadTask? task;
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file?.name ?? 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 58, 116, 98),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            const SizedBox(height: 80),
            ButtonWidget(
              text: 'Select File',
              icon: Icons.attach_file,
              onClicked: selectFile,
            ),
            SizedBox(height: 8),
            Text(
              fileName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 48),
            ButtonWidget(
              text: 'Upload File',
              icon: Icons.cloud_upload_outlined,
              onClicked: uploadFile,
            ),
            SizedBox(height: 20),
            task != null ? buildUploadStatus(task!) : Container(),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: false,
      withData: true,
    );

    if (result == null) return;

    setState(() => file = result.files.single);
  }

  Future uploadFile() async {
    if (file == null) return;

    final selectedFile = file;
    final data = selectedFile?.bytes;
    if (selectedFile == null || data == null) return;

    final destination = 'files/${selectedFile.name}';

    task = FirebaseApi.uploadBytes(destination, data);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
