class CustomShape {
  /*
    Define a CustomShape object needed for the creation of the shapes on the grid.
    The methods allow to add points to the shape, render it on the grid and perform
    some actions when it is clicked and hovered.
    The vertices are not stored using absolute coordinates but referencing
    the indeces of the parent grid.
  */

    constructor(shape_type, red, green, blue, alpha){
      this.indicesX = [];
      this.indicesY = [];
      this.red = red;
      this.green = green;
      this.blue = blue;
      this.alpha = alpha;
      this.closed = false;
      this.virtual = false;
      this.shape_type = shape_type;
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
  
    show(lineX, lineY, toggle){
      stroke('black');
      strokeWeight(2);
      if (toggle=='remove'){
        fill(255,255,255,255);
        fill(255,0,0,150);
      }
      else if (toggle=='select'){
        fill(255,255,255,255);
        fill(this.red, this.green, this.blue,150);
      }
      else{
        fill(this.red, this.green, this.blue, this.alpha);
        
      }
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
    isInside(indices){
      let inside = false;
      let x = indices[0];
      let y = indices[1];
      for (let i = 0, j = this.indicesX.length - 1; i < this.indicesX.length; j = i++) {
        let xi = this.indicesX[i], yi = this.indicesY[i];
        let xj = this.indicesX[j], yj = this.indicesY[j];
        let intersect = ((yi > y) != (yj > y))
          && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
        if (intersect) inside = !inside;
      }
      return inside;
    }
    removeLast(){
      this.indicesX.pop();
      this.indicesY.pop();
    }
    changeColor(color){
      this.red = color[0];
      this.green = color[1];
      this.blue = color[2];
      this.alpha = color[3];
    }
  }
  