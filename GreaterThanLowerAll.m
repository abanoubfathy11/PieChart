function  s  = GreaterThanLowerAll( arr,val,MaxWidth )
out=0;
len=length(arr);

if max(arr) == val
    out=MaxWidth-max(arr);
  
else
    
    for i=1:len
        if arr(i) <= val
             arr(i)=999999;
        end
    end
    arrArrange=sort(arr);
    out=arrArrange(1)-val;

end
s=out-20;
end

