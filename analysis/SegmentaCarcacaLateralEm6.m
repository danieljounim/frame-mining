
%Esta fun��o implementa um algoritmo que segmenta uma imagem de carca�a dorsal em seis outras 

function [imagem1,imagem2,imagem3,imagem4,imagem5,imagem6]=SegmentaCarcacaLateralEm6(imagemLateralBinaria)

%%%%%%% A IMAGEM SER� DIVIDIDA EM REGI�ES A SEREM EXPLORADAS
%%%%%%% NA PROCURA POR FAIXAS DE MAIOR E MENOR LARGURA PARA QUE A IMAGEM
%%%%%%% POSSA SER DIVIDIDA EM 6 PARTES

%%% 1� PARTE : DIVIS�O EM 3 PARTES, DETECTA DUAS LINHAS HORIZONTAIS %%%

%Divide a carca�a em 4 partes
regioes=DivideCarcaca(imagemLateralBinaria,6);

%Define terceira regi�o entre as quatro
terceiraRegiao=[regioes(2,2) regioes(3,2)];

%Arredondamento
terceiraRegiao=round(terceiraRegiao);

%Detecta linha menos larga dentro da terceira regi�o definida acima
linha1=DetectaLinhaMenosLarga(imagemLateralBinaria,terceiraRegiao);

%A altura da linha 2 ser� a m�dia entre as alturas das linhas 2 e 3
linha2(:,2)=round((regioes(4,2) + regioes(5,2))/2);

%A linha 2 � preenchida com suas coordenadas x
k=1;
for i=1:size(imagemLateralBinaria,2)
   
    if imagemLateralBinaria(linha2(1,2),i)==1
       
        linha2(k,1)=i;
        k=k+1;
    end
end

%A linha 2 � preenchida com suas coordenadas y
linha2(:,2)=linha2(1,2);


%%% 2� PARTE : DIVIS�O EM 4 PARTES, DETECTA MAIS UMA LINHA HORIZONTAL %%%

%Redefine o n�mero de regi�es para 5
regioes=DivideCarcaca(imagemLateralBinaria(1:linha1(1,2),1:size(imagemLateralBinaria,2)),5);
   
% %Define a 4� regi�o (contando de cima pra baixo) como a terceira a ser explorada 
 regiao3=[regioes(4,2) linha1(1,2)];
% 
% %Arredonda
 regiao3=round(regiao3);
% 
% %Explora a 4� regi�o a procura do ponto menos largo
 linha3=DetectaLinhaMaisLarga(imagemLateralBinaria,regiao3);

%%% 3� PARTE : DIVIS�O EM 6 PARTES, DETECTA MAIS DUAS LINHAS HORIZONTAIS %%%

%A altura da linha 4 ser� a m�dia entre as alturas das linhas 1 e 2
linha4(:,2)=round((linha1(1,2) + linha2(1,2))/2);

%A linha 4 � preenchida com suas coordenadas x
k=1;
for i=1:size(imagemLateralBinaria,2)
   
    if imagemLateralBinaria(linha4(1,2),i)==1
       
        linha4(k,1)=i;
        k=k+1;
    end
end

%A linha 4 � preenchida com suas coordenadas y
linha4(:,2)=linha4(1,2);

%A altura da linha 5 ser� a m�dia entre as alturas das linhas 1 e 2
larguraImagem=size(imagemLateralBinaria,2);
propsLateral=regionprops(imagemLateralBinaria(:,round(larguraImagem/3):larguraImagem),'extrema');
extremos=cat(1,propsLateral.Extrema);
[pontoMin(1,2),indice]=max(extremos(:,2));
pontoMin(1,1)=extremos(indice,1)+round(size(imagemLateralBinaria,2)/3);
linha5(1,2)=round((linha2(1,2) + pontoMin(1,2))/2);

%A linha 5 � preenchida com suas coordenadas x
k=1;
for i=1:size(imagemLateralBinaria,2)
   
    if imagemLateralBinaria(linha5(1,2),i)==1
       
        linha5(k,1)=i;
        k=k+1;
    end
end

%A linha 5 � preenchida com suas coordenadas y
linha5(:,2)=linha5(1,2);

%Define-se as alturas cujas divis�es ser�o realizadas
alturaDorsal2=linha1(1,2);
alturaDorsal4=linha2(1,2);
alturaDorsal1=linha3(1,2);
alturaDorsal3=linha4(1,2);
alturaDorsal5=linha5(1,2);

%Efetuam-se os cortes da imagem bin�ria e a fun��o retorna cada uma das partes
imagem1=imcrop(imagemLateralBinaria,[0,0,size(imagemLateralBinaria,2),alturaDorsal1]);
imagem2=imcrop(imagemLateralBinaria,[0,alturaDorsal1,size(imagemLateralBinaria,2),alturaDorsal2 - alturaDorsal1]);
imagem3=imcrop(imagemLateralBinaria,[0,alturaDorsal2,size(imagemLateralBinaria,2),alturaDorsal3 - alturaDorsal2]);
imagem4=imcrop(imagemLateralBinaria,[0,alturaDorsal3,size(imagemLateralBinaria,2),alturaDorsal4 - alturaDorsal3]);
imagem5=imcrop(imagemLateralBinaria,[0,alturaDorsal4,size(imagemLateralBinaria,2),alturaDorsal5 - alturaDorsal4]);
imagem6=imcrop(imagemLateralBinaria,[0,alturaDorsal5,size(imagemLateralBinaria,2),size(imagemLateralBinaria,1) - alturaDorsal5]);

