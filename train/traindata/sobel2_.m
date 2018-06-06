function uSobel = sobel2_(imag)
% imag = rgb2gray(imag);        %ת��Ϊ�Ҷ�ͼ
[high,width] = size(imag);   % ���ͼ��ĸ߶ȺͿ��
F2 = double(imag);        
U = double(imag);       
uSobel = imag;
for i = 2:high - 1   %sobel��Ե���
    for j = 2:width - 1
        Gx = (U(i+1,j-1) + 2*U(i+1,j) + F2(i+1,j+1)) - (U(i-1,j-1) + 2*U(i-1,j) + F2(i-1,j+1));
        Gy = (U(i-1,j+1) + 2*U(i,j+1) + F2(i+1,j+1)) - (U(i-1,j-1) + 2*U(i,j-1) + F2(i+1,j-1));
        uSobel(i,j) = sqrt(Gx^2 + Gy^2); 
    end
end

for i = 1 : high %��Ե��0(set edge to 0)
    uSobel(i,1) = 0;
    uSobel(i,width) = 0;
end

for j = 1 : width
    uSobel(1,j) = 0;
    uSobel(high,j) = 0;
end

for i = 1:high  %��ֹ���ֲ�����loss����(avoid 0 loss area)
    for j = 1:width
        if(uSobel(i,j) == 0)   
            uSobel(i,j)=1; 
        end
    end
end