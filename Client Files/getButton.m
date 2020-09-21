function str=getButton(x,y)
% if and(and(x>512,x<617),and(y>58,y<109))
%     str='Unread';
% elseif and(and(x>250,x<339),and(y>0,y<45))
%     str='Login';
% elseif and(and(x>400,x<488),and(y>0,y<43))
%     str='Leave';
% elseif and(and(x>539,x<640),and(y>0,y<45))
%     str='Exit';
% elseif and(and(x>347,x<447),and(y>57,y<108))
%     str='Send';
% elseif and(and(x>439,x<581),and(y>121,y<180))
%     str='Chat';
% else
%     str='None';
% end
if and(and(x>550,x<640),and(y>0,y<51))
    str='Login';
elseif and(and(x>550,x<640),and(y>58,y<105))
    str='Leave';
elseif and(and(x>550,x<640),and(y>442,y<480))
    str='Exit';
elseif and(and(x>347,x<447),and(y>57,y<108))
    str='Send';
elseif and(and(x>0,x<91),and(y>0,y<52))
    str='SID';
elseif and(and(x>89,x<550),and(y>10,y<52))
    str='Save';
else
    str='None';
end
return
