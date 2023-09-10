class SearchType {
  static final SearchType _instance = SearchType._internal();

  late bool isAnime;
  SearchType._internal(){
    isAnime = true;
  }
  
  factory SearchType() {
    return _instance;
  }
}