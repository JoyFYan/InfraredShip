function [ im ] = plotline( x1,y1,x2,y2,im )
%»­Ö±Ïß
dx=x1-x2;
if dx==0
    if(y1<y2)
        im(x1,y1:y2)=im(x1,y1:y2)+1;
    else 
        im(x1,y2:y1)=im(x1,y2:y1)+1;
    end
else
dy=y1-y2;
k=dy/dx;
    if abs(dx)>abs(dy)
        if(x1>x2)
            for i=x2:x1
                im(i,fix((i-x1)*k+y1))=im(i,fix((i-x1)*k+y1))+1;
            end
        else
            for i=x1:x2
                im(i,fix((i-x2)*k+y2))=im(i,fix((i-x2)*k+y2))+1;
            end
        end
    else
        if(y1>y2)
           for i=y2:y1
                im(fix((i-y1)/k+x1),i)=im(fix((i-y1)/k+x1),i)+1;
           end
        else 
            for i=y1:y2
                im(fix((i-y2)/k+x2),i)=im(fix((i-y2)/k+x2),i)+1;
            end
        end
    end
end
