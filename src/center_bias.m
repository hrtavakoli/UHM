function [ map_new ] = center_bias( map )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[x, y, c] = size(map);

mx = round(x / 2);
my = round(y / 2);

map_new = map;
for i = 1:x
    for j= 1:y
        map_new(i,j) = map(i,j)* exp(-floor(sqrt( (i - mx)^2 + (j - my)^2))/(max(x,y)));
    end
end

end
