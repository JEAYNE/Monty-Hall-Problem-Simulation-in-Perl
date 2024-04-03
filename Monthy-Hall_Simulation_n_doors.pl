#!/usr/bin/perl
use strict; use warnings;

my $maxDoors = ($ARGV[0]||0) <3 ?     20: $ARGV[0];
my $N        = ($ARGV[1]||0) <1 ? 100000: $ARGV[1];

print(
  "\nMONTY HALL simulation with n doors\n\n",
  "% of wins depending on the strategy used by the player and the number of doors.\n",
  "(Result after $N simulations for each number of doors)\n\n",
  "+-doors-+--1st--+--Chg--+--Rnd--+\n"
);

for my $nDoors (3..$maxDoors){
    my $sumWin_1st = 0;
    my $sumWin_chg = 0;
    my $sumWin_rnd = 0;

    my($carDoor, $open, $choice1, $choice2);
    for my $i (1..$N) {
        $carDoor = int(rand($nDoors));  # secret position of the car
        $choice1 = int(rand($nDoors));  # the player make his first choice

        # The host opens an 'empty' door (neither the one with the car nor the one selected by the player)
        do { $open = int(rand($nDoors)) } while(($open==$carDoor) or ($open==$choice1));

        # The host suggest that the player:
        #   - keeps his first choice (strategy #1)
        #   or
        #   - changes his mind and chooses the other door (strategy #2)
        # I add this option:
        #   - chooses randomly one of the closed door (strategy #3)

        if( $choice1==$carDoor ){
            # Strategy #1: The player keeps his first choice.
            $sumWin_1st++;
        }else{
            # Strategy #2: The player changes his mind and chooses another door; ($nDoors - 2) possibilities.
            do { $choice2 = int(rand($nDoors)) } while(($choice2==$open) or ($choice2==$choice1));
            $sumWin_chg++ if $choice2==$carDoor;
        }

        # Strategy #3: The player chooses randomly one of the closed door; ($nDoors - 1) possibilities.
        do { $choice2 = int(rand($nDoors)) } while($choice2==$open);
        $sumWin_rnd++ if $choice2==$carDoor;
    }

    printf("|   %2d  | %5.2f | %5.2f | %5.2f |\n",
           $nDoors, 100*$sumWin_1st/$N, 100*$sumWin_chg/$N, 100*$sumWin_rnd/$N);
}

__END__
