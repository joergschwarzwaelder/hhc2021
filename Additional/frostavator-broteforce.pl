#!/usr/bin/perl
use Data::Dumper;
use Algorithm::Permute;
use strict;

#
# Input Lines
#
my @in=(0,1,0,1);

#
# Connections of Input Lines to Layer 1 Gate Inputs
#
my @gatein1=([$in[0],$in[1]],[$in[1],$in[2]],[$in[2],$in[3]]);

my $perm=Algorithm::Permute->new(['AND','OR','NAND','NOR','XOR','XNOR']);

while(my @sol=$perm->next){
  my @gateout1;
  for(my $i=0;$i<=2;$i++){
    $gateout1[$i]=calc($gatein1[$i],$sol[$i]);
  }

#
# Connections of Layer 1 Gate Outputs to Layer 2 Inputs
#
  my @gatein2=([$gateout1[0],$gateout1[1]],[$gateout1[0],$gateout1[2]],[$gateout1[1],$gateout1[2]]);
  my @gateout2;
  for(my $i=0;$i<=2;$i++){
    $gateout2[$i]=calc($gatein2[$i],$sol[$i+3]);
  }
#
# Check of Layer 2 Outputs
#
  if($gateout2[0]&&$gateout2[1]&&$gateout2[2]){
    printf "Solution: %s\n",join(",",@sol);
  }
}

#
# Calculate Logic Gate with two Inputs
#
sub calc(){
  my ($gatein_ref,$type)=@_;
  my @gatein=@{$gatein_ref};
  return $gatein[0]&&$gatein[1] if($type eq "AND");
  return $gatein[0]||$gatein[1] if($type eq "OR");
  return $gatein[0]^$gatein[1] if($type eq "XOR");
  return not $gatein[0]&&$gatein[1] if($type eq "NAND");
  return not $gatein[0]||$gatein[1] if($type eq "NOR");
  return 0+(not $gatein[0]^$gatein[1]) if($type eq "XNOR");
}
