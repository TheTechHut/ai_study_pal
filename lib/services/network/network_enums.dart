enum NetworkResponseErrorType{
  socket,
  exception,
  responseEmpty,
  didNotSucceed,
}

enum CallBackParameterName{
  all
}

extension CallBackParameterNameExtension on CallBackParameterName{
  dynamic getJson(json){
    switch(this){
      case CallBackParameterName.all:
      return json;
    }
  }
}