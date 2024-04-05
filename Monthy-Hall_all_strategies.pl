#!/usr/bin/perl
use strict;
use warnings;

# number of simulations for each run
my $N=100000;

# select randomly in the list of parameters
sub rnd { return @_[rand(@_)]; }

sub run {
    my $win = 0;
    my ($strategy, $carDoor, $choice1);
    for my $i (1..$N){
        $strategy= rnd(@_);      # select one of the strategies allowed
        $carDoor = rnd(1,2,3);   # secret position of the car
        $choice1 = rnd(1,2,3);   # the player makes his first choice
        if( $strategy==1 ){
            $win++ if $choice1 == $carDoor;
        }elsif( $strategy==2 ){
            $win++ if $choice1 != $carDoor;
        }elsif( $strategy==3 ){
            $win += rndFrom(0,1);
        }
    }
    return $win;
}

print ("\nMONTY HALL simulations\n\n");
print ("% of wins depending on the strategies used by the player.\n");
printf("(Results after %d simulations for each strategy)\n\n", $N);
printf("#1                  the player keeps his choice: %5.2f%% (expected: 33.33)\n", 100*run(1)/$N);
printf("#2                the player changes his choice: %5.2f%% (expected: 66.66)\n", 100*run(2)/$N);
printf("#3       the player changes randomly his choice: %5.2f%% (expected: 50.00)\n", 100*run(3)/$N);
printf("the player mixes randomly strategies #1, #2    : %5.2f%% (expected: 50.00)\n", 100*run(1,2)  /$N);
printf("the player mixes randomly strategies #1, #3    : %5.2f%% (expected: 41.66)\n", 100*run(1,3)  /$N);
printf("the player mixes randomly strategies #2, #3    : %5.2f%% (expected: 58.33)\n", 100*run(2,3)  /$N);
printf("the player mixes randomly strategies #1, #2, #3: %5.2f%% (expected: 50.00)\n", 100*run(1,2,3)/$N);

__END__
