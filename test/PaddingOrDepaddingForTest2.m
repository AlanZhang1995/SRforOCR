function [temp]=PaddingOrDepaddingForTest2(im,flag) %flag=1 ==>padding   flag=0 ==>depadding

%% �����趨
padding = 10;


%% flag=1 ==>padding   flag=0 ==>depadding
if flag
    temp=im;
    for i=1:padding
        temp=AveragePadding(temp); %ÿһ��ѭ���������һȦ
    end
else
    %depadding
    [height , width] = size(im);
    temp = im(padding+1 : height - padding , padding+1 : width - padding);
end
    


            
            