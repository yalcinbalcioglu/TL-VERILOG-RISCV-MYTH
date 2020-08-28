\m4_TLV_version 1d: tl-x.org
\SV
//Calculator labs solutions here

   $out = ! $in1;
   
   $out2 = $in2 & $in3;
   
   $out3[4:0] = $in4[3:0] + $in5[3:0];
   
   $out4[7:0] = $sel ? $in1[7:0] : $in2[7:0];

   $val1[31:0] = $rand1[3:0];
   $val2[31:0] = $rand2[3:0];
   
   $sum[31:0] = $val1 + $val2;
   $diff[31:0] = $val1 - $val2;
   $prod[31:0] = $val1 * $val2;
   $quot[31:0] = $val1 / $val2;
   
   $out[31:0] = $op[1:0]==0 ? $sum : $op[1:0]==1 ? $diff : $op[1:0]==2 ? $prod : $quot;
   
   $cnt[31:0] = $reset ? 1 : (>>1$cnt + 1);
