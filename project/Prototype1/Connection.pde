class Connection {
  // ATTRIBUTES
  float actualLenght;
  float maxLength;
  color colorLink;
  // children connected together
  Child[] organisms;

  // METHODS
  Connection(Child org1, Child org2) {
    // set a child to each extremity
    organisms = new Child[2];
    organisms[0] = org1;
    organisms[1] = org2;
  }

  // display the connection
  void display() {
    strokeWeight(1);
    stroke(255, 50);
    // create a line between both children
    line(organisms[0].getPosition().x, organisms[0].getPosition().y, organisms[1].getPosition().x, organisms[1].getPosition().y);
  }

  // NOT USED RIGHT NOW
  // transmit the gene - trace of ENCAPSULATION 
  void transfer() {
    stroke(255);
    for (int i = 0; i < (int) PVector.sub(organisms[0].getPosition(), organisms[1].getPosition()).mag(); i++) {
      line(organisms[0].getPosition().x, organisms[0].getPosition().y, organisms[0].getPosition().x+i, organisms[0].getPosition().y+i);
    }
  }

  // SETTERS AND GETTERS

  // Get the connection
  Child[] getConnectionPoints() {
    return organisms;
  }
}