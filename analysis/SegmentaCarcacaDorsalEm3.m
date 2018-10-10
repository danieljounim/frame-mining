
%Esta fun��o implementa um algoritmo que segmenta uma imagem de carca�a dorsal em tr�s outras

function [imagemSuperior,imagemInferior,imagemDoMeio]=SegmentaCarcacaDorsalEm3(imagemDorsalBinaria)

%%%%%%% A IMAGEM SER� DIVIDIDA EM REGI�ES A SEREM EXPLORADAS
%%%%%%% NA PROCURA POR FAIXAS DE MAIOR E MENOR LARGURA PARA QUE A IMAGEM
%%%%%%% POSSA SER DIVIDIDA EM 3

%%% DIVIS�O EM 3 PARTES, DETECTA DUAS LINHAS HORIZONTAIS %%%

%Divide a carca�a em 4 partes
regioes=DivideCarcaca(imagemDorsalBinaria,4);

%Define a 2� regi�o (contando de cima pra baixo)
segundaRegiao=[regioes(1,2) regioes(2,2)];

%Arredonda
segundaRegiao=round(segundaRegiao);

%Explora a segunda regi�o a procura do ponto mais largo
linhaMaisLarga1=DetectaLinhaMaisLarga(imagemDorsalBinaria,segundaRegiao);

%Define a 3� regi�o (contando de cima pra baixo)
terceiraRegiao=[regioes(2,2) regioes(3,2)];

%Arredonda
terceiraRegiao=round(terceiraRegiao);

%Explora a segunda regi�o a procura do ponto mais largo
linhaMaisLarga2=DetectaLinhaMaisLarga(imagemDorsalBinaria,terceiraRegiao);

%As alturas de corte s�o definidas igualando-as a coordenada y das linhas mais largas 1 e 2
alturaDorsal1=linhaMaisLarga1(1,2);
alturaDorsal2=linhaMaisLarga2(1,2);

%Efetuam-se os cortes da imagem bin�ria e a fun��o retorna cada uma das partes
imagemSuperior=imcrop(imagemDorsalBinaria,[0,0,size(imagemDorsalBinaria,2),alturaDorsal1]);
imagemDoMeio=imcrop(imagemDorsalBinaria,[0,alturaDorsal1,size(imagemDorsalBinaria,2),alturaDorsal2 - alturaDorsal1]);
imagemInferior=imcrop(imagemDorsalBinaria,[0,alturaDorsal2,size(imagemDorsalBinaria,2),size(imagemDorsalBinaria,1) - alturaDorsal2]);


