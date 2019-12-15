function OUT = quan(IN, levels)

    OUT = sign(IN) * levels .* floor( abs(IN)/levels + 1/2 );

end