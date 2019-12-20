import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'dart:math';
import 'package:pointycastle/asymmetric/api.dart';

class Generate{

  static const _publicKeyString = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDmRJMqnHWu5tH2pkm0jOMsZ6PCruNrsklpVpAx3XLVoZrdD+uUzApBVtARuJ5WG7ZzOqYvqxf0Eeq7PekRV1T3yUMmKYT0he4xxmKoxT0Ah7nh9conbUjEAIsiPiPHdXJct6LQ3LvV5BXAavGuq3FHckiW4Eno8Q71iC3IV/722QIDAQAB";
  
  static hash256(str) {
    final bytes = utf8.encode(str);        
    String digest = sha256.convert(bytes).toString();
    print(digest);
    return digest;
  }

  static randomString(n) {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < n; i++) {
      left = left + alphabet[Random().nextInt(alphabet.length)]; 
    } 
    print(left);
    return left;
  }

  // static encrypt(data) async{
  //   // var directory = await getApplicationDocumentsDirectory();
  //   // print(directory.path);
  //   var publicKey = await parseKeyFromFile<RSAPublicKey>('./public.pem');
  //   // final publicKey = await parseKeyFromFile('./public.pem');
  //   final encrypter = Encrypter(RSA(publicKey: publicKey));
  //   String encrypted = encrypter.encrypt(data).base16.toString();
  //   return encrypted;
  // }

  static Future<String> rsaEncode (String base64PlainText, {String publicKey=_publicKeyString}) async {
    var parser = RSAKeyParser();
    String rsaPublic = "-----BEGIN PUBLIC KEY-----\n$publicKey\n-----END PUBLIC KEY-----";
    RSAPublicKey rsaPublicKey = parser.parse(rsaPublic);
   // String rsaTxt =  await crypto.DYFCryptoProvider.rsaEncrypt(plainText, key);
    return Encrypter(RSA(publicKey: rsaPublicKey)).encrypt(base64PlainText).base64;
  }

  static generatePassword(password) async{
    final hash = hash256(password);
    final data = randomString(10) + hash;
    return await rsaEncode(data);
  }

}