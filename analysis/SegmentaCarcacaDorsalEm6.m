
%Esta fun��o implementa um algoritmo que segmenta uma imagem de carca�a dorsal em seis outras 

function [imagem1,imagem2,imagem3,imagem4,imagem5,imagem6]=SegmentaCarcacaDorsalEm6(imagemDorsalBinaria)

%%%%%%% A IMAGEM SER� DIVIDIDA EM REGI�ES A SEREM EXPLORADAS
%%%%%%% NA PROCURA POR FAIXAS DE MAIOR E MENOR LARGURA PARA QUE A IMAGEM
%%%%%%% POSSA SER DIVIDIDA EM 6 PARTES

%%% 1� PARTE : DIVIS�O EM 3 PARTES, DETECTA DUAS LINHAS HORIZONTAIS %%%

%Divide a carca�a em 4 partes
regioes=DivideCarcaca(imagemDorsalBinaria,4);

%Define a 2� regi�o (contando de cima pra baixo) como primeira a ser explorada
regiao1=[regioes(1,2) regioes(2,2)];

%Arredonda
regiao1=round(regiao1);

%Explora a segunda regi�o a procura do ponto mais largo
linha1=DetectaLinhaMaisLarga(imagemDorsalBinaria,regiao1);

%Define a 3� regi�o (contando de cima pra baixo) como segunda a ser explorada
regiao2=[regioes(2,2) regioes(3,2)];

%Arredonda
regiao2=round(regiao2);

%Explora a segunda regi�o a procura do ponto mais largo
linha2=DetectaLinhaMaisLarga(imagemDorsalBinaria,regiao2);


%%% 2� PARTE : DIVIS�O EM 4 PARTES, DETECTA MAIS UMA LINHA HORIZONTAL %%%

%Redefine o n�mero de regi�es para 9
regioes=DivideCarcaca(imagemDorsalBinaria,9);

%Define a 8� regi�o (contando de cima pra baixo) como a terceira a ser explorada 
regiao3=[regioes(7,2) regioes(8,2)];

%Arredonda
regiao3=round(regiao3);

%Explora a oitava regi�o a procura do ponto menos largo
linha3=DetectaLinhaMenosLarga(imagemDorsalBinaria,regiao3);

%%% 3� PARTE : DIVIS�O EM 6 PARTES, DETECTA MAIS DUAS LINHAS HORIZONTAIS %%%

%Define uma nova regi�o entre as linhas mais largas
regiao4=[linha1(1,2) linha2(1,2)];

%Arredondamento
regiao4=round(regiao4);

%Detecta a linha menos larga dentro da regiao 5
linha4=DetectaLinhaMenosLarga(imagemDorsalBinaria,regiao4);

%A altura da linha 5 ser� a m�dia entre as alturas das linhas 2 e 3
linha5(:,2)=round((linha2(1,2) + linha3(1,2))/2);

%A linha 5 � preenchida com suas coordenadas x
k=1;
for i=1:size(imagemDorsalBinaria,2)
   
    if imagemDorsalBinaria(linha5(1,2),i)==1
       
        linha5(k,1)=i;
        k=k+1;
    end
end

%A linha 2 � preenchida com suas coordenadas y
linha5(:,2)=linha5(1,2);

%Define-se as alturas cujas divis�es ser�o realizadas
alturaDorsal1=linha1(1,2);
alturaDorsal3=linha2(1,2);
alturaDorsal5=linha3(1,2);
alturaDorsal2=linha4(1,2);
alturaDorsal4=linha5(1,2);

%Efetuam-se os cortes da imagem bin�ria e a fun��o retorna cada uma das partes
imagem1=imcrop(imagemDorsalBinaria,[0,0,size(imagemDorsalBinaria,2),alturaDorsal1]);
imagem2=imcrop(imagemDorsalBinaria,[0,alturaDorsal1,size(imagemDorsalBinaria,2),alturaDorsal2 - alturaDorsal1]);
imagem3=imcrop(imagemDorsalBinaria,[0,alturaDorsal2,size(imagemDorsalBinaria,2),alturaDorsal3 - alturaDorsal2]);
imagem4=imcrop(imagemDorsalBinaria,[0,alturaDorsal3,size(imagemDorsalBinaria,2),alturaDorsal4 - alturaDorsal3]);
imagem5=imcrop(imagemDorsalBinaria,[0,alturaDorsal4,size(imagemDorsalBinaria,2),alturaDorsal5 - alturaDorsal4]);
imagem6=imcrop(imagemDorsalBinaria,[0,alturaDorsal5,size(imagemDorsalBinaria,2),size(imagemDorsalBinaria,1) - alturaDorsal5]);



