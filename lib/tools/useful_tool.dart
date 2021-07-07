import 'dart:math';

String generatePassword(){

  final lenght =20;
  final lettersLowerCase="abcdefghijklmnopqrstuvwxyz";
  final letterSUppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final numbers="0123456789";
  final special ="@#=+!\$%&{}()";
  String chars='';

  chars +="$lettersLowerCase$letterSUppercase";
  chars +="$numbers";
  chars +="$special";
  return List.generate(lenght, (index) {

    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join("");
}