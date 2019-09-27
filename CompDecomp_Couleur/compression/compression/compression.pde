
PImage img;
int w,h,cpt=0;
String result="";
ArrayList <CarOcc> A= new ArrayList();
ArrayList <Rgb> ch=new ArrayList();

void setup() {
  frameRate(30);
  size(512, 513); 
  img = loadImage("plage1.bmp");  image(img,0,0);
  w=img.width;
  h=img.height;

  img.loadPixels();    
 loadPixels();
int k=0; int i;
for ( i=0;i<img.width;i++)
  {
    for (int j=0;j<img.height;j++)
    {   Rgb x=new Rgb();
         int loc = j*img.width+i;
         x.r = int(red (img.pixels[loc]));  x.g= int(green (img.pixels[loc]));  x.b =int( blue (img.pixels[loc]));
       ch.add(x);
     }
  }

print("taille",ch.size());

int nb=0; i=0;
 while (i<ch.size())
  {    CarOcc x=new CarOcc();
       if (nbOcc(i,ch)<3)
       {  nb++;   x.car=ch.get(i); 
       x.occ=0; x.rep=false; A.add(x); 
            i++;}
       else 
       {
         if ( nb>0)
         { if (i!=ch.size()) { CarOcc y=new CarOcc(); Rgb R=new Rgb(-1,-1,-1); 
              y.car=R;  
             y.occ=nb;      y.rep=false; A.add(y); }
         }
         nb=0; 
        if (i<ch.size())
         { x.car=(ch.get(i));  x.rep=true; x.occ=nbOcc(i,ch); A.add(x);   
           i=i+nbOcc(i,ch);}
         
         
         if (i==ch.size())  if (nb>0) 
         {    
            x.car=new Rgb(); x.car.r=0; x.car.g=0; x.car.b=0;  x.occ=nb; x.rep=false; A.add(x); 
         }
       }
}
       i=0;int taille=-1; 
       
       
       //fin Remplir
       int b,j;
   

CompressionRLE(A);
}


 int nbOcc(int i,ArrayList <Rgb> ch)
 { int nb=1,j=i+1; 
    boolean b=true;
       while( (j<ch.size() ) && (b==true))
       {   if ((ch.get(i).r==ch.get(j).r) && ( ch.get(i).g==ch.get(j).g) && (ch.get(i).b==ch.get(j).b))
            {  j++;  nb++; }
              else 
              b=false;
            
       }
  return nb;
 }
 
 
  void CompressionRLE( ArrayList <CarOcc> a)
 { int i=0,f;  PrintWriter op1 = createWriter("code.txt"); String S,h;  String fichier=""; 
      op1.print(hex(img.width,4)); op1.flush();  op1.print(" "); op1.flush(); op1.println(hex(img.height,4)); op1.flush();
       while (i<a.size())
       {  
           if(a.get(i).rep==true) //il y a répétition
           {  String rgb="",R="",G="",B="",s="";
             if(a.get(i).occ<=32767)
                { s="";
                  h=hex(a.get(i).occ+32768,4);  s+=h;
                  R=hex(a.get(i).car.r,2); s+=R; 
                  G=hex(a.get(i).car.g,2); s+=G;
                  B=hex(a.get(i).car.b,2); s+=B;
                 
                  fichier+=s;                
                               
                } 
                else //il n'y a pas de répétition
                { 
                     f=a.get(i).occ; int x=32767; 
                     while (f>=x)
                     {       s="";
                              h=hex(x+32768,4); s+=h;
                              R=hex(a.get(i).car.r,2); s+=R; 
                              G=hex(a.get(i).car.g,2); s+=G;
                              B=hex(a.get(i).car.b,2); s+=B;
                         
                        
                          
                          fichier+=s;
                        f=f-x;
                       
                     }
                     if (f<x)  
                     {s= hex(f+32768,4); 
                             
                              R=hex(a.get(i).car.r,2); s+=R; 
                              G=hex(a.get(i).car.g,2); s+=G;
                              B=hex(a.get(i).car.b,2); s+=B;
                        
                           fichier+=s;
                         f-=x;
                  
                         
                     }
                }
              i++;
           } 
           else //il n'y a pas de rep
           { String s="",R="",G="",B=""; int k,b;
            b=i;
             while(A.get(i).car.r!=-1 && i<A.size()) {i++; }
             h=hex(A.get(i).occ,4);  s+=h;
             for(k=b ; k<i; k++)
             {
                              R=hex(a.get(k).car.r,2); s+=R;  
                              G=hex(a.get(k).car.g,2); s+=G;
                              B=hex(a.get(k).car.b,2); s+=B; 
                           
             } 
            
           fichier+=s; i++; 
           
           
           
            }
           
         
         
       } 
     op1.print(fichier); op1.flush();
   }
       
      
   
   
   
 




 public class CarOcc
 { Rgb car; int occ; boolean rep;
   
    CarOcc(Rgb c, int o,boolean b)
     {
       car=c; occ=o; rep=b;
     }
    CarOcc()
    {
    }
   
 }
 public class Rgb
 { int r,g,b; 
  Rgb(int r1,int g1,int b1)
  {
     r=r1; g=g1; b=b1;
    
  }
  Rgb(){ }
  
   
   
 }
 
 