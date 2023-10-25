import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
class RecuperarPosicao extends StatefulWidget {
  const RecuperarPosicao({super.key});

  @override
  State<RecuperarPosicao> createState() => _RecuperarPosicaoState();
}

class _RecuperarPosicaoState extends State<RecuperarPosicao> {

  Completer<GoogleMapController> controller = Completer();
  late CameraPosition localCamera;

  Set<Marker> listaMarcadores ={};
  late Future<void> initialization;

  onMapCreated(GoogleMapController googleMapController){
    controller.complete(googleMapController);
  }

  localizarDispositivo() async{
    bool servicosAtivos;
    LocationPermission permissao;
    setState(() {

    });

    servicosAtivos = await Geolocator.isLocationServiceEnabled();
    if(!servicosAtivos){
      return Future.error("Serviços de localização desabilitadas");
    }
    permissao = await Geolocator.checkPermission();
    if(permissao == LocationPermission.denied){
      permissao = await Geolocator.requestPermission();
      if(permissao == LocationPermission.denied){
        return Future.error("Permissão para erro, acesso negado.");
      }
    }
    if(permissao == LocationPermission.deniedForever){
      return Future.error("Permissão para acesso a localização negada");
    }
    Position posicao = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    criarMarcadores(posicao);
    setState(() {
      localCamera = CameraPosition(target: LatLng(-23.319173315849483, -51.15280428601765),
          zoom: 19);

    });
    mudarCamera(localCamera);
  }

  mudarCamera(CameraPosition localCamera)async{
    GoogleMapController googleMapController = await controller.future;
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(localCamera)
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await getBytesFromAsset('imagens/arvorepreta.png', 100)) .buffer.asUint8List();
  }

  criarMarcadores(Position posicao)async{
    Set<Marker> marcadoresLocal = {};
    Marker marcador1 = Marker(markerId: MarkerId("Marcador 1"),
        position: LatLng(-23.319173315849483, -51.15280428601765),
        infoWindow: InfoWindow(
            title: "Localização FitGarden"
        ));


    marcadoresLocal.add(marcador1);
    setState(() {
      listaMarcadores = marcadoresLocal;
    });
  }

  ouvirLocalizacao() async{
    var configuracaoLocalizacao = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5,
    );
    Geolocator.getPositionStream( locationSettings: configuracaoLocalizacao)
        .listen((Position position){
      setState(() {
        localCamera = CameraPosition(target: LatLng(-23.31917085273951, -51.152777463927116),zoom: 16);
        mudarCamera(localCamera);
        criarMarcadores(position);
      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization = localizarDispositivo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: localCamera,
              onMapCreated: onMapCreated,
              markers: listaMarcadores,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro na inicialização: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: AlertDialog(
                title: Text("Carregando..."),
                content: CircularProgressIndicator(),
                alignment: Alignment.center,
                actions: [

                ],
              ),
            );
          }
        },
      ),
    );
  }
}