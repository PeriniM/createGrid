class Point {
    constructor(){
      this.x;
      this.y;
      this.indX;
      this.indY;
    }
  
    snap(x, y, lineY, lineX){
      let sideLength = lineY[1]-lineY[0];
      if (mouseInside()==true){
        for (let i = 0; i<lineX.length; i++){
          let d = lineX[i]-x;
          if (abs(d)<=(sideLength/2)){
            this.x = lineX[i];
            this.indX = i;
            break;
          }
          else if (abs(d)>(sideLength/2) && abs(d)<(sideLength)){
              this.x = lineX[i+1]; 
              this.indX = i+1;
              break;
                  }
        }    
        for (let j = 0; j<lineY.length; j++){
          let d = lineY[j]-y;
          if (abs(d)<=(sideLength/2)){
            this.y = lineY[j];
            this.indY = j;
            break;
          }
          else if (abs(d)>(sideLength/2) && abs(d)<(sideLength)){
              this.y = lineY[j+1]; 
              this.indY = j+1;
              break;
                  }
        }
      } 
    }
  
    getInd(){
      return  [this.indX, this.indY];
    }
  
    show(stroke_color, stroke_weight){
      stroke(stroke_color);
      strokeWeight(stroke_weight);
      if (mouseInside()==true){
        point(this.x, this.y);
      }
    }
  }