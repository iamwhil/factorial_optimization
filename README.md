# Factorial Optimization

## Justification

At the University of Hawaii at Manoa we utilized factorial design of experiments in order to opitmize the performance of non-thermal plasma reformers.  Lots of words there - phew.  I got to use and be prevy to very similar if not exactly the same design of experiment methodology at General Motors - Fuel Cell Activities, Moneta Trades, and PAIRIN for algorithm optimization. However, it was mostly done by hand and Microsoft Excel. Which is a wonderful tool for this kind of work.

However I started to wonder, would it be possible to automate the design of the experiment?  Would it be possible to automate the calculation of main and interaction effects?  Would it be possible to calculate the path of steepest ascent through the factor space? Would it be possible to automate the journey through the path of steepest ascent, find the maximum along that line, identify a new center point, and repeat?  Basically automate the entire process until the optimal point within a factor space was discovered... and not in VBA :P.

Previously I had the experience of having to design the experiment - and then run all of the tests!  That could take a day per test.  Well then, a 2^3 experiment would have 8 runs and take 8 days.  4 parameters and we're looking at 16 days of straight experiments.

Well what if we could build a model or simulate some sort of experiment?  Well then we can pass in the parameters and get back the results.  Now we're just bound by how long a simulation takes to run.

And I have some algorithims I'd love to optimize a bit better, and what do you know they're written in ruby.  So I guess I'll see if I can get the entiery of the factorial optimization done in ruby as well!

## Background

When I get to it I'll explain some math and why factorial experiments out perform parametric experiments when it comes to optimization.

## Setup

This is all forth coming but I'll keep some running notes in here!

### Input parameters - from csv. 
* Specify the name of the parameter
* Specify the parameter's minimum and maximum values.

### Look at parameters and break each into equal percentage increments. 
* Should account for integers and floats.

### Build Factorial Design / Matrix

### Store Matrix X and Y
* Factorial design matrix is 'X'
* Solution matrix is 'Y'

### Analyze Completed factorial experiment
* When every run in the test has a corresponding result in the Y matrix - calculate the effects.

### Store the effects

### Calculate path of steepest ascent

### Perform tests along path of steepest ascent

### Find new center point from maximum of path of steepest ascent

### Build new test around new center point and repeat.

### Exclude optimized parameters from the test.

### Nice to have:
* Random point feature - creates an initial experiment with n runs at random points in the factor space.
* Start experiment at dead middle of the factor space.

### Allow for manual input of test results.
* Who knows if someone will stumble across this and use it instead of excel.  
* I doubt it, but why not have the option to manually put in individual run results.