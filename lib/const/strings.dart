import 'package:get/get.dart';

class Strings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'LOGIN': 'LOGIN',
      'NULL_MESSAGE': 'Field must not be null',
      'LOADING_TEXT': 'Now Loading',
      'UNAUTHORIZE_MESSAGE' : 'Session Expired',
      'UNAUTHORIZE_DESC' : 'Session Expired, please re-login',
      'ERROR_TITLE_MESSAGE': 'Error Occured',
      'UNEXCPECTED_MESSAGE' : "Error Ocurrent, Try Again Later or Contact Admin"
    },
    'id_ID': {
      'LOGIN': 'LOGIN',
      'LOADING_TEXT': 'Mohon Tunggu',
      'NULL_MESSAGE' : 'Field tidak boleh kosong',
      'UNAUTHORIZE_MESSAGE' : 'Sesi Habis',
      'UNAUTHORIZE_DESC' : 'Sesi anda telah habis, mohon login ulang',
      'ERROR_TITLE_MESSAGE' : 'Terjadi Kesalahan',
      'UNEXCPECTED_MESSAGE' : "Terjadi Kesalahan, Tunggu Sesaat Lagi atau Hubungi Admin"
    }
  };
}