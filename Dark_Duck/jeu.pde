void jeu() {
  background(255);
  image(background, 0, 0);
  fill(0);
  if (oeuf[2][noeuf]==0) {  //Affiche le cannard en fonction de l'oeuf qu'il pond (cependant cette condition ne marche pas bien car la direction de l'oeuf étant random, elle change jusqu'à ce que l'oeuf spawn)
    image(canarddroite, width/2-54.925, 100, 109.85, 100);
  } else if (oeuf[2][noeuf]==1) {
    image(canardgauche, width/2-54.925, 100, 109.85, 100);
  }



  for (int j=0; j<position[0].length; j++) {//Dessine toutes les plate-formes
    fill(167, 103, 38);
    stroke(0);
    rect(position[0][j], position[1][j], position[2][j], position[3][j]);
  }
  noFill();
  for (int j=0; j<echelle[0].length; j++) {//Dessine toutes les échelles
    image(echellemilieu, echelle[0][j], echelle[1][j], 20*pwidth, echelle[2][j]*pheight);
  }  

  if (move[0]==true) {  //Met la variable right en true si le chasseur va vers la droite
    directionchasseur=true;
  }

  if (move[1]==true) {  //Met la variable right en left si le chasseur va vers la gauche
    directionchasseur=false;
  }

  if (cooldown==true) {  
    if (directionchasseur==true) {  //Affiche le chasseur selon la direction indiquée par la variable booléenne directionchasseur
      image(chasseur1, x%width, y, 26*pwidth, hauteurchasseur*pheight);
    } else {
      image(chasseur2, x%width, y, 26*pwidth, hauteurchasseur*pheight);
    }
  }

  if (toucher==true) {  //Laisse au joueur un temps avant de pouvoir subir de nouveau des dégats
    degat();
  }

  if (millis()-oeuf[7][noeuf]>random(2500, 5000) && noeuf<19) {  //Si un temps compris entre 5 et 10 secondes s'est écoulé l'oeuf suivant apparaît
    oeuf[6][noeuf]=1;//Déclare que l'oeuf est apparu
    oeuf[7][noeuf+1]=millis();//Attribue millis() lorqu'un oeuf apparaît à l'oeuf suivant afin d'avoir un écart dans l'apparition des oeufs
  } 

  if (millis()-oeuf[7][noeuf]>random(2500, 5000)) {  //Le numéro de l'oeuf passe au suivant si un temps suffisant s'est écoulé
    noeuf=noeuf+1;
  }

  if (noeuf>19) {  //Remet le numéro de l'oeuf à 0 si tous les oeufs sont apparus 
    noeuf=0;
  }

  for (int i=0; i<oeuf[0].length; i++) {  //Dessine les oeufs qui sont présents sur la map en fonction de leur direction
    if (oeuf[6][i]==1 && oeuf[2][i]==1) {  //Dessine les oeufs qui vont vers la droite
      Oeufdroite.play();
      image(Oeufdroite, oeuf[0][i], oeuf[1][i], largeuroeuf, 45*pheight);
      oeuf[0][i]=oeuf[0][i]+(oeuf[5][i]/2);
    }

    if (oeuf[6][i]==1 && oeuf[2][i]==0) {  //Dessine les oeufs qui vont vers la gauche
      Oeufgauche.play();
      image(Oeufgauche, oeuf[0][i], oeuf[1][i], largeuroeuf, 45*pheight);
      oeuf[0][i]=oeuf[0][i]-(oeuf[5][i]/2);
    }

    if (oeuf[3][i]==0) {  //Fait tomber les oeufs si ils ne sont pas sur une plate-forme
      oeuf[1][i]=oeuf[1][i]-oeuf[4][i];
      oeuf[4][i]=oeuf[4][i]-gravityegg;
    } 

    if (oeuf[3][i]==0 && oeuf[4][i]<-3 && oeuf[4][i]>-3.1) {
      if (oeuf[1][i]<600*pheight && oeuf[0][i]>200*pwidth && oeuf[0][i]<1150*pwidth) {  //Fait changer aléatoirement de sens les oeufs lors de leurs chute 
        oeuf[2][i]=int(random(0, 2));
      } else if (oeuf[1][i]<600*pheight && (oeuf[0][i]<200*pwidth || oeuf[0][i]>1150*pwidth)) {
        if (oeuf[2][i]==0) {
          oeuf[2][i]=1;
        } else if (oeuf[2][i]==1) {
          oeuf[2][i]=0;
        }
      } else if (oeuf[1][i]>600*pheight) {
        if (oeuf[2][i]==0) {
          oeuf[2][i]=0;
        } else if (oeuf[2][i]==1) {
          oeuf[2][i]=1;
        }
      }
    }

    if (oeuf[1][i]>860 && oeuf[4][i]<-0.5) {  //Change la vitesse de déplacement et de chute lorsque l'oeuf tombe dans l'eau
      oeuf[4][i]=-0.5;
      oeuf[5][i]=0.5;
    } else if (oeuf[1][i]<860) {  //Remet la vitesse de déplacement à sa valeur initiale lorque l'oeuf revient au point de départ
      oeuf[5][i]=3;
    }

    if (oeuf[1][i]>height) {  //Remet les coordonnées de l'oeuf aux valeurs initiales et indique que l'oeuf n'est plus sur la carte 
      oeuf[1][i]=155;
      oeuf[0][i]=690*pwidth;
      oeuf[6][i]=0;
    }
    
    if (toucher==false) {  //Détecte si le joueur percute un oeuf et lui enlève une vie
      if ((y+hauteurchasseur>oeuf[1][i] && y<oeuf[1][i]+45*pheight && x+26*pwidth>oeuf[0][i] && x<oeuf[0][i]+largeuroeuf && oeuf[6][i]==1) || (y+hauteurchasseur>100 && y<200 && x+26*pwidth>width/2-54.925 && x<width/2-54.925+109.85 && speed<=0)) {
        tempsvie=millis();
        vie=vie-1;
        toucher=true;
      }
    }
  }

  for (int j=0; j<oeuf[0].length; j++) {  //Etablit les conditions pour les oeufs et le chasseur
    for (int i=0; i<position[0].length; i++) {
      if ((oeuf[1][j]>=position[1][i]-45*pheight && oeuf[1][j]<=position[1][i] && oeuf[0][j]>=position[0][i]-largeuroeuf && oeuf[0][j]<=position[0][i]+position[2][i] )) {  //Place l'oeuf à la surface des plate-formes 

        oeuf[1][j]=(position[1][i]-45*pheight);
      } 

      if (oeuf[1][j]==(position[1][i]-45*pheight) && oeuf[0][j]>=position[0][i]-largeuroeuf && oeuf[0][j]<=position[0][i]+position[2][i]) {  //Indique que l'oeuf est sur une plate-forme entraînant son déplacement sur les plate-formes et remet sa vitesse de chute à la valeur initiale
        oeuf[3][j]=1;
        oeuf[4][j]=-0.5;
      } else if (((oeuf[1][j]==(position[1][i]-45*pheight) && (oeuf[0][j]<=position[0][i]-largeuroeuf || oeuf[0][j]>=position[0][i]+position[2][i])))) {  //Indique que l'oeuf n'est plus sur la plate-forme
        oeuf[3][j]=0;
      }
    }
  }

  if (saut==true) {  //Enclenche le saut du personnage
    y=y+speed;
    speed=speed+gravity;
  }

  if (y<=860 && y>855-hauteurchasseur*pheight) {  //Permet au personnage de retrouver un saut normal à la surface de l'eau 
    ypre=y;
  }

  for (int i=0; i<position[0].length; i++) {  //Détecte si le chasseur se trouve au niveau d'une plate-forme
    if ((y>=position[1][i]-hauteurchasseur*pheight && y<=position[1][i] && x>=position[0][i]-26*pwidth && x<=position[0][i]+position[2][i] )) {  //Place le chasseur à la surface de la plate-forme et si le chasseur monte une échelle indique que le chasseur n'est plus sur l'échelle

      y=(position[1][i]-hauteurchasseur*pheight);
      nechelle=-1;
      nplateforme=i;  //Détermine sur quelle plateforme le chasseur se trouve précisément
      ypre=y;
    } 

    if ((y<position[1][i]+position[3][i] && y>position[1][i] && x>=position[0][i]-26*pwidth && x<=position[0][i]+position[2][i]) || ((y==(position[1][i]-hauteurchasseur*pheight) && (x<=position[0][i]-26*pwidth || x>=position[0][i]+position[2][i]) && saut==false)) && speed<1) {  //Entraîne la chute du chasseur si il tape le dessous d'une plate-forme ou chute de la plate-forme

      saut=false;
      speed=1;
    }
  }

  if (nplateforme>-1) {  //Applique la condition ci-dessous seulement à la plate-forme sur laquelle le chasseur se trouve
    if (((y==(position[1][nplateforme]-hauteurchasseur*pheight) && (x<=position[0][nplateforme]-26*pwidth || x>=position[0][nplateforme]+position[2][nplateforme]))) || move[2]==true) {
      nplateforme=-1;
    }
  }

  if (nplateforme==-1) {  //Détermine si le chasseur se trouve ou non sur une plate-forme
    plateforme=false;
  } else {
    plateforme=true;
  }


  for (int i=0; i<echelle[0].length; i++) {  //Indique si le chasseur se  trouve au niveau d'une échelle
    if (y<echelle[1][i]+echelle[2][i]*pheight && y>echelle[1][i]-27*pheight && x<echelle[0][i]+20*pwidth && x>echelle[0][i]-24*pwidth) {  //Attribue le numéro de l'échelle devant laquelle le chasseur se trouve à la variable nechelle
      nechelle=i;
    }
  }

  if (nechelle>-1) {  //Applique le if ci-dessous uniquement si le chasseur est sur une échelle et qu'il la quitte
    if ((y<echelle[1][nechelle]+echelle[2][nechelle]*pheight && y>echelle[1][nechelle]-27*pheight && (x>echelle[0][nechelle]+20*pwidth || x<echelle[0][nechelle]-26*pwidth)) || saut==true) {  //Remet la valeur initiale de nechelle si le chasseur sort de l'échelle sur laquelle il se trouve
      nechelle=-1;
    }
  }

  if (nechelle==-1) {  //Détermine si le chasseur peut monter à l'échelle
    detectechelle=false;
  } else {
    detectechelle=true;
  }



  if (plateforme==false && saut==false && detectechelle==false) {  //Entraîne la chute du chasseur si il n'est ni sur  une plate-forme, ni sur une échelle et si iln'est pas en plein saut
    speed=speed+gravity;
    y=y+speed;
  }

  if (y>855 && y<=height) {  //Diminue la gravité qui s'applique sur le chasseur dans l'eau
    gravity=0.01;
  } else {
    gravity=0.1;
  }

  if (y>855 && y<=height && speed>0.5) {  //Diminue la vitesse de chute du personnage
    speed=0.5;
  }

  if (y>840-hauteurchasseur*pheight && y<=height && gravity==0.01) {  //Réduit la vitesse de chute dans l'eau
    gd=0.5;
  } else {
    gd=3;
  }

  if (y>height) {  //Déclare que le personnage est mort si il se noie
    speed=0;
    saut=false;
    vie=0;
  }

  if (move[0]==true) {  //Permet le mouvement vers la droite du personnage
    x=x+gd;
  }

  if (x>width) {  //Remet l'abscisse du personnage à 0 si il sort de la map à droite
    x=0;
  }

  if (move[1]==true) {  //Permet le mouvement vers la gauche du personnage
    x=x-gd;
  }

  if (x<0-20) {  //Remet l'abscisse du personnage à 0 si il sort de la map à droite
    x=width-26*pwidth;
  }

  if (move[2]==true) {  //Déclare que le personnage
    y=y-climb;
  } else if (detectechelle==true && move[2]==false ) {
    y=y+climb;
  }

  if (plateforme==true) {  //Définit les paramètres lorsqu'on est sur une plate-forme
    speed=0;
    saut=false;
  }

  if (y+hauteurchasseur>100 && y<200 && x+26*pwidth>width/2-54.925 && x<width/2-54.925+109.85 && speed>0 && viecanard>1) {  //Remet le personnage au spawn après avoir enlevé au canard une vie
    x=width/2-13;
    y=850-hauteurchasseur*pheight;
    viecanard=viecanard-1;
  }

  if (y+hauteurchasseur>100 && y<200 && x>width/2-54.925 && x<width/2-54.925+109.85 && speed>0 && viecanard<=1) {  //Affiche que l'on a gagné et arrête le jeu
    noLoop();
    viecanard=0;
    textSize(100);
    fill(255, 255, 0);
    text("WIN", width/2-90, height/2);
    textSize(50);
    text("Press R to restart or E to leaving", width/2-375, height/2+100);
  }

  if (vie==0) {  //Affiche que l'on a perdu et arrête le jeu
    noLoop();
    textSize(100);
    fill(255, 0, 0);
    text("GAME OVER", width/2-270, height/2);
    textSize(50);
    text("Press R to restart or E to leaving", width/2-375, height/2+100);
  }

  for (int i=0; i<vie; i++) {  //Affiche les coeurs de vie
    image(coeur, 135-45*i, 50, 25, 25);
  }
  image(eau, 0, 875);  //Affiche l'eau

  fill(255, 0, 0);
  textSize(25);
  text("Vies restantes au canard : "+viecanard, width/2-150*pwidth, 30);  //Affiche les vies qui restent au canard
  noFill();
}

void degat() {  //Permet au personnage de ne pas subir de dégats pendant 2 secondes après s'être pris un oeuf

  if (millis()-tempsvie<200 && millis()-tempsvie>50) {
    cooldown=false;
  } else if (millis()-tempsvie<400 && millis()-tempsvie>200) {
    cooldown=true;
  } else if (millis()-tempsvie<600 && millis()-tempsvie>400) {
    cooldown=false;
  } else if (millis()-tempsvie<800 && millis()-tempsvie>600) {
    cooldown=true;
  } else if (millis()-tempsvie<1000 && millis()-tempsvie>800) {
    cooldown=false;
  } else if (millis()-tempsvie<1200 && millis()-tempsvie>1000) {
    cooldown=true;
  } else if (millis()-tempsvie<1400 && millis()-tempsvie>1200) {
    cooldown=false;
  } else if (millis()-tempsvie<1600 && millis()-tempsvie>1400) {
    cooldown=true;
  } else if (millis()-tempsvie<1800 && millis()-tempsvie>1600) {
    cooldown=false;
  } else if (millis()-tempsvie<2000 && millis()-tempsvie>1800) {
    cooldown=true;
    toucher=false;
  }
}

void keyPressed() {
  if ((key=='d' || key=='D')) {  //Entraîne le déplacement du chasseur vers la droite 
    move[0]=true;
  } 

  if ((key=='q' || key=='Q')) {  //Entraîne le déplacement du chasseur  vers la gauche
    move[1]=true;
  } 

  if (((key==' ' || key==' ') && y<=855 && y==ypre)) {  //Entraîne le saut du chasseur hors de l'eau
    speed=-3.4;
    nplateforme=-1;
    saut=true;
  } else if (((key==' ' || key==' ') && y>855 && y<=height )) {  //Entraîne le saut du chasseur dans l'eau
    saut=false;
    speed=-1;
    plateforme=false;
    saut=true;
  }


  if ((key=='z' || key=='Z') && detectechelle==true && nechelle>-1) {  //Entraîne la montée aux échelles du chasseur
    move[2]=true;
  } else {
    detectechelle=false;
    move[2]=false;
  }

  if ((vie==0) || (viecanard==0 && vie>0)) {  //Permet de recommencer la partie
    if (key=='r' || key=='R') {
      y=850-hauteurchasseur*pheight;
      x=width/2-13;
      ypre=y;
      angle=0.1;
      speed=3;
      gravity=0.1;
      gravityegg=0.1;
      directionchasseur=true;
      noeuf=0;
      nechelle=-1;
      nplateforme=-1;
      cooldown=true;
      viecanard=3;
      vie=3;
      toucher=false;
      for (int i=0; i<oeuf.length; i++) {
        oeuf[0][i]=spawnoeufx;
        oeuf[1][i]=spawnoeufy;
        oeuf[4][i]=-0.5;
        oeuf[6][i]=0;
        oeuf[7][i]=0;
      }
      loop();
    }
  }

  if (vie==0) {  //Permet de quitter le jeu lorsque l'on a perdu
    if (key=='e' || key=='E') {
      exit();
    }
  }

  if (viecanard==0 && vie>0) {  //Permet de quitter le jeu lorsqu'on a gagné
    if (key=='e' || key=='E') {
      exit();
    }
  }

  if ((key=='p' || key=='P') && (vie>0 || viecanard>0) && lecture==true && jeu==true) {  //Permet de mettre en pause le jeu
    lecture=false;
    textSize(75);
    fill(0);
    text("Pause", width/2-110, height/2);
    noLoop();
  } else if ((key=='p' || key=='P') && (vie>0 || viecanard>0) && lecture==false) {
    lecture=true;
    loop();
  }
}


void keyReleased() {

  if ((key=='d' || key=='D')) {  //Arrête le déplacement du chasseur vers la droite
    move[0]=false;
  }

  if ((key=='q' || key=='Q')) {  //Arrête le déplacement du chasseur vers la gauche
    move[1]=false;
  }

  if ((key=='z' || key=='Z')) {
    move[2]=false;
  }
}