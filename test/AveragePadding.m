function temp = AveragePadding(im)

padding=1;

[height , width] = size(im);

temp = ones(height + padding * 2, width + padding * 2);
temp(padding+1 : padding+height , padding+1 : padding+width) = im;  %将图像放在中心



%左
for i= padding+1 : padding+height
    for j= 1:padding
        tmp = temp( max(padding+1 ,i-5) : min(padding+height ,i+5) , padding + 1 );
        temp(i,j) = mean(tmp);
    end

%右
    for j= padding+width+1 : width + padding * 2
        tmp = temp( max(padding+1 ,i-5) : min(padding+height ,i+5) , padding+width );
        temp(i,j) = mean(tmp);
    end
end

%上
for j=1:width + padding * 2
     for i = 1:padding
         tmp = temp(padding + 1 , max(1 ,j-5) : min(width + padding * 2 ,j+5));
         temp(i,j) = mean(tmp);
     end
 %下
     for i = padding+height+1 : height + padding * 2
         tmp = temp(padding+height ,  max(1 ,j-5) : min(width + padding * 2 ,j+5));
         temp(i,j) = mean(tmp);
     end
end


    