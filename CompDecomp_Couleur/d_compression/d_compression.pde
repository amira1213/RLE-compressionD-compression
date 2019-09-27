ArrayList <Rgb> A=new ArrayList();
int w,h; String chaine; PImage img; 
void setup()
{
  size(550,550);  surface.setResizable(true); frameRate(20);   
 
}
void draw()
{   String [] File=loadStrings("code.txt"); 
  String [] t=split(File[0]," ");
  w=unhex(t[0]); 
   h=unhex(t[1]); 
  int i=0,cpt,taille=0,code=60,nb; String chaine="",tmp="";
  
  

 while(i<File[1].length())
 { cpt=0; tmp="";
   while(cpt<4 && i<File[1].length()) //lire 4car de taille
   {  tmp+=(File[1].charAt(i)); i++; cpt++; } 
         if (tmp!="") taille=int (unhex(tmp)); 
             tmp=""; 
    if (taille>32768) //il y a rep de l'octet suivant
    {  taille-=32768; int aa=0; int r=-1,g=-1,b=-1; Rgb rg=new Rgb(); 
     for(int am=0; am<3; am++)
     { cpt=0;  tmp="";
      while(cpt<2 && i<File[1].length()) //lire deux caractére du pixel qui se répète 
      {
        tmp+=(File[1].charAt(i)); i++; cpt++; 
      }
     if (aa==0) {r=int(unhex(tmp));  }
     if (aa==1) {g=int(unhex(tmp));   }
     if (aa==2) {b=int(unhex(tmp)); } aa++;
     if (aa==3) rg=new Rgb(r,g,b); 
     }
     for(nb=0; nb<taille; nb++) {A.add(rg);  }
      tmp="";  
      
    }
 else //il y a pas rep
 {   nb=0; int bb=0,r=-1,g=-1,b=-1; 
   
    while(nb<taille && i<File[1].length())
    {   cpt=0;  Rgb rg; tmp="";
     
      while(cpt<2 && i<File[1].length()) //lire de caractére du pixel qui se répète 
      {  
        tmp+=(File[1].charAt(i)); i++; cpt++;
      } 
     if (bb==0) {r=(int)unhex(tmp);  }
     if (bb==1) {g=(int)unhex(tmp);   }
     if (bb==2) {b=(int)unhex(tmp);  }
     bb++;
  
    
    tmp=""; if (bb==3) {bb=0; rg=new Rgb(r,g,b); A.add(rg); nb++; }
    
    } 
 
  }
 
 } 
 
  int l=0; 
  int tai=w*h; 

  
  l=0; 
  PImage img=createImage(w,h,RGB); 
  for ( i=0;i<w;i++)
  {
    for (int j=0;j<h;j++)
    {
         int loc = j*w+i; 
      
        
          color  c = color (A.get(l).r,A.get(l).g,A.get(l).b);    
        
        
         img.pixels[loc] = c;
         l++;
    }
  }  image(img,0,0); img.updatePixels();      
}
  
public class Rgb
{ int r,g,b;
    Rgb(int r1,int g1,int b1)
    {
      r=r1;
      g=g1;
      b=b1;
    }
    Rgb(){  }
   
  
}