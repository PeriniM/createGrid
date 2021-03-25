class CustomShape {
    constructor(red, green, blue, alpha){
      this.indicesX = [];
      this.indicesY = [];
      this.red = red;
      this.green = green;
      this.blue = blue;
      this.alpha = alpha;
      this.closed = false;
      this.virtual = false;
    }
  
    create(indices){
      this.indicesX.push(indices[0]);
      this.indicesY.push(indices[1]);
      this.virtual=false;
    }
  
    createVirtual(indices){
      this.indicesX.push(indices[0]);
      this.indicesY.push(indices[1]);
      this.virtual=true;
    }
  
    show(lineX, lineY){
      stroke('black');
      strokeWeight(2);
      fill(this.red, this.green, this.blue, this.alpha);
      beginShape();
      for (let i = 0; i<this.indicesX.length; i++){
        vertex(lineX[this.indicesX[i]], lineY[this.indicesY[i]]);
      }
      if (this.closed==true){
        endShape(CLOSE);
      }
      else{
        endShape();
      }
      if (this.virtual==true){
        this.indicesX.pop();
        this.indicesY.pop();
      }
    }
  }
  