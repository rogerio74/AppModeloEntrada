import 'package:flutter_sound/flutter_sound.dart';
import 'package:modelo_app/components/diretorio.dart';

import 'package:permission_handler/permission_handler.dart';
//import 'dart:developer' as d;

class RecorderWav {
  FlutterSoundRecorder? _audioRecorder;
  bool isRecorderInitialized = false;
  bool isRecording = false;
  String? path;

  init() async {
    path = await getCaminho();
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Permissão do microfone não aceita');
    }
    await _audioRecorder!.openAudioSession();
    isRecorderInitialized = true;
  }

  Future<String> getCaminho() async {
    return await Diretorio('/GravacaoApp').getNomeDoArquivo('/audio_atividade.wav');
  }

  void dispose() {
    _audioRecorder!.closeAudioSession();
    isRecorderInitialized = false;
  }

  start() async {
    //if (!_isRecorderInitialized) return;
    await _audioRecorder!.startRecorder(
        toFile: path, sampleRate: 16000, numChannels: 1, codec: Codec.pcm16WAV, bitRate: 5333);
    isRecording = true;
  }

  stop() async {
    await _audioRecorder!.stopRecorder();
    isRecording = false;
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await start();
    } else {
      await stop();
    }
  }
}
