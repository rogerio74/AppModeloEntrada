import 'package:flutter/material.dart';

class ErroConection extends StatelessWidget {
  const ErroConection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Erro de conexão! Por favor verifique sua conexão com a internet etente novamente',
                  style: TextStyle(
                      fontFamily: 'MochiyPopOne',
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                      color: Color(0xFF0f0882)),
                  textAlign: TextAlign.center,
                ),
                const Icon(
                  Icons.error_outline_rounded,
                  color: Color(0xFF0f0882),
                  size: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 225,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('TENTAR NOVAMENTE',
                            style: TextStyle(
                                fontFamily: 'MochiyPopOne',
                                color: Colors.white,
                                //Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF0f0882)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
