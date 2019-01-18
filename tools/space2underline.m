function x = space2underline(x)
len=length(x);
for i=1:len
    if(x(i) == ' ')
        x(i)='_';
    end
end