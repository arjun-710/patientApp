import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' as i;
import 'package:mime/mime.dart';
import 'package:patient_app/services/AuthService.dart';
import 'package:patient_app/services/patientUser.dart';

import 'package:patient_app/utils/showSnackBar.dart';

class AddRecord extends StatefulWidget {
  final String? patId;
  const AddRecord({Key? key, required this.patId}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState(patId);
}

class _AddRecordState extends State<AddRecord> {
  _AddRecordState(this.patId);
  PlatformFile? pickedFile;
  String? patId;
  UploadTask? uploadTask;
  bool upload = false;
  late String s;
  late var fileType;

  Future uploadFile() async {
    final path = '$patId/${pickedFile!.name}';
    final i.File currentFile = i.File(pickedFile!.path!);

    // log(currentFile.toString());
    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(currentFile);
        upload = true;
      });
    } catch (e) {
      // log(e.toString());
      throw e;
    }
    final snapshshot = await uploadTask!.whenComplete(() => null);

    final urlDownload = await snapshshot.ref.getDownloadURL();

    PatientUser user = PatientUser();

    print('download: $urlDownload');

    try {
      log('inside try');
      await user.addLink(urlDownload.toString(), fileType[0].toString(),
          pickedFile!.name.toString(), patId.toString());
      showSnackBar(context, 'Added to records');
    } catch (e) {
      throw e;
    }

    setState(() {
      uploadTask = null;
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
    String? mimeStr = lookupMimeType(pickedFile!.name);
    fileType = mimeStr?.split('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedFile != null &&
                  (fileType[1] == "jpg" ||
                      fileType[1] == "jpeg" ||
                      fileType[1] == "png")) ...[
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Image.file(
                      i.File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ] else ...[
                Center(
                  child: Text(pickedFile?.name ?? " "),
                ),
              ],
              // else
              //   Expanded(child: Text(pickedFile!.name)),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: selectFile, child: const Text('Select File')),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: uploadFile, child: const Text('Upload File')),
              if (upload) buildProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        final data = snapshot.data;
        double progress = 0.0;
        if (data == null)
          progress = 0.0;
        else
          progress = data.bytesTransferred / data.totalBytes;
        return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            ));
      });
}

class showsnack extends StatelessWidget {
  const showsnack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showSnackBar(context, 'file uploaded');
    return SizedBox.shrink();
  }
}
