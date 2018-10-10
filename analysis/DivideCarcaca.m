
%Esta fun��o retorna as coordenadas y de pontos que dividem horizontalmente a carca�a em partes iguais 

function pontosDeDivisao=DivideCarcaca(imagemBinaria,numeroDePartes)

%Detecta todos os pontos extremos da carca�a
propsDorsal=regionprops(imagemBinaria,'extrema');

%Concatena os pontos extremos
extremos=cat(1,propsDorsal.Extrema);

%Calcula qual desses pontos extremos � o m�ximo
[pontoMax(1,2),indice]=min(extremos(:,2));
pontoMax(1,1)=extremos(indice,1);
pontoMax=round(pontoMax);

%Calcula qual desses pontos extremos � o m�nimo
[pontoMin(1,2),indice]=max(extremos(:,2));
pontoMin(1,1)=extremos(indice,1);
pontoMin=round(pontoMin);

%Calcula dist�ncia entre as extremidades verticais da carca�a
distanciaMaxMin = pontoMin(1,2) - pontoMax(1,2);

%Intervalo de cada regi�o conforme o n�mero de partes a ser dividido
intervalo=distanciaMaxMin/numeroDePartes;

%Inicializa o vetor que guarda a coordenada y dos pontos de divis�o
pontosDeDivisao=zeros((numeroDePartes-1),2);

%Preenche o vetor que guarda os pontos de divis�es
for i=1:(numeroDePartes-1)
   
   pontosDeDivisao(i,:)=[pontoMax(1,1) pontoMax(1,2)+i*intervalo];
end

%Arredonda os valores dos pontos de divis�o para que possam ser usados como �ndices de matrizes
pontosDeDivisao=round(pontosDeDivisao);

