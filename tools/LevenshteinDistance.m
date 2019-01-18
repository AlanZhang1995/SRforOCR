%参考http://www.cnblogs.com/biyeymyhjob/archive/2012/09/28/2707343.html
function dis = LevenshteinDistance(str1,str2)  
height=length(str1);  %max1
width=length(str2);   %max2
if(str2==-1) 
    width=0;
end
ptr=zeros(height+1,width+1);
%if i == 0 且 j == 0，edit(i, j) = 0
%if i == 0 且 j > 0，edit(i, j) = j
for i=1:height+1
    ptr(i,1)=i-1;
end
%if i > 0 且j == 0，edit(i, j) = i
for i=1:width+1
    ptr(1,i)=i-1;
end
%if 是1 <= i <m 且 1<= j <n ，edit(i, j) == min{ edit(i-1, j) + 1, edit(i, j-1) + 1, edit(i-1, j-1) + f(i, j) }，当第一个字符串的第i个字符不等于第二个字符串的第j个字符时，f(i, j) = 1；否则，f(i, j) = 0。
for i=2:height+1
    for j=2:width+1
        if(str1(i-1)==str2(j-1))
            f=0;
        else
            f=1;
        end
        ptr(i,j)=min( [ptr(i-1,j)+1 , ptr(i,j-1)+1 , ptr(i-1,j-1)+f] );
    end
end
%取出最右下角元素，即为文本编辑距离
% ptr
dis=ptr(height+1,width+1);