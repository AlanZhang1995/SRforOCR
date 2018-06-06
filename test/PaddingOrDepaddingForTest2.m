function [temp]=PaddingOrDepaddingForTest2(im,flag) %flag=1 ==>padding   flag=0 ==>depadding

%% 参数设定
padding = 10;


%% flag=1 ==>padding   flag=0 ==>depadding
if flag
    temp=im;
    for i=1:padding
        temp=AveragePadding(temp); %每一次循环在最外层一圈
    end
else
    %depadding
    [height , width] = size(im);
    temp = im(padding+1 : height - padding , padding+1 : width - padding);
end
    


            
            