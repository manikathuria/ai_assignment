readfacts:-
    open('tags.txt',read,In),
    repeat,
    read_line_to_codes(In,X), 
    writef(X),nl,
    X=end_of_file,!,
    nl,
    close(In).
