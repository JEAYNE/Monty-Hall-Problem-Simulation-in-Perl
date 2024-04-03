#!/usr/bin/perl
use strict; use warnings;

my $N=100000;

my $sumWin_1st = 0;
my $sumWin_chg = 0;
my $sumWin_rnd = 0;

my $nDoors = 3;
my ($carDoor, $choice1);
for my $i (1..$N){
    $carDoor = int(rand($nDoors));     # secret position of the car
    $choice1 = int(rand($nDoors));     # the player make his first choice

    # The host opens an 'empty' door (neither the one with the car nor the one selected by the player)
    # At this stage there are two doors closed, the car is behind one of them.
    # Then the host suggests that the player:
    #   - keeps his first choice (strategy #1)
    #   or
    #   - changes his mind and chooses the other door (strategy #2)
    # I add this option:
    #   - chooses randomly one of the closed door (strategy #3)

    if( $choice1 == $carDoor ){
        $sumWin_1st++;            # Strategy #1: The player keeps his first choice
    }else{
        $sumWin_chg++             # Strategy #2: The player changes his mind and chooses the other door
    }
    $sumWin_rnd += int(rand(2));  # Strategy #3: The player chooses randomly one of the closed door. The car is behind one of them.
}

print(
  "\nMONTY HALL simulation\n\n",
  "% of wins depending on the strategy used by the player.\n",
);
printf("(Result after %d simulations)\n\n", $N);
printf("          By keeping his choice: %5.2f%%\n", 100*$sumWin_1st/$N);
printf("         By changing his choice: %5.2f%%\n", 100*$sumWin_chg/$N);
printf("By changing randomly his choice: %5.2f%%\n", 100*$sumWin_rnd/$N);

__END__
