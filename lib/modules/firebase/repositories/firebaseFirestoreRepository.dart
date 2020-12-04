import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escol/modules/student/models/classModel.dart';
import 'package:escol/modules/student/models/enum/daysWeekEnum.dart';
import 'package:escol/modules/student/models/schoolModel.dart';
import 'package:escol/modules/student/models/eventModel/eventModel.dart';
import 'package:escol/modules/student/models/eventModel/eventosMonthModel.dart';
import 'package:escol/modules/student/models/eventModel/eventDayModel.dart';
import 'package:escol/modules/student/models/scheduleModel.dart';
import 'package:escol/modules/student/models/schoolInformationModel.dart';
import 'package:escol/modules/student/models/subjectModel.dart';
import 'package:escol/modules/student/models/classroomModel.dart';
import 'package:escol/modules/firebase/models/enum/typeUserEnum.dart';
import 'package:escol/modules/firebase/models/firebaseUserModel.dart';
import 'package:escol/modules/firebase/providers/firestoreInstanceProvider.dart';
import 'package:escol/modules/news/models/enum/categoriaEnum.dart';
import 'package:escol/modules/news/models/newsModel.dart';
import 'package:escol/modules/shared/repositories/sharePreferencesRepository.dart';
import 'package:escol/modules/shared/getItRepository.dart';
import 'package:escol/modules/shared/models/responseDefaultModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreRepository {
  final SharePreferencesRepository _sharedPreference =
      SharePreferencesRepository();

  final FirestoreInstanceProvider _instance = FirestoreInstanceProvider();

  Future<List<SubjectModel>> getSubjects(String _uid) async {
    List<SubjectModel> _subjectList = [];
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.classroom
          .collection('materias')
          .get()
          .then((snapshots) async {
        await Future.forEach(snapshots.docs, (snapshot) async {
          SubjectModel _subject = SubjectModel.fromJson(snapshot.data());
          var _teacher = _subject.teacher;
          var _referencia = await _subject.reference.get();
          _subject = SubjectModel.fromJson(_referencia.data());
          _subject.teacher = _teacher;
          _subjectList.add(_subject);
        });
      });
    });

    return _subjectList;
  }

  Future<List<ClassModel>> getClasses(String _uid) async {
    var _classList = List<ClassModel>();
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.classroom
          .collection('aulas')
          .doc('aula')
          .get()
          .then((snapshots) async {
        ClassModel _class;
        snapshots.data()['${DaysWeekEnum.monday.index}'].forEach((_onValue) {
          Map<String, dynamic> _json = _onValue;
          _class = ClassModel.fromJson(_json);
          _classList.add(_class);
        });
      });
    });

    return _classList;
  }

  Future<ResponseDefaultModel<FirebaseUserModel>> getUser(String _uid) async {
    var _result = ResponseDefaultModel<FirebaseUserModel>()..isSuccess = false;
    try {
      await _instance.firestore
          .collection('usuarios')
          .doc(_uid)
          .get()
          .then((snapshot) {
        if (snapshot.data() != null) {
          _result
            ..data = FirebaseUserModel.fromJson(snapshot.data())
            ..isSuccess = true;
        }
      });
    } on Exception catch (e) {
      _result
        ..error = e
        ..errorMessage = e.toString();
    }
    return _result;
  }

  Future<void> preparingUserModelToSave(TypeUserEnum _type,
      {FirebaseUserModel firebaseUserModel,
      User firebaseUser,
      bool saveUserInFirebase = true}) async {
    final String _displayName = '';

    FirebaseUserModel _userModel;

    _userModel = (FirebaseUserModel()
      ..displayName = firebaseUser?.displayName ??
          firebaseUserModel?.displayName ??
          _displayName
      ..photoURL = firebaseUser?.photoURL ?? firebaseUserModel?.photoURL
      ..email = firebaseUser?.email ?? firebaseUserModel?.email
      ..phoneNumber =
          firebaseUser?.phoneNumber ?? firebaseUserModel?.phoneNumber
      ..uid = firebaseUser?.uid ?? firebaseUserModel?.uid
      ..typeUser = _type.index
      ..data = DateTime.now());

    await _sharedPreference.saveSharedPrerencesAsync(
        'firebaseUserModel',
        json.encode(
          _userModel.toJson(dateToString: true),
        ));
    try {
      locator.registerSingleton<FirebaseUserModel>(_userModel);
    } catch (_) {}
  }

  Future<List<ScheduleModel>> getSchedule(String _uid) async {
    var _scheduleList = List<ScheduleModel>();
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.classroom
          .collection('aulas')
          .doc('aula')
          .get()
          .then((snapshots) async {
        List<ClassModel> _classList;
        ScheduleModel _schedule;
        snapshots.data().forEach((_day, _aulas) {
          _classList = [];
          _aulas.forEach((_aula) {
            _classList.add(ClassModel.fromJson(_aula));
          });
          _schedule = ScheduleModel()
            ..classes = _classList
            ..weekDay = int.parse(_day);
          _scheduleList.add(_schedule);
        });
      });
    });

    return _scheduleList;
  }

  Future<ResponseDefaultModel> saveSchedule(
      String _uid, List<ScheduleModel> _list) async {
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    var _result = ResponseDefaultModel();
    _result.isSuccess = false;
    Map<String, dynamic> _json = {};
    _list.forEach((_schedule) {
      var _classListModel = [];
      _schedule.classes.forEach((element) {
        _classListModel.add(element.toJson());
      });
      _json[(_list.indexOf(_schedule).toString())] = _classListModel;
    });
    try {
      await _instance.firestore
          .collection('usuarios')
          .doc(_uid)
          .collection('informacao-escolar')
          .doc('informacao')
          .get()
          .then((_result) async {
        _schoolInformation = SchoolInformationModel.fromJson(_result.data());
        await _schoolInformation.classroom
            .collection('aulas')
            .doc('aula')
            .set(_json);
      });
      _result.isSuccess = true;
    } catch (e) {
      _result.errorMessage = e.message;
    }

    return _result;
  }

  Future<List<EventMonthModel>> getEventList(String _uid) async {
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    var _eventTotalList = List<EventModel>();
    var _eventDayList = List<EventDayModel>();
    var _eventMonthList = List<EventMonthModel>();
    DocumentReference _documentReference =
        _instance.firestore.collection('usuarios').doc(_uid);

    await _documentReference
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((snapshots) async {
      _schoolInformation = SchoolInformationModel.fromJson(snapshots.data());
      await _schoolInformation.classroom
          .collection('calendario')
          .orderBy('data', descending: false)
          .get()
          .then((_result) {
        _result.docs.forEach((_value) {
          _eventTotalList.add(EventModel.fromJson(_value.data()));
        });
        _eventTotalList
            .map((_evento) => _evento.date.month)
            .toSet()
            .forEach((_evento) async {
          _eventDayList = [];
          _eventTotalList
              .where((a) => a.date.month == _evento)
              .forEach((EventModel _onValue) {
            if (_eventDayList.indexWhere(
                    (listEvento) => listEvento.day.day == _onValue.date.day) !=
                -1) {
              _eventDayList
                  .where(
                      (listEvento) => listEvento.day.day == _onValue.date.day)
                  .first
                ..day = _onValue.date
                ..events.add(_onValue);
            } else {
              EventDayModel _eventosdayModel = EventDayModel()
                ..day = _onValue.date
                ..events = [_onValue];
              _eventDayList.add(_eventosdayModel);
            }
          });
          EventMonthModel _listAgendamentoMes = EventMonthModel()
            ..events = _eventDayList
            ..month = DateTime(DateTime.now().year, _evento);
          _eventMonthList.add(_listAgendamentoMes);
        });
      });
    });

    return _eventMonthList.toList();
  }

  Future<ClassroomModel> getClassInfo(String _uid) async {
    var _class = ClassroomModel();
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.classroom.get().then((snapshots) async {
        print(snapshots.data());
        _class = ClassroomModel.fromJson(snapshots.data());
      });
    });

    return _class;
  }

  Future<SchoolModel> getSchoolInfo(String _uid) async {
    var _school = SchoolModel();
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.school.get().then((snapshots) async {
        _school = SchoolModel.fromJson(snapshots.data());
      });
    });

    return _school;
  }

  Future<ResponseDefaultModel> saveEvent(String _uid, EventModel _event) async {
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    var _result = ResponseDefaultModel();
    _result.isSuccess = false;
    try {
      await _instance.firestore
          .collection('usuarios')
          .doc(_uid)
          .collection('informacao-escolar')
          .doc('informacao')
          .get()
          .then((_result) async {
        _schoolInformation = SchoolInformationModel.fromJson(_result.data());
        await _schoolInformation.classroom
            .collection('calendario')
            .doc()
            .set(_event.toJson());
      });
      _result.isSuccess = true;
    } catch (e) {
      _result.errorMessage = e.message;
    }

    return _result;
  }

  Future<List<NewsModel>> getNews(String _uid, {String params = ''}) async {
    var _newsList = List<NewsModel>();
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.classroom
          .collection('news')
          .where('$params')
          .orderBy('date', descending: true)
          .get()
          .then((snapshots) async {
        snapshots.docs.forEach((_onValue) {
          _newsList.add(NewsModel.fromJson(_onValue.data()));
        });
      });
      await _schoolInformation.school
          .collection('news')
          .where('$params')
          .orderBy('date', descending: true)
          .get()
          .then((snapshots) async {
        snapshots.docs.forEach((_onValue) {
          _newsList.add(NewsModel.fromJson(_onValue.data()));
        });
      });
    });
    return _newsList;
  }

  Future<NewsModel> getLastNews(String _uid) async {
    var _lastNews = NewsModel();
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.school
          .collection('noticias')
          .orderBy('data', descending: true)
          .limit(1)
          .get()
          .then((snapshots) async {
        snapshots.docs.forEach((_onValue) {
          _lastNews = NewsModel.fromJson(_onValue.data());
        });
      });
    });
    return _lastNews;
  }

  Future<void> setIntoFirebase(String _uid) async {
    var _noticia = NewsModel()
      ..data = DateTime.now()
      ..image =
          'https://firebasestorage.googleapis.com/v0/b/educational-system-61d77.appspot.com/o/escolas%2F%20WVo4wgMvXQrjNaUTlC8S%2Fnews%2Fescolas5.jpg?alt=meday&token=56a12cf4-1d00-482e-8e45-2cdde18c5ba9'
      ..user = _instance.firestore.collection('usuarios').doc(_uid)
      ..userImage =
          'https://ofuxiqueiro.com.br/wp-content/uploads/2020/03/image-8.jpeg'
      ..userName = 'João da silva'
      ..category = [CategoriaEnum.classroom.index];

    SchoolInformationModel _informacaoEscolar = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _informacaoEscolar = SchoolInformationModel.fromJson(_result.data());
      await _informacaoEscolar.classroom
          .collection('news')
          .doc()
          .set(_noticia.toJson());
    });
  }

  Future<List<FirebaseUserModel>> searchUsers(
      String _uid, String _params) async {
    var _users = List<FirebaseUserModel>();
    SchoolInformationModel _schoolInformation = SchoolInformationModel();
    await _instance.firestore
        .collection('usuarios')
        .doc(_uid)
        .collection('informacao-escolar')
        .doc('informacao')
        .get()
        .then((_result) async {
      _schoolInformation = SchoolInformationModel.fromJson(_result.data());
      await _schoolInformation.school
          .collection('usuarios')
          .orderBy('displayNameLower')
          .startAt([_params])
          .endAt([_params + '\uf8ff'])
          .get()
          .then((snapshots) async {
            await Future.forEach(snapshots.docs, (_onValue) async {
              var _user = FirebaseUserModel.fromJson(_onValue.date());
              var _result = await _user.reference.get();
              _users.add(FirebaseUserModel.fromJson(_result.data()));
            });
          });
    });
    return _users;
  }
}
