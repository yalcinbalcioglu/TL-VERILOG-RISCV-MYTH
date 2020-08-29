\m4_TLV_version 1d: tl-x.org
\SV
//RISC-V labs solutions here

   |cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? '0 : >>1$pc+1;
         $imem_rd_addr[M4_IMEM_INDEX_CNT-1:0] = $pc[M4_IMEM_INDEX_CNT+1:2];
         $imem_rd_en = !$reset;


      // YOUR CODE HERE
      @1
         $instr[31:0] = $imem_rd_data[31:0];
         $is_i_instr = $instr[6:2] ==? 5'b00000 ||
                       $instr[6:2] ==? 5'b00001 ||
                       $instr[6:2] ==? 5'b00100 ||
                       $instr[6:2] ==? 5'b00110 ||
                       $instr[6:2] ==? 5'b11001 ;
                       
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b01100 ||
                       $instr[6:2] ==? 5'b01110 ||
                       $instr[6:2] ==? 5'b10100 ;
                       
         $is_s_instr = $instr[6:2] ==? 5'b01000 ||
                       $instr[6:2] ==? 5'b01001 ;                       

         $is_b_instr = $instr[6:2] ==? 5'b11000 ;                          
         $is_j_instr = $instr[6:2] ==? 5'b11011 ;    
         
         $is_u_instr = $instr[6:2] ==? 5'b00101 ||
                       $instr[6:2] ==? 5'b01101 ;  
                       
         $imm[31:0] = $is_i_instr ? { {21{$instr[31]}}, $instr[30:20] } :              
                      $is_s_instr ? { {21{$instr[31]}}, $instr[30:25], $instr[11:8], $instr[7] } : 
                      $is_b_instr ? { {20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0 } : 
                      $is_u_instr ? { $instr[31], $instr[30:20], $instr[19:12], 12'b0 } :  
                                    { {12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:25], $instr[24:21], 1'b0 } ;
      
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
         
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0]  = $instr[11:7];
            
         $opcode[6:0] = $instr[6:0];
         
         $funct7_valid = $is_r_instr;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
