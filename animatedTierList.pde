String[] tierClasses = {
  "S", "A", "B", "C", "D", "E", "F"
};

color[] tierColors = {
  #FF7F7F, #FFBF7F, #FEFE7E, #7FFE7F, #7EBEFE, #7F7FFF, #FE7EFE
};

float[] tierTargets = {59.8, 159.8, 259.8, 359.8, 459.8, 559.8, 659.8}; 
float[] boxYs; 
float RANK_INTERP = 0.1; 

int currentTier = 0; 
int tierDelay = 10000; 
int lastUpdateTime = 0; 

String[] tierTexts = {
  "Top Tier", "High Tier", "Medium Tier", "Low Tier", "Subpar", "Bad Tier", "Worst Tier"
};

void setup(){
  noStroke();
  size(900, 722);
  boxYs = new float[tierClasses.length];
}

void draw(){
  background(#191919);
  
  if (currentTier < tierClasses.length) {
    if (millis() - lastUpdateTime > tierDelay) {
      lastUpdateTime = millis(); 
      currentTier++; 
    }
  }

  for (int i = 0; i < currentTier; i++) {
    boxYs[i] = linIndex(boxYs[i], tierTargets[i], RANK_INTERP);
  }
  
  drawTierHolders(); 
  tierBoxes();       
  drawTiers();       
}

void drawTiers(){
  textAlign(CENTER, CENTER);
  textSize(19);
  
  for (int i = 0; i < tierClasses.length; i++) {
    fill(tierColors[i]);
    rect(50, 100 * i + 50, 90.15, 94.6); 
    
    fill(255);
    text(tierClasses[i], 25, 100 * i + 90); 
  }
}

void tierBoxes(){
  for (int i = 0; i < currentTier; i++) {
    fill(tierColors[i]); 
    rect(311.5, boxYs[i], 315.35, 78.85); 
    
    fill(255);
    textSize(30); 
    textAlign(CENTER, CENTER); 
    text(tierTexts[i], 311.5 + 157.675, boxYs[i] + 39.425); 
  }
}

void drawTierHolders(){
  fill(#1A1A1A);
  for (int i = 0; i < tierClasses.length; i++) {
    rect(160, 100 * i + 50, 600, 94.6); 
  }
}

float linIndex(float current_value, float target_value, float interp_rate){
  return current_value * (1 - interp_rate) + target_value * interp_rate;
}
