

class API {
  Map<String, dynamic> apis;
  String baseURl;

  API({this.apis, this.baseURl}){
    this.apis = {
      lists: '/lists'
    };
    this.baseURl = 'https://www.fastmock.site/mock/ea1ca5ef5df2f1225b6c3e502c1772b6/shmilyvidian';
  }

  get lists => null;
}