// there will be a gap in the center of the Julia set if 
// c does not exist in the Mandelbrot set
PVector c = new PVector(.2,.2);
int iterations = 100;
float cx = 0;
int imgCount = 0;

void setup() {
  size(1920, 1080);
}

void draw() {
  PImage img = new PImage(width, height, RGB);
  cx+=.001;
  c.x = sin(cx); //<>//
  img.loadPixels();
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height; j++) {
      // map takes a range of number and maps them onto another range of numbers
      // takes what proportion 0-i width is, use an equal range from -2-2
      // changes the scale of the value for x and y
      PVector z = new PVector(map(i, 0, width, -1.5, 1.5), map(j, 0, height, -1.5, 1.5));
      int k = 0;
      while (k < iterations && (pow(z.x,2)+pow(z.y,2)) < 4) {
        PVector copy = new PVector(z.x, z.y);
        z.x = pow(copy.x,2) - pow(copy.y,2);
        // the y component of any vector is assumed to be imaginary
        // therefore, the multiplication by i is also assumed
        // therefore, the multiplication by is not required in the equation
        z.y = 2*copy.x*copy.y;
        z.x = z.x + c.x;
        z.y = z.y + c.y;
        ++k;
      }
      //print(c.x);  
      //print(c.y);
      if ((pow(z.x,2)+pow(z.y,2)) < 4) {
        img.pixels[j*width + i] = color(0x00, 0x00, 0xDD);
      } else {
        img.pixels[j*width + i] = color((1578 * k) % 255, (2437 * k) % 255, (1677 * k) % 255);
      }
    }
  }
  img.updatePixels();
  img.save("C:\\Users\\Mitch\\Documents\\Processing\\Julia_Set\\IMAGES\\" + String.format("%04d", imgCount) + ".tif");
  ++imgCount;
  if (cx > TWO_PI)
    exit();
}

/* F(z) = z^2 + c

C = complex value
c = real + imaginary

i = sqrt(-1)
complex Z = a + bi
z^2 = (a+bi)(a+bi)
 = a^2 + abi+abi + bi^2
 = a^2 + 2abi - b^2
    real        imaginary
 = (a^2 - b^2) + (2abi)
 */
