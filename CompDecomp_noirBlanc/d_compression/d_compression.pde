
int w,h; String chaine; PImage img; 
void setup()
{
  size(500,500);  surface.setResizable(true); frameRate(20);   
 
}
void draw()
{   String [] File=loadStrings("file2.txt"); 
  String [] t=split(File[0]," ");
  w=unhex(t[0]); 
   h=unhex(t[1]); 
  int i=0,cpt,taille=0,code=60,nb; String chaine="",tmp="";
  
  
 
 while(i<File[1].length())
 { cpt=0; tmp="";
   while(cpt<4 && i<File[1].length()) //lire 4car de taille
   { if (File[1].charAt(i)!='$') tmp+=(File[1].charAt(i)); i++; cpt++; } 
         if (tmp!="") taille=unhex(tmp); 
             tmp=""; 
    if (taille>32768) //il y a rep de l'octet suivant
    { cpt=0; taille-=32768;
      while(cpt<2 && i<File[1].length()) //lire deux caractére du pixel qui se répète 
      {
        tmp+=(File[1].charAt(i)); i++; cpt++; 
      }
      code=unhex(tmp); 
      for(nb=0; nb<taille; nb++) {chaine+=Coder(code);  }
      tmp="";  
      
    }
 else //il y a pas rep
 {   nb=0; 
   
    while(nb<taille && i<File[1].length())
    {   cpt=0;  
      while(cpt<2 && i<File[1].length()) //lire de caractére du pixel qui se répète 
      {  if(File[1].charAt(i)!='$')
        {tmp+=(File[1].charAt(i)); i++; cpt++;}
      } 
    code=unhex(tmp); String k=Coder(code);   chaine+=k;  tmp="";   
    nb++;
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
         int loc = j*w+i; color c;
      
          if (chaine.charAt(l)=='1')
         {
           c = color (255,255,255);
         }
         else
         {
           c = color (0,0,0);
         }
        
         img.pixels[loc] = c;
         l++;
    }
  }  image(img,0,0); img.updatePixels();      
}
  


String Coder(int ch)
{
   if (ch==255) return "1";
   else return "0";
   
  
  
}