
template valid_numbers() autocomplete{
   signal input in[9][9];
   
   signal is_valid[9][9]; // to indicate if all signals are valid for now
   
   signal output out;
   
   for (var i = 0; i < 9; i++){
      for (var j = 0; j < 9; j++){
          is_valid[i][j] <-- in[i][j] <=_(4) 9; 
      }   
   }
   
   var sum_valid = 0;
   for (var i = 0; i < 9; i++){
      for (var j = 0; j < 9; j++){
          sum_valid += is_valid[i][j];
      }   
   } 

   out <-- sum_valid == 81;
}


template different_numbers() autocomplete{
   signal input in[9];
   
   signal is_valid[9][9]; // all possible combinations
   
   // check that every combination of signals is different or they are 0
   for (var i = 0; i < 9; i++){
      for (var j = 0; j < i; j++){     
          if (in[i] == in[j]){
              if (in[i] == 0){
                  // if they are 0 it is ok
        	  is_valid[i][j] <-- 1;
              } else{
                  is_valid[i][j] <-- 0;
              }
              
          } else{
              // they are different, ok
              is_valid[i][j] <-- 1;
          }
      }
   } 
   
   // check that is_valid is always 1
   var total_number = 0;
   var total_valid = 0;
   for (var i = 0; i < 9; i++){
      for (var j = 0; j < i; j++){
          total_number += 1;
          total_valid += is_valid[i][j];
      }
   }
   signal output out <-- total_number == total_valid;
}


template all_valid_rows() autocomplete{

     signal input in[9][9];
     component checks[9];
     var sum_valid_row = 0;
     
     for (var i = 0; i < 9; i++){
        checks[i] = different_numbers();
        checks[i].in <-- in[i];
        sum_valid_row += checks[i].out;
     }
     
     signal output out <-- sum_valid_row == 9;

}

template all_valid_columns() autocomplete{
     signal input in[9][9];
     component checks[9];
     var sum_valid_column = 0;
     
     for (var i = 0; i < 9; i++){
        checks[i] = different_numbers();
        for (var j = 0; j < 9; j++){
           checks[i].in[j] <-- in[j][i];
        }
        sum_valid_column += checks[i].out;
     }
     
     signal output out <-- sum_valid_column == 9;

}

template all_valid_sectors() autocomplete{
     signal input in[9][9];
     component checks[9];
     var sum_valid_sector = 0;
     
     for (var i = 0; i < 9; i++){
        checks[i] = different_numbers();
        
        
        var init_row = (i \ 3) * 3;
        var init_column = (i % 3) * 3;
        
        for (var j = 0; j < 9; j++){
           var desp_row = j \ 3;
           var desp_column = j % 3;
           
           checks[i].in[j] <-- in[init_row + desp_row][init_column + desp_column];
        }
        sum_valid_sector += checks[i].out;
     }
     
     signal output out <-- sum_valid_sector == 9;
}



template valid_sudoku() autocomplete{
     signal input in[9][9];
     
     
     // First check that all numbers are in the range 1-9 or are 0s
     component check_numbers = valid_numbers();
     check_numbers.in <-- in;
     signal all_valid <-- check_numbers.out;
     
     
     // Next check that the values in each row are different
     component check_rows = all_valid_rows();
     check_rows.in <-- in;
     signal all_valid_rows <-- check_rows.out;
     
     // Check that the values in each column are different
     component check_columns = all_valid_columns();
     check_columns.in <-- in;
     signal all_valid_columns <-- check_columns.out;
     
     // check that the values in each sector are different
     component check_sectors = all_valid_sectors();
     check_sectors.in <-- in;
     signal all_valid_sectors <-- check_sectors.out;
     
     
     signal output out <-- (all_valid + all_valid_rows + all_valid_columns + all_valid_sectors) == 4;
}


component main = valid_sudoku();
