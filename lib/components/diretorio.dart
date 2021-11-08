import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class Diretorio {
  final String nomeDiretorio;
  Diretorio(this.nomeDiretorio);

  Future<io.Directory> criarDiretorio() async {
    io.Directory diretorioBase;

    if (io.Platform.isIOS) {
      diretorioBase = await getApplicationDocumentsDirectory();
    } else {
      diretorioBase = (await getExternalStorageDirectory())!;
    }

    var caminhoCompleto = diretorioBase.path + nomeDiretorio;

    var diretorioDoApp = io.Directory(caminhoCompleto);
    bool existDiretorio = await diretorioDoApp.exists();

    if (!existDiretorio) {
      diretorioDoApp.create();
    }

    return diretorioDoApp;
  }

  Future<String> getNomeDoArquivo(String nomeArquivo) async {
    var diretorio = await criarDiretorio();
    var caminhoArquivo = diretorio.path + nomeArquivo;

    return caminhoArquivo;
  }
}
