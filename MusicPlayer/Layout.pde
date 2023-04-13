// A Layout holds all interactable Elements and updates them when the Layout is being displayed
abstract class Layout extends BaseParentElement<ChildableElement> {
  Layout() {
    super();
  }
}

// The main page for all music player controls
class MainLayout extends Layout {
  MainLayout() {
    super();
    addElement(new SongController());
    //addElement(new PlayListController(new PlayList(false)));
  }
}
