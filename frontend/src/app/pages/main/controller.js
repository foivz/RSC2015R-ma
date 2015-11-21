class MainController {
  constructor(mainService, uiGmapGoogleMapApi) {
    'ngInject';
    this.game = mainService.getGame();
    this.map = this.game.field;

    uiGmapGoogleMapApi.then(() => {
      
    });
  }
}

export default MainController;
