import gifAnimation.*;

float x, y, ypre, speed, gravity, gravityegg, gd=3, angle, climb=1, tempsvie, momentDuclic, spawnoeufx, spawnoeufy;
int pheight, pwidth, hauteurchasseur, largeuroeuf, nechelle, noeuf, nplateforme, vie, viecanard;
boolean jeu, chargement, menu, lecture, saut, deplacement=false, plateforme, directionchasseur, detectechelle, rightegg, leftegg, cooldown, toucher, detectsaut;
boolean [] move= new boolean [4];
float [][] position=new float[4][24];
float[][] echelle=new float[3][23];
int[][] directionoeuf=new int[2][5];
float[][] oeuf=new float[8][20];
PImage chasseur1, chasseur2, eau, canarddroite, canardgauche, background, coeur, petiteechelle, echellehaut, echellemilieu, echellebas, clavier, imgmenu;
Gif Oeufgauche, Oeufdroite;
PFont Title, title2;

void setup() {
  size(1280, 955);
  pheight=height/955; //proportionnalité selon la hauteur
  pwidth=width/1280;  //proportionnalité selon la largeur
  hauteurchasseur=26*pwidth*80/51;
  largeuroeuf=45*pheight*70/77;
  y=850-hauteurchasseur*pheight;
  x=width/2-13;
  ypre=y;
  angle=0.1;
  speed=3;
  gravity=0.1;
  gravityegg=0.1;
  saut=false;
  jeu=false;
  menu=true;
  chargement=false;
  plateforme=false;
  directionchasseur=true;//True indique que le chasseur va vers la droite et false qu'il va vers la gauche
  noeuf=0;
  nechelle=-1;
  nplateforme=-1;
  cooldown=true;
  viecanard=3;
  vie=3;
  spawnoeufx=width/2-22.5*pheight;
  spawnoeufy=155*pheight;
  toucher=false;
  lecture=true;
  loop();
  frameRate(120);

  position[0][0]=540*pwidth; /*Abscisse de la plate-forme*/ position[1][0]=850*pheight; /*Ordonnées de la plate-forme*/ position[2][0]=200*pwidth; /*Largeur de la plate-forme*/ position[3][0]=10*pheight; /*Hauteur de la plate-forme*/ 
  position[0][1]=1045*pwidth;position[1][1]=340*pheight;position[2][1]=100*pwidth;position[3][1]=10*pheight;
  position[0][2]=420*pwidth;position[1][2]=80*pheight;position[2][2]=150*pwidth;position[3][2]=10*pheight;
  position[0][3]=250*pwidth;position[1][3]=630*pheight;position[2][3]=150*pheight;position[3][3]=10*pheight;
  position[0][4]=890*pwidth;position[1][4]=740*pheight;position[2][4]=75*pheight;position[3][4]=10*pheight;
  position[0][5]=790*pwidth;position[1][5]=790*pheight;position[2][5]=75*pheight;position[3][5]=10*pheight;
  position[0][6]=400*pwidth;position[1][6]=690*pheight;position[2][6]=750*pheight;position[3][6]=10*pheight;
  position[0][7]=150*pwidth;position[1][7]=580*pheight;position[2][7]=75*pheight;position[3][7]=10*pheight;
  position[0][8]=250*pwidth;position[1][8]=530*pheight;position[2][8]=75*pheight;position[3][8]=10*pheight;
  position[0][9]=350*pwidth;position[1][9]=480*pheight;position[2][9]=100*pheight;position[3][9]=10*pheight;
  position[0][10]=475*pwidth;position[1][10]=430*pheight;position[2][10]=100*pheight;position[3][10]=10*pheight;
  position[0][11]=240*pwidth;position[1][11]=250*pheight;position[2][11]=100*pheight;position[3][11]=10*pheight;
  position[0][12]=720*pwidth;position[1][12]=590*pheight;position[2][12]=100*pheight;position[3][12]=10*pheight;
  position[0][13]=300*pwidth;position[1][13]=380*pheight;position[2][13]=150*pheight;position[3][13]=10*pheight;
  position[0][14]=390*pwidth;position[1][14]=200*pheight;position[2][14]=500*pwidth;position[3][14]=10*pheight;
  position[0][15]=845*pwidth;position[1][15]=540*pheight;position[2][15]=75*pwidth;position[3][15]=10*pheight;
  position[0][16]=465*pwidth;position[1][16]=250*pheight;position[2][16]=350*pwidth;position[3][16]=10*pheight;
  position[0][17]=945*pwidth;position[1][17]=490*pheight;position[2][17]=100*pwidth;position[3][17]=10*pheight;
  position[0][18]=770*pwidth;position[1][18]=440*pheight;position[2][18]=150*pwidth;position[3][18]=10*pheight;
  position[0][19]=945*pwidth;position[1][19]=390*pheight;position[2][19]=75*pwidth;position[3][19]=10*pheight;
  position[0][20]=1175*pwidth;position[1][20]=290*pheight;position[2][20]=75*pwidth;position[3][20]=10*pheight;
  position[0][21]=920*pwidth;position[1][21]=240*pheight;position[2][21]=200*pwidth;position[3][21]=10*pheight;
  position[0][22]=930*pwidth;position[1][22]=140*pheight;position[2][22]=75*pwidth;position[3][22]=10*pheight;
  position[0][23]=720*pwidth;position[1][23]=110*pheight;position[2][23]=150*pwidth;position[3][23]=10*pheight;

  
  echelle[0][0]=927.5*pwidth;/*Abscisse échelle*/echelle[1][0]=700*pheight;/*Ordonnée échelle*/echelle[2][0]=20;/*Longueur échelle*/ //20 pour 15 de largeur
  echelle[0][1]=300*pwidth;echelle[1][1]=260*pheight;echelle[2][1]=20;
  echelle[0][2]=300*pwidth;echelle[1][2]=280*pheight;echelle[2][2]=20;
  echelle[0][3]=300*pwidth;echelle[1][3]=300*pheight;echelle[2][3]=20;
  echelle[0][4]=300*pwidth;echelle[1][4]=320*pheight;echelle[2][4]=20;
  echelle[0][5]=300*pwidth;echelle[1][5]=340*pheight;echelle[2][5]=20;
  echelle[0][6]=445*pwidth;echelle[1][6]=90*pheight;echelle[2][6]=20;
  echelle[0][7]=445*pwidth;echelle[1][7]=110*pheight;echelle[2][7]=20;
  echelle[0][8]=445*pwidth;echelle[1][8]=130*pheight;echelle[2][8]=20;
  echelle[0][9]=445*pwidth;echelle[1][9]=150*pheight;echelle[2][9]=20;
  echelle[0][10]=445*pwidth;echelle[1][10]=170*pheight;echelle[2][10]=20;
  echelle[0][11]=740*pwidth;echelle[1][11]=600*pheight;echelle[2][11]=20;
  echelle[0][12]=740*pwidth;echelle[1][12]=620*pheight;echelle[2][12]=20;
  echelle[0][13]=740*pwidth;echelle[1][13]=640*pheight;echelle[2][13]=20;
  echelle[0][14]=740*pwidth;echelle[1][14]=660*pheight;echelle[2][14]=20;
  echelle[0][15]=775*pwidth;echelle[1][15]=260*pheight;echelle[2][15]=20;
  echelle[0][16]=775*pwidth;echelle[1][16]=280*pheight;echelle[2][16]=20;
  echelle[0][17]=775*pwidth;echelle[1][17]=300*pheight;echelle[2][17]=20;
  echelle[0][18]=775*pwidth;echelle[1][18]=320*pheight;echelle[2][18]=20;
  echelle[0][19]=775*pwidth;echelle[1][19]=340*pheight;echelle[2][19]=20;
  echelle[0][20]=775*pwidth;echelle[1][20]=360*pheight;echelle[2][20]=20;
  echelle[0][21]=775*pwidth;echelle[1][21]=380*pheight;echelle[2][21]=20;
  echelle[0][22]=775*pwidth;echelle[1][22]=400*pheight;echelle[2][22]=20;
  
  oeuf[0][0]=spawnoeufx; /*Abscisse de l'oeuf*/ oeuf[1][0]=spawnoeufy; /*Ordonnée de l'oeuf*/ oeuf[2][0]=int(random(0,2)); /*Direction de l'oeuf*/ oeuf[3][0]=0; /*Contrôle si l'oeuf est sur la plate-forme*/ oeuf[4][0]=-0.5; /*Vitesse de chute de l'oeuf*/ oeuf[5][0]=3; /*Vitesse déplacement oeuf*/ oeuf[6][0]=0; /*Détermine si l'oeuf est sur la map*/ oeuf[7][0]=0; /*Permet d'établir un écart entre l'apparition des oeufs*/
  oeuf[0][1]=spawnoeufx;oeuf[1][1]=spawnoeufy;oeuf[2][1]=int(random(0,2));oeuf[3][1]=0;oeuf[4][1]=-0.5;oeuf[5][1]=3;oeuf[6][1]=0;oeuf[7][1]=0;
  oeuf[0][2]=spawnoeufx;oeuf[1][2]=spawnoeufy;oeuf[2][2]=int(random(0,2));oeuf[3][2]=0;oeuf[4][2]=-0.5;oeuf[5][2]=3;oeuf[6][2]=0;oeuf[7][2]=0;
  oeuf[0][3]=spawnoeufx;oeuf[1][3]=spawnoeufy;oeuf[2][3]=int(random(0,2));oeuf[3][3]=0;oeuf[4][3]=-0.5;oeuf[5][3]=3;oeuf[6][3]=0;oeuf[7][3]=0;
  oeuf[0][4]=spawnoeufx;oeuf[1][4]=spawnoeufy;oeuf[2][4]=int(random(0,2));oeuf[3][4]=0;oeuf[4][4]=-0.5;oeuf[5][4]=3;oeuf[6][4]=0;oeuf[7][4]=0;
  oeuf[0][5]=spawnoeufx;oeuf[1][5]=spawnoeufy;oeuf[2][5]=int(random(0,2));oeuf[3][5]=0;oeuf[4][5]=-0.5;oeuf[5][5]=3;oeuf[6][5]=0;oeuf[7][5]=0;
  oeuf[0][6]=spawnoeufx;oeuf[1][6]=spawnoeufy;oeuf[2][6]=int(random(0,2));oeuf[3][6]=0;oeuf[4][6]=-0.5;oeuf[5][6]=3;oeuf[6][6]=0;oeuf[7][6]=0;
  oeuf[0][7]=spawnoeufx;oeuf[1][7]=spawnoeufy;oeuf[2][7]=int(random(0,2));oeuf[3][7]=0;oeuf[4][7]=-0.5;oeuf[5][7]=3;oeuf[6][7]=0;oeuf[7][7]=0;
  oeuf[0][8]=spawnoeufx;oeuf[1][8]=spawnoeufy;oeuf[2][8]=int(random(0,2));oeuf[3][8]=0;oeuf[4][8]=-0.5;oeuf[5][8]=3;oeuf[6][8]=0;oeuf[7][8]=0;
  oeuf[0][9]=spawnoeufx;oeuf[1][9]=spawnoeufy;oeuf[2][9]=int(random(0,2));oeuf[3][9]=0;oeuf[4][9]=-0.5;oeuf[5][9]=3;oeuf[6][9]=0;oeuf[7][9]=0;
  oeuf[0][10]=spawnoeufx;oeuf[1][10]=spawnoeufy;oeuf[2][10]=int(random(0,2));oeuf[3][10]=0;oeuf[4][10]=-0.5;oeuf[5][10]=3;oeuf[6][10]=0;oeuf[7][10]=0;
  oeuf[0][11]=spawnoeufx;oeuf[1][11]=spawnoeufy;oeuf[2][11]=int(random(0,2));oeuf[3][11]=0;oeuf[4][11]=-0.5;oeuf[5][11]=3;oeuf[6][11]=0;oeuf[7][11]=0;
  oeuf[0][12]=spawnoeufx;oeuf[1][12]=spawnoeufy;oeuf[2][12]=int(random(0,2));oeuf[3][12]=0;oeuf[4][12]=-0.5;oeuf[5][12]=3;oeuf[6][12]=0;oeuf[7][12]=0;
  oeuf[0][13]=spawnoeufx;oeuf[1][13]=spawnoeufy;oeuf[2][13]=int(random(0,2));oeuf[3][13]=0;oeuf[4][13]=-0.5;oeuf[5][13]=3;oeuf[6][13]=0;oeuf[7][13]=0;
  oeuf[0][14]=spawnoeufx;oeuf[1][14]=spawnoeufy;oeuf[2][14]=int(random(0,2));oeuf[3][14]=0;oeuf[4][14]=-0.5;oeuf[5][14]=3;oeuf[6][14]=0;oeuf[7][14]=0;
  oeuf[0][15]=spawnoeufx;oeuf[1][15]=spawnoeufy;oeuf[2][15]=int(random(0,2));oeuf[3][15]=0;oeuf[4][15]=-0.5;oeuf[5][15]=3;oeuf[6][15]=0;oeuf[7][15]=0;
  oeuf[0][16]=spawnoeufx;oeuf[1][16]=spawnoeufy;oeuf[2][16]=int(random(0,2));oeuf[3][16]=0;oeuf[4][16]=-0.5;oeuf[5][16]=3;oeuf[6][16]=0;oeuf[7][16]=0;
  oeuf[0][17]=spawnoeufx;oeuf[1][17]=spawnoeufy;oeuf[2][17]=int(random(0,2));oeuf[3][17]=0;oeuf[4][17]=-0.5;oeuf[5][17]=3;oeuf[6][17]=0;oeuf[7][17]=0;
  oeuf[0][18]=spawnoeufx;oeuf[1][18]=spawnoeufy;oeuf[2][18]=int(random(0,2));oeuf[3][18]=0;oeuf[4][18]=-0.5;oeuf[5][18]=3;oeuf[6][18]=0;oeuf[7][18]=0;
  oeuf[0][19]=spawnoeufx;oeuf[1][19]=spawnoeufy;oeuf[2][19]=int(random(0,2));oeuf[3][19]=0;oeuf[4][19]=-0.5;oeuf[5][19]=3;oeuf[6][19]=0;oeuf[7][19]=0;

  chasseur1 = loadImage("chasseurarretdroite.png");
  chasseur2 = loadImage("chasseurarretgauche.png");
  eau = loadImage("eau.png");
  canarddroite = loadImage("canarddroite.png");
  canardgauche = loadImage("canardgauche.png");
  background = loadImage("paysage.png");
  coeur = loadImage("coeur.png");
  echellemilieu = loadImage("echellereli.png");
  clavier = loadImage("clavier.jpg");
  imgmenu = loadImage("menu1.png");
  Oeufgauche = new Gif(this, "oeufgauche.gif");
  Oeufdroite = new Gif(this, "oeufdroite.gif");

  Title = createFont("DeathtoMetal.ttf", 200);
  title2 = createFont("ArialMT-50.vlw", 50);
}

void draw() {
  if (menu==true) {  //Détermine si le menu s'affiche
    menu();
  }


  if (chargement==true) {  //Détermine si le chargement s'affiche
    chargement();
  }

  if (jeu==true) {  //Détermine si le jeu s'affiche
    jeu();
  }
}

void mousePressed() {
  if (menu==true && mouseButton==LEFT && mouseY<=900 && mouseY>=825 && mouseX>=550 && mouseX<=740) {  //Permet de cliquer sur le bouton jouer
    menu=false;
    chargement=true;
    momentDuclic=millis();
  }
}