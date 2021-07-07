import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';
import 'package:scanner_qr_sys/sheet_model/user.dart';
import 'package:intl/intl.dart';

class UserSheetsApi {
  static const _credentials = r'''
  
  {
  "type": "service_account",
  "project_id": "employees-sys",
  "private_key_id": "896398863bc0dfa376cdc3e3216be64e917c140c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDC8IY4EsuUhp7d\nA9kgq183qztva97YYOb5YM9IOyD/FF6ZQ6tcyH0jzgivQIlrqqeaYgS17QWfJXtU\naHM9bxWsQYFXvxIQJTyA3p90v6E4v3vaDtFSmjhbo8Wu9n3wUtRNdNhV2WKsVnyu\neGcQgEjMOwmNLMzQBhVGskfIZtXZIETe0Vv4ZT6e0NnxHwfjb2M7cxdwii3udYKk\ndyRlum7P/GzieTeaBTVGmIIjLryL3pCzf8n+X1XJaBNxQa6PxQuPTlpZhVwKI8xl\n7OqboN9ZBtM2ItnTX7FyQeoztsfPUHhxxN0S7z/jnlNkago1+y5PDxG4PjLIw9mC\n4StS6pUTAgMBAAECggEAB7Ep+qhzNAcj2aC/PpTEixPMopblEjCwrIJva3A52xbY\nrL+I0X5vwavtl8y6H296cZMQkIUrxZ3bAfelJHVvq35iNi4p7k0p2APw0tCE8hJM\nNsyC4fmH48XQlRjQ21zJV80WhDyxsg8vmErT9ki5lqV1uQZdho/W4xVB09yK76hO\nmzn6Q0RqTPG8k3OfnHkYgkuqyGdun3sxD6h+Oh5PlWPKhzcJMePn2Ff8d9oB8vzp\nzUjMGT/rmuEvUTb+G2K1+7G3YiQFr8hqYKGTJZBYHqV8nG5UOjeAQSGheBck7EAv\nQeVh0TLgyZrVZb84k4II6zOBEuVh1Hu9sCeqmGX8YQKBgQD0zwG3AuhpZpKXb1P3\n8wYM2IbsNm7su1rwt3HCtRWOCw47pWSajH41z2x0KJM1Xv6mtsOAN0huBBhCH+Va\n9Kd98zh3rMzAC8kU+KBDGg/b4RNljay9Aw+kxJ+rvxhoG6GwbOr1U6ViLxCGkbr0\nn/Zj2QPt9uUO2XH21WthsFf1CwKBgQDL2eZ2tEg15t2wRfsRg3KLtKy0n9oDu4lj\n6ILrCLIsO5Z9wsQwdoz2urP+J+ZjPZ5NKQaYX+9rwBX8Pe1SYWts5sHU1GC4IJir\n1wfGrPn6qLH3qiZ0qri9ONTeqAj9XHU3FTiSjeuf4oZgEcf/vCuN87mKeNbKp7C0\njnCQzkVVGQKBgQDg4FrZ6yDk2SUlWE2QwTu4hxoBV8szSLMz1b75NXCUZ1FutvIg\nCZhSA7TDSxZWe2l+aPpTB/VPohFKhJQhpgVJbCddv2zhqLHQwsYsfX894pX3vlmD\n0pEHMNrfYA2ibGdtcc+vBWQxObx7cNiEp4Akng+/AwHMTzAhplAaj2tsmwKBgQC3\nmuds+ywfAHWkEyPzvkUpd+4mMeQXgI5aok1ojEiOdo0xcH9sdxq4D6mWvTFRKWqv\nbMg37hCjKDulGdHrZTtwttbWbwM+VH2uKNskIyB0mATTYTmJ00rZg5qXgRm3udMJ\nbd+qgJE9TLZjSSCuQjmofWEcS4KKvUb3GWRhyKfB4QKBgQC9D8G9SBIZNuhsk/RA\nlv1aummHgz04SgMEUN1Jc4WcOKHeFEA33XsDlLley/Ef+MLcmZrYmgSiS81zJC4K\nUqF/+ff6f7MeKfVp1rDX4kVKLC7E42aTvXdZYossQV79HMHESFLDDCK9kx0sx17F\nAnYWQDucZKOox4Vut3zkQJKbzw==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@employees-sys.iam.gserviceaccount.com",
  "client_id": "115907988913004491195",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40employees-sys.iam.gserviceaccount.com"
}
  
  ''';

  static final _spreadsheetID =
      "1we-9Ct51sl4OhVZrepn1KQqwlR2_9TZxe81HRaAn6os"; //"1i-I7qx-A-ZXLvrMd2JSPgS9yAgjjhbKrUbxqfn6zfNE";

  static final _gSheets = GSheets(_credentials);

  static Worksheet _userSheet;

  static Future init({@required Map userData}) async {
    final spreadsheet = await _gSheets.spreadsheet(_spreadsheetID);

    _userSheet = await _getWorkSheet(spreadsheet, title: "${userData[UserFields.name]}_${userData[UserFields.id]}");


    DateTime date = DateTime.now().add(Duration(hours: 1));

    //TODO Done  //use this for one time when first time  scanner
    print("______________+++++++++++++++_________");
    print( DateFormat('h:mm a').format(date));
    //bool iosfirstTime=await _userSheet.values.value(column:8,row: 4) == "";
    // print(iosfirstTime);
    //
    // if(iosfirstTime )
    // {
    //   print("????????????????? update general info");
    //   await addData(date);
    //   await addCompanyInfo(["Libyan Telecom Company","Libya/Tripoli","(09X) XXX-XXXX","https://www.libyana.ly"]);//TODO Done
    //   await addGeneralInfo(userData); //TODO Done
    // }
    print("?????????????????" );
    await update(date);// TODO Done

  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {@required String title}) async {
    try {
      //TODO copy exist work sheet using copyWorksheet(title);

      return await spreadsheet.copyWorksheet(  spreadsheet.worksheetByTitle("General"),title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }




  static Future<void> addGeneralInfo( Map userData) async {
     if(_userSheet == null) return ;

    await _userSheet.values.insertValue(userData[UserFields.name]??"",column:8,row: 4);
    await _userSheet.values.insertValue(userData[UserFields.email],column:8,row: 6);
    await _userSheet.values.insertValue(userData[UserFields.id]??"",column:8,row: 8);
    await _userSheet.values.insertValue(userData[UserFields.cardID]??"",column:8,row: 9);
  }

  static Future addCompanyInfo (List<String> columnList) async {
    if(_userSheet == null) return ;

    await _userSheet.values.insertColumn(1,columnList ,fromRow: 3);
  }

  static Future addData (DateTime date) async {
    if (_userSheet == null) return;


    await _userSheet.values.insertValue(DateFormat.yMd().format(date),column:8,row: 12);//('MMM/d/yyyy') //"07/06/2021"??""

  }

  static Future update (DateTime date) async {
    if(_userSheet == null)return ;

    String dateFormat = DateFormat('EEEE').format(date).toString();

    //check if employee check in or check out
    bool isIn=true; //TODO use diloge or Ai to check if in or out
    bool partTwo=false;

   print(dateFormat);

    switch(dateFormat){
      case("Tuesday"):
        await _userSheet.values.insertValue(DateFormat('h:mm a').format(date)??"",column:isIn?2:3,row: 15);
        break;
      case("Wednesday"):
        print("fuckypo");
        bool state=await _userSheet.values.insertValue(DateFormat('h:mm:ss a').format(date)??"",column:isIn?2:3,row: 16);
        print("$state");
        break;
      case("Thursday"):
        await _userSheet.values.insertValue(DateFormat('h:mm:ss a').format(date)??"",column:isIn?2:3,row: 17);
        break;
      case("Friday"):
        await _userSheet.values.insertValue(DateFormat('h:mm:ss a').format(date)??"",column:isIn?2:3,row: 18);
        break;
      case("SaturDay"):
        await _userSheet.values.insertValue(DateFormat('h:mm:ss a').format(date)??"",column:isIn?2:3,row: 19);
        break;
      case("Sunday"):
        await _userSheet.values.insertValue(DateFormat('h:mm:ss a').format(date)??"",column:isIn?2:3,row: 20);
        break;
      case("Monday"):
        await _userSheet.values.insertValue(DateFormat('h:mm:ss a').format(date)??"",column:isIn?2:3,row: 21);
        break;

    }

  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    // if(_userSheet == null)=>return ;

    return await _userSheet.values.map.appendRows(rowList);
  }
}
