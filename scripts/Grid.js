class Grid {
    constructor(x0,y0,w,h,sudd){
      this.x0 = x0;
      this.y0 = y0;
      this.w = w;
      this.h = h;
      this.suddx = sudd;
      this.sideLength = this.w/this.suddx;
      this.suddy = Math.ceil(this.h/this.sideLength);
      this.maxSuddx = 50;
      this.minSuddx = 10;
      this.lineX = [];
      this.lineY = [];
    }
    create(){
      for (let i = 0; i<this.suddy+1; i++){
        if (i==this.suddy){
          this.lineY.push(this.y0 + this.h);
        }
        else{
          this.lineY.push(this.y0 + i*this.sideLength);
        }
        
      }
      for (let j = 0; j<this.suddx+1; j++){
        if (j==this.suddx){
          this.lineX.push(this.x0 + this.w);
        }
        else{
          this.lineX.push(this.x0 + j*this.sideLength);
        }
      } 
    }
    update(x0,y0,w,h){
      this.x0 = x0;
      this.y0 = y0;
      this.w = w;
      this.h = h;
      this.sideLength = this.w/this.suddx;
      this.suddy = Math.ceil(this.h/this.sideLength);
      this.lineX = [];
      this.lineY = [];
      this.create();
    }
    show(stroke_color, stroke_weight){
      stroke(stroke_color);
      strokeWeight(stroke_weight);
      for (let i = 0; i<this.lineX.length; i++){
        line(this.lineX[i], this.y0, this.lineX[i], this.y0+this.h);
      }
      for (let j = 0; j<this.lineY.length; j++){
        line(this.x0, this.lineY[j], this.x0+this.w, this.lineY[j]);
      } 
    }
  
    zoom(quantity){
      if (quantity<0 && this.suddx>this.minSuddx){ //zoomIn
        this.suddx--;
      }
      if (quantity>0 && this.suddx<this.maxSuddx){ //zoomOut
        this.suddx++;
      }
      this.sideLength = this.w/this.suddx;
      this.suddy = Math.ceil(this.h/this.sideLength);
      this.update(this.x0,this.y0,this.w,this.h,this.suddx);
    }
  }