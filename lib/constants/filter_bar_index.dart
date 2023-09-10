class FilterBarIndex {
  static final FilterBarIndex _instance = FilterBarIndex._internal();

  late int animeFilterBarIndex;
  late int mangaFilterBarIndex;

  FilterBarIndex._internal(){
    animeFilterBarIndex = 0;
    mangaFilterBarIndex = 0;
  }

  factory FilterBarIndex() {
    return _instance;
  }
}