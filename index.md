## Sobre mi

Nombre: Jaime Andres Vargas

Estudiante de ingeniería de sistemas y computación de la universidad nacional de colombia. He desarrollado proyectos en diferentes materias de la universidad, he competido en las maratones de programación, me gusta la parte de software, desarrollar aplicaciones ya sean móviles o web. 

Cuando no programo me gusta leer, escuchar música o tocar el piano o la guitarra , también me gusta el mundo del cine viendo películas interesantes.

## Proyecto + Taller ( Indagacion e implementacion del algoritmo warnock)

la implementacion fue desarrollada en processing y se puede encontrar en el siguiente link [ Codigo implementacion](https://github.com/jaavargasar/jaavargasar.github.io/blob/master/warnock_v3/warnock_v3.pde)

## 1 Que se quiere hacer ?

El objetivo central , es poder entender e implementar el algoritmo warnock para renderizar imágenes compuestas por figuras geométricas. Se pretende pasar de imágenes con vectores a imágenes con píxeles, la razón por la que escogí el algoritmo warnock es que en cierta medida aplica un algoritmo simple pero poderoso como lo es el “divide y vencerás”, que a su vez puede que no sea el más eficiente entre la variedad de opciones que existen, pero nos permite solucionar el problema de una manera elegante.

## 2  Estado del arte

El algoritmo de warnock hace parte de los algoritmos de visibilidad y su enfoque esta en renderizar la imagen, dado que tambien existen metodos de ray-tracing. Este algoritmo pertenece a los HSR (Hidden surface removal algorithms), de los cuales buscan pintar imagenes que solo nos permiten ver lo visible sin importar si están entrecruzadas o superpuestas los objetos geométricos que se encuentran en ella. Existen otra variedad de algoritmos como, el algoritmo del pintor, BSP (Binary Space Partitioning), el Z-buffer, el ray-tracing para superficies poliédricas y cuádricas, algoritmo watkins o conocido como el barrido incremental.

## 3 Métodos

El algoritmo warnock es un algoritmo que hace uso del famoso “divide y vencerás”, aplica métodos recursivos para identificar casos bases y llegado a ese punto renderiza o pinta en la pantalla el objeto o en este caso el polígono que pretendemos pasar a pixeles,  existen cuatro posibles relaciones entre polígonos y elementos de área, estos son:

![image-title-here](/pictures/1.png){:class="img-responsive"}

Como se puede ver en la figura 1, en el primer caso nuestro marco de subdivisión debe contener completamente al objeto, en el caso 2 la intersección se ve cuando contiene parte del objeto, en el caso tres el marco no contiene absolutamente nada y en el último escenario el marco se encuentra completamente dentro del objeto o polígono.

El algoritmo de warnock es una de las soluciones que se encuentran en el enfoque de “visibilidad”  y su resultado que son rectángulos(bloques) de píxeles, se encarga de dar una mejor visibilidad por cada respectivo cuadrante que llegó a subdividirse, a su vez este se considera que tiene precisión de imagen, dado a que se calcula el polígono visible en cada bloque.

Para usar este algoritmo inicialmente necesitamos dos parámetros, una lista de polígonos y la vista inicial que comprende todos los polígonos que se pueden encontrar en el “canvas”. Después de haber recibido los parámetros el algoritmo mira si es posible darle solución al marco de vista que se está enfocando actualmente dado a los casos base, si es así entonces este pintara en pantalla los píxeles de la imagen, en caso contrario se dividirá el rectángulo actual en cuatro partes y cada una de ellas se le aplica el algoritmo warnock de nuevo, de manera recursiva.

![image-title-here](/pictures/2.png){:class="img-responsive"}


El algoritmo warnock hace parte de los algoritmos de “Hidden Surface Removal (HSR) “ , son los algoritmos que nos permite conocer qué vistas y superficies son visibles de una imagen llena de polígonos, sin importar la manera en que estos estén superpuestos o cruzados unos a otros. Este algoritmo es de complejidad O(np), siendo n el número de polígonos que encontramos en su lista  y p el número de píxeles del canvas principal o conocido como el “viewport”. Cabe resaltar que en el peor de los casos el algoritmo tendrá que dividir el viewport hasta llegar a un área del tamaño de un pixel.

Ya conociendo las posibles relaciones dadas en la figura 1, para decidir si debemos renderizar la imagen contenida en el marco o si debemos seguir subdividiendo en cuatro partes iguales tenemos los siguientes casos:

1. Encontramos que en el área actual, todos los polígonos son disjuntos, esto es que el área se encuentra vacía y ningún polígono de la lista se puede notar dentro de ella

![image-title-here](/pictures/3.png){:class="img-responsive"}

2. Solo existe un polígono contenido dentro del marco en su totalidad o en una parte, ya sea que este sea intersecante con el marco

![image-title-here](/pictures/4.png){:class="img-responsive"}

3. Hay un solo polígono que se encuentra completamente en el área y es circundante, esto es que la ocupa en su totalidad.

![image-title-here](/pictures/5.png){:class="img-responsive"}

4. Hay varios polígonos intersectados, solo que unos están encimas de otros, en este caso se mira el eje z y los cuatro vértices que forman el marco y al cual se le quiere dar visibilidad, en este caso se subdivide el área.

![image-title-here](/pictures/6.png){:class="img-responsive"}


![image-title-here](/pictures/7.png){:class="img-responsive"}

Dado al caso que lleguemos al área del tamaño de un pixel, debemos pintar el color que se encuentra en el centro de dicho pixel.

![image-title-here](/pictures/8.png){:class="img-responsive"}

## 4 Implementación y resultados.

Se implementó el algoritmo de warnock en processing, con la intención de poder ver como este funcionaba y entenderlo en su mayor profundidad. En un comienzo la idea era poder importar una imagen externa en cualquier tipo de formato y a está poder aplicarle el algoritmo, pero el problema era que en estas imágenes se identificaban cantidad de píxeles diferentes, dado a que la imagen no tenía las mejores calidades y el algoritmo se demoraba más en dar el resultado, entonces se creo la misma imagen en procesing, donde se puede diferenciar adecuadamente los pixeles en la imagen dada y a está poder aplicarle el algoritmo.

La idea del algoritmo warnock es poder renderizar una imagen vectorial a una imagen hecha por pixeles, dado a que esta se tiene que mostrar en la pantalla. Pero la implementación que se hizo en processing la imagen ya estaba dada y no se renderizo, entonces el objetivo fue poder aplicar el algoritmo y entender cómo este funcionaba y se subdividió cada vez que se llamaba en la recursión. La implementación fue la idea de “divide y vencerás” tomando como clave cuatro coordenadas (x1,y1) para la altura y (x2,y2) para el ancho.

![image-title-here](/pictures/9.png){:class="img-responsive"}

Dado que la imagen ya fue dada y no se renderizo , no teníamos las entradas que usualmente se le dan al algoritmo como lo son la lista de polígonos y el viewport ; En este caso solo teníamos el viewport, pero usamos los píxeles de la imagen para poder identificar los colores que había en ella y así poder implementar el algoritmo.

![image-title-here](/pictures/10.png){:class="img-responsive"}



![image-title-here](/pictures/11.png){:class="img-responsive"}

## Referencias


1. University of Waterloo. Computer Graphics Lab. Warnocks’ Algorithm, desde http://medialab.di.unipi.it/web/IUM/Waterloo/node68.html

2. herpes. Algoritmo de warnock, desde http://www16.wikipedes.eu/03500965/AlgoritmoDeWarnock

3. Computación gráfica. Eduardo Fernandez, desde https://www.fing.edu.uy/inco/cursos/compgraf/Clases/2012/13-Superficies%20Visibles.pdf

4. Superficies visibles, Prof Fernandez(Universidad de la republica de Uruguay), desde https://esaulgd.files.wordpress.com/2012/10/07_superficiesvisibles_p2.pdf

5. Visualizacion y realismo, Carlos Ureñas Almagro, Curso 2011-12, desde https://lsi.ugr.es/curena/doce/vr/transpa/11-12/vr-c02-impr.pdf






<iframe src="https://drive.google.com/file/d/0Bwq59q6lDEYZcG9lTWxMYW5KZFU/preview" width="100%" height="1000em"></iframe>




