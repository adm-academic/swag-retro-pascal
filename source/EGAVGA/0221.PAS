{
Well, I finally managed to get my hands on this book describing an algorithm
for phong shading using only two additions. I'll use � for the dot-product (I
assume you know how to calculate a dot-product :-)

Here goes:

For the intensity at a certain point in a triangle with normals N1, N2 and N3
at the vertices, and with a vector L pointing to the light-source:

                       ax+by+c
  I(x,y) = ������������������������������������
           �(d*x� + e*x*y + f*y� + gx + hy + i)

where:
         a = Lu  � N1
         b = Lu  � N2
         c = Lu  � N3
         d = N1  � N1
         e = 2N1 � N2
         f = N2  � N2
         g = 2N1 � N3
         h = 2N2 � N3
         i = N3  � N3
              L
        Lu = ���
             �L�

I hope the extended characters come thru :-).

This can be simplified (?) to:

  I(x,y) = �5*x� + �4*x*y + �3*y� + �2*x + �1*y + �0 

with:       c 
      �0 = ���
           �i

           2*b*i - c*h
      �1 = �����������
             2*i*�i

           2*a*i - c*g
      �2 = �����������
             2*i*�i

           3*c*h� - 4*c*f*i - 4*b*h*i
      �3 = ��������������������������
                   8*i�*�i 

           3*c*g*h - 2*c*e*i - 2*b*g*i - 2*a*h*i
      �4 = �������������������������������������
                         4*i�*�i

           3*i*g� - 4*c*d*i - 4*a*g*i
      �5 = ��������������������������
                   8*i�*�i


Which can be rewritten as:

  I(x,y) = �5*x� + x(�4*y + �2) + �3*y� + �1*y + �0

Thus needing only 2 additions per pixel.
}
