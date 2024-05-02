function  [K,f,d] = preprocessor
include_flags;

%input_file_1ele;
input_file_16ele;


% generate ID array and LM array 
d = setup_ID_LM(d);