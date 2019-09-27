 
PImage img;
int w,h,cpt=0;;
String result="",ch="";
ArrayList <CarOcc> A= new ArrayList();

void setup() {
  frameRate(30);
  size(512, 513); 
  img = loadImage("chat.bmp");  image(img,0,0);
  w=img.width;
  h=img.height;
 print(h,"\t",w);
  img.loadPixels();    
 loadPixels();

 String chaine="";int k=0;
for (int i=0;i<img.width;i++)
  {
    for (int j=0;j<img.height;j++)
    {
         int loc = j*img.width+i;
         float r = red (img.pixels[loc]);
          if (r==255) { chaine+="1"; }
         else { chaine+="0"; }
     }
  }

int i=0,nb=0;
String Str="",ecr=""; 


   String s="",b="";
  while (i<chaine.length())
  {   
       if (nbOcc(i,chaine)<3)
       {  nb++;   s+= chaine.charAt(i); 
            i++;}
       else 
       {
         if ( nb>0)
         { if (i!=chaine.length()) {CarOcc x=new CarOcc(); x.car=s; x.occ=nb; x.rep=false; A.add(x);     s=""; }}
         nb=0; 
         CarOcc x=new CarOcc();
          x.car=str(chaine.charAt(i));  x.rep=true; x.occ=nbOcc(i,chaine); A.add(x); i=i+nbOcc(i,chaine);
         
       }
         if (i==chaine.length())  if (nb>0) 
         {  CarOcc x=new CarOcc();   
            x.car=s; x.occ=nb; x.rep=false; A.add(x); 
         }
       }
  
     CompressionRLE(A); print("terminé");
 
}


 int nbOcc(int i,String ch)
 { int nb=1,j=i+1; 
    boolean b=true;
       while( (j<ch.length() ) && (b==true))
       {   if (ch.charAt(i)==ch.charAt(j))
            {  j++;  nb++; }
              else 
              b=false;
            
       }
  return nb;
 }
 void CompressionRLE( ArrayList <CarOcc> a)
 { int i=0,f;  PrintWriter op1 = createWriter("file2.txt"); String S,h;  String fichier=""; 
      op1.print(hex(img.width,3)); op1.flush();  op1.print(" "); op1.flush(); op1.println(hex(img.height,3)); op1.flush(); print("ableau=",a.size());
       while (i<a.size())
       {  print("taille occ=",a.get(i).occ);
           if(a.get(i).rep==true) //il y a répétition
           { 
             if(a.get(i).occ<=32767)
                { 
                  h=hex(a.get(i).occ+32768,4);  
                  if (Integer.parseInt(a.get(i).car)==1) S=h+hex(255,2);  else S=h+hex(Integer.parseInt(a.get(i).car),2); 
                   fichier+=S;                
                   
                  
                }
                else //il n'y a pas de répétition
                { 
                     f=a.get(i).occ; int x=32767; 
                     while (f>=x)
                     {h=hex(x+32768,4); 
                      
                         if (Integer.parseInt(a.get(i).car)==1) S=h+hex(255,2);  else S=h+hex(Integer.parseInt(a.get(i).car),2);  fichier+=S;
                        f=f-x;
                       
                     }
                     if (f<x)  
                     { h=hex(f+32768,4); 
                          if (Integer.parseInt(a.get(i).car)==1) S=h+hex(255,2);  else S=h+hex(Integer.parseInt(a.get(i).car),2); fichier+=S;
                         f-=x;
                  
                         
                     }
                }
             
           }
           else //il n'y a pas de rep
           { h=hex(a.get(i).occ,4);   int b; String c="";
              for(b=0; b<a.get(i).car.length(); b++)
              {   
                  String n=hex(int(str(a.get(i).car.charAt(b))),2); 
                  if (a.get(i).car.charAt(b)=='1') {n=hex(255,2);  }    
                    
                   c+=n;
            
               }
           
                    
                S=h+c; fichier+=S; 
             
          
             
             
            }
           
         i++;
         
       }
       
      op1.print(fichier); op1.flush();
   
   
   
 }


 public class CarOcc
 { String car; int occ; boolean rep;
   
    CarOcc(String c, int o,boolean b)
     {
       car=c; occ=o; rep=b;
     }
    CarOcc()
    {
    }
   
 }
 
 