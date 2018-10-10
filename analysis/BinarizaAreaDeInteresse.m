
%Esta fun��o recebe a imagem original em RGB e o tipo da carca�a e retorna
%a imagem bin�ria correspondente a �rea de interesse da carca�a

function [imagemBinaria,imagemOriginalRGBSemGancho]=BinarizaAreaDeInteresse(imagemOriginalRGB,tipoCarcaca)

%Gira a imagem conforme necess�rio
if(size(imagemOriginalRGB,1)) < (size(imagemOriginalRGB,2))
    imagemOriginalRGB = imrotate( imagemOriginalRGB, 90 );
end 

% Recorte da imagem na �rea de interesse
imagemOriginalRGB = imcrop( imagemOriginalRGB, [ 415, 415, 1600, 2800 ] );

% Equaliza a imagem ao tornar branca as tonalidades de vermelho 
imagemEqualizada=EqualizaImagem(imagemOriginalRGB);

%Transforma��o em escala de cinza
imagemCinza = rgb2gray( imagemEqualizada );

se = strel( 'disk', 30 );

% Reconstru��o da imagem
ImagemCorroida = imerode( imagemCinza, se );
imagemReconst = imreconstruct( ImagemCorroida, imagemCinza );
imagemDilatada = imdilate( imagemReconst, se );
imagemDilatadaReconst = imreconstruct( imcomplement( imagemDilatada ), imcomplement( imagemReconst ) );
imagemDilatadaReconst = imcomplement( imagemDilatadaReconst );

imagemBinaria = imbinarize( imagemDilatadaReconst );

%Preenche os buracos da imagem bin�ria
imagemBinaria = imfill(imagemBinaria,'holes');

if tipoCarcaca=="Dorsal"
    
    %Elimina o gancho atrav�s do qual a carca�a est� pendurada
    [imagemBinaria,imagemOriginalRGBSemGancho] = EliminaGancho(imagemBinaria,imagemOriginalRGB,25);
    
    %Elimina o pesco�o da carca�a Dorsal
    imagemBinaria=EliminaPescocoDorsal(imagemBinaria);
elseif tipoCarcaca=="Lateral"
    
    %Elimina o gancho atrav�s do qual a carca�a est� pendurada
    [imagemBinaria,imagemOriginalRGBSemGancho] = EliminaGancho(imagemBinaria,imagemOriginalRGB,37);
    
    %Elimina o pesco�o da carca�a Lateral
    imagemBinaria=EliminaPescocoLateral(imagemBinaria);
    
    imagemBinaria=EliminaCaudaLateral(imagemBinaria);
end

