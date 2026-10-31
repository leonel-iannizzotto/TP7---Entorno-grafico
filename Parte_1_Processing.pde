int rectX, rectY;   
int ancho = 90;  
int nivel = 0;

void setup()
{
size(910,600);
background(0,0,50);
frameRate(60);
}

void draw()
{
textSize(60);
fill(255);
text ("ENTRADAS", 90, 200);
text ("SALIDAS", 90, 400);

int i;
for (i=0; i<=1; i++)
{
stroke(255);
fill(255);
rect(505+(i*220),140,ancho,ancho);
ellipse(550+(i*220), 375, ancho, ancho);
}

}
