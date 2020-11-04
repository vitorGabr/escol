import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escol/modules/aluno/models/aulaModel.dart';
import 'package:escol/modules/aluno/models/enum/daysWeekEnum.dart';
import 'package:escol/modules/aluno/models/escolaModel.dart';
import 'package:escol/modules/aluno/models/eventModel/eventoModel.dart';
import 'package:escol/modules/aluno/models/eventModel/eventosPorMesModel.dart';
import 'package:escol/modules/aluno/models/eventModel/eventosPorDiaModel.dart';
import 'package:escol/modules/aluno/models/horarioModel.dart';
import 'package:escol/modules/aluno/models/informacaoEscolarModel.dart';
import 'package:escol/modules/aluno/models/materiaModel.dart';
import 'package:escol/modules/aluno/models/salaModel.dart';
import 'package:escol/modules/firebase/models/enum/typeUserEnum.dart';
import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/firebase/providers/firestoreInstanceProvider.dart';
import 'package:escol/modules/noticias/models/enum/categoriaEnum.dart';
import 'package:escol/modules/noticias/models/noticiaModel.dart';
import 'package:escol/modules/shared/repositories/sharePreferencesRepository.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreRepository{

  final SharePreferencesRepository _sharedPreference = SharePreferencesRepository();

  final FirestoreInstanceProvider _instance = FirestoreInstanceProvider();

  Future<List<MateriaModel>> getMaterias(String _uid) async {

    List<MateriaModel> _listMateria = [];
    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.sala.collection('materias')
      .get().then((snapshots) async {
        await Future.forEach(snapshots.docs, (snapshot) async {
          MateriaModel _materia = MateriaModel.fromJson(snapshot.data());
          var _professor = _materia.professor;
          var _referencia = await _materia.referencia.get();
          _materia = MateriaModel.fromJson(_referencia.data());
          _materia.professor = _professor;
          _listMateria.add(_materia);
        });
      });
    });

    return _listMateria;
  }

  Future<List<AulaModel>> getAulas(String _uid) async {

    var _listAulas = List<AulaModel>();  
    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.sala.collection('aulas').doc('aula')
      .get().then((snapshots) async {
        AulaModel _aula;
        snapshots.data()['${DaysWeekEnum.segunda_feira.index}'].forEach((_onValue){
          Map<String, dynamic> _json = _onValue;
          _aula = AulaModel.fromJson(_json);
          _listAulas.add(_aula);
        });
      });
    });

    return _listAulas;
  }

  Future<ResponseDefaultModel<FirebaseUserModel>> getUser(String _uid) async {

    var _result = ResponseDefaultModel<FirebaseUserModel>()
      ..isSuccess = false;

    try {
      await _instance.firestore.collection('usuarios').doc(_uid)
      .get().then((snapshot){
        if(snapshot.data() != null){
          _result
            ..data = FirebaseUserModel.fromJson(snapshot.data())
            ..isSuccess = true;
        } 
      });
    }on Exception catch (e) {
      _result
       ..error = e
       ..errorMessage = e.toString();
    }

     return _result;
  }

  Future<void> preparingUserModelToSave(TypeUserEnum _type,{FirebaseUserModel firebaseUserModel, User firebaseUser, bool saveUserInFirebase = true}) async {

    final String _displayName = '';

    FirebaseUserModel _userModel;

    _userModel = (FirebaseUserModel()
      ..displayName =  firebaseUser?.displayName ?? firebaseUserModel?.displayName ?? _displayName
      ..email = firebaseUser?.email ?? firebaseUserModel?.email
      ..phoneNumber = firebaseUser?.phoneNumber ?? firebaseUserModel?.phoneNumber
      ..uid = firebaseUser?.uid ?? firebaseUserModel?.uid
      ..typeUser = _type.index
      ..data = DateTime.now()
    );

    await _sharedPreference.saveSharedPrerencesAsync(
      'firebaseUserModel',
      json.encode(
        _userModel.toJson(dateToString: true),
      )
    );
    try {
      locator.registerSingleton<FirebaseUserModel>(_userModel);
    } catch (_) {
    }

  }

  Future<List<HorarioModel>> getHorario(String _uid) async {

    var _listHorarios = List<HorarioModel>(); 
    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.sala.collection('aulas').doc('aula')
      .get().then((snapshots) async {
          List<AulaModel> _listAulas;
          HorarioModel _horario; 
          snapshots.data().forEach((_dia, _aulas) { 
            _listAulas = [];
            _aulas.forEach((_aula){
              _listAulas.add(AulaModel.fromJson(_aula));
            });
            _horario = HorarioModel()
              ..aulas = _listAulas
              ..diaDaSemana = int.parse(_dia);
            _listHorarios.add(_horario);
          }); 
      });
    });

    return _listHorarios;
  }

  Future<ResponseDefaultModel> saveHorario(String _uid,List<HorarioModel> _list) async {

    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    var _result = ResponseDefaultModel();
    _result.isSuccess = false;
    Map<String,dynamic> _json = {};
    _list.forEach((_horario) {
      var _listAulaModel = [];
      _horario.aulas.forEach((element) { 
        _listAulaModel.add(element.toJson());
      });
      _json[(_list.indexOf(_horario).toString())] = _listAulaModel;
    });
    try {
      await _instance.firestore.collection('usuarios')
      .doc(_uid)
      .collection('informacao-escolar')
      .doc('informacao')
      .get().then((_result) async {
        _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
        await _informacaoEscolar.sala.collection('aulas').doc('aula').set(_json);
      });
      _result.isSuccess = true;
    } catch (e) {
      _result.errorMessage = e.message;
    }
    
    return _result;
    
  }

  Future<List<EventosPorMesModel>> getListEventos(String _uid) async{

    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    var listEventos = List<EventoModel>();
    var listEventosPorDia = List<EventosPorDiaModel>();
    var listEventosPorMes = List<EventosPorMesModel>();
    DocumentReference _documentReference = _instance.firestore
      .collection('usuarios')
      .doc(_uid);
    
    await _documentReference.collection('informacao-escolar')
    .doc('informacao').get().then((snapshots) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(snapshots.data());
      await _informacaoEscolar.sala.collection('calendario')
      .orderBy('data',descending: false)
      .get().then((_result){
        _result.docs.forEach((_value) {
          listEventos.add(EventoModel.fromJson(_value.data()));
        });
        listEventos.map((_evento) => _evento.data.month).toSet().forEach((_evento) async {
          listEventosPorDia = [];
          listEventos.where((a) => a.data.month == _evento).forEach((EventoModel _onValue) {
            if(listEventosPorDia.indexWhere((listEvento) => listEvento.dia.day == _onValue.data.day) != -1){
              listEventosPorDia.where((listEvento) => listEvento.dia.day == _onValue.data.day).first
              ..dia = _onValue.data
              ..eventos.add(_onValue);
            }else{
              EventosPorDiaModel _eventosDiaModel = EventosPorDiaModel()
                ..dia = _onValue.data
                ..eventos = [_onValue];
              listEventosPorDia.add(_eventosDiaModel);
            }
          });
          EventosPorMesModel _listAgendamentoMes = EventosPorMesModel()
            ..eventos = listEventosPorDia
            ..mes = DateTime(DateTime.now().year,_evento);
          listEventosPorMes.add(_listAgendamentoMes); 
        });
      });
    });

    return listEventosPorMes.toList();
  }

  Future<SalaModel> getInfoSala(String _uid) async {

    var _sala = SalaModel(); 
    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.sala
      .get().then((snapshots) async {
        print(snapshots.data());
        _sala = SalaModel.fromJson(snapshots.data());
      });
    });

    return _sala;
  }

  Future<EscolaModel> getInfoEscola(String _uid) async {

    var _sala = EscolaModel(); 
    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.escola
      .get().then((snapshots) async {
        print(snapshots.data());
        _sala = EscolaModel.fromJson(snapshots.data());
      });
    });

    return _sala;
  }

  Future<ResponseDefaultModel> saveEvento(String _uid,EventoModel _evento) async {

    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    var _result = ResponseDefaultModel();
    _result.isSuccess = false;
    try {
      await _instance.firestore.collection('usuarios')
      .doc(_uid)
      .collection('informacao-escolar')
      .doc('informacao')
      .get().then((_result) async {
        _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
        await _informacaoEscolar.sala.collection('calendario').doc().set(_evento.toJson());
      });
      _result.isSuccess = true;
    } catch (e) {
      _result.errorMessage = e.message;
    }
    
    return _result;
    
  }

  Future<List<NoticiaModel>> getNoticias(String _uid,{String params = ''}) async {
    var _list = List<NoticiaModel>();
    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.sala
      .collection('noticias')
      .where('$params')
      .orderBy('data',descending: true)
      .get().then((snapshots) async {
        snapshots.docs.forEach((_onValue) {
          _list.add(NoticiaModel.fromJson(_onValue.data()));
        });
      });
      await _informacaoEscolar.escola
      .collection('noticias')
      .where('$params')
      .orderBy('data',descending: true)
      .get().then((snapshots) async {
        snapshots.docs.forEach((_onValue) {
          _list.add(NoticiaModel.fromJson(_onValue.data()));
        });
      });
    });
    return _list;
  }

  Future<NoticiaModel> getLastNoticia(String _uid) async {
    var _noticia = NoticiaModel();
    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.escola
      .collection('noticias')
      .orderBy('data',descending: true)
      .limit(1)
      .get().then((snapshots) async {
        snapshots.docs.forEach((_onValue) {
          _noticia = NoticiaModel.fromJson(_onValue.data());
        });
      });
    });
    return _noticia;
  }

  Future<void> setIntoFirebase(String _uid) async {

    var _noticia = NoticiaModel()
      ..data = DateTime.now()
      ..imagem = 'https://firebasestorage.googleapis.com/v0/b/educational-system-61d77.appspot.com/o/escolas%2F%20WVo4wgMvXQrjNaUTlC8S%2Fnoticias%2Fescolas5.jpg?alt=media&token=56a12cf4-1d00-482e-8e45-2cdde18c5ba9'
      ..usuario = _instance.firestore.collection('usuarios').doc(_uid)
      ..usuarioImage = 'https://ofuxiqueiro.com.br/wp-content/uploads/2020/03/image-8.jpeg'
      ..usuarioNome = 'João da silva'
      ..categorias = [CategoriaEnum.sala.index]
    ;

    InformacaoEscolarModel _informacaoEscolar = InformacaoEscolarModel();
    await _instance.firestore.collection('usuarios')
    .doc(_uid)
    .collection('informacao-escolar')
    .doc('informacao')
    .get().then((_result) async {
      _informacaoEscolar = InformacaoEscolarModel.fromJson(_result.data());
      await _informacaoEscolar.sala
      .collection('noticias')
      .doc()
      .set(_noticia.toJson());

    });

  }

}