void addMoreItems(List<int> items) {
  int lastItem = items.last;
  for (int i = 1; i <= 20; i++) {
    items.add(lastItem + i);
  }
}
