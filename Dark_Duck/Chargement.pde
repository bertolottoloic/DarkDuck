void chargement() {  //Affiche la page de chargement montrant les touches
  background(0);
  image(clavier, 230.5, height*600/955);
  fill(255);
  textFont(title2, 50);
  text("Z = Monter à l'échelle", 400, 100);
  text("Q = Aller à droite", 400, 200);
  text("D = Aller à gauche", 400, 300);
  text("Espace = Sauter", 400, 400);
  text("P = Pause", 400, 500);

  if (millis()-momentDuclic>3000) {
    jeu=true;
    chargement=false;
  }
}