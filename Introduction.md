---
title: "Introduction"
output: html_notebook
---

## Project Synopsis

This project undertakes to analyze and parametarize the event process/es for messages arriving to a black box application and the corresponding impact on message latency(processing time) on the outbound messages from the black box.  It's assumed that the primary influence on processing time/latency is the arrival frequency of inbound messages.

In the first instance we will simply be analyzing the event timing in both the time and frequency domains.  The goal will be to establish some parameteraization so that going forward we can identify patterns in the event timing.  E.g. Are the events 'random'? What is a normal residual 'random' arrival?  How can we parameterize / define a 'burst' of activity.  What constitutes an event frequency outlier (high rate, low rate, burst)?

We will need to establish methodologies for calculating 'rates'.  We can start with simply the timestamps of the message arrival time.  But we also have message size data so we could extend this to a 'bit rate' if required.  Appropriate methodologies for deriving frequency 'rates' could include Moving Average / Sliding Window, Leaky Integrator, etc.

If we consider the black box as being capable of some constant measure of 'processing rate (or work)', and the inbound messages as a measure of incoming work to be processed, we could conceivably model the system as a 'work engine' and establish the parameters such that the work rate in the model reflects the observed work rate as defined by the observed latency in message processing.

An other potential starting place would be to calculate the number of messages 'in queue' based on the arrival times, latency and hence departure times.

## Primary goals

Establish parameters to model the message latency (processing time) given a sequence of input messages over time with at least a 95% confidence.
 
## Secondary goals

Establish some data science standard operating procedures and best practices.

  - Data Governance
  - Experiment Management
  - Project Code Structure
  - Repository & Branching Models
  - Project Tasks/Experiment Itemization and Prioritization
  - Documentation and Communication Procedures

## Reading List

## Tools and Methodologies

## Data Sourcing

## Possible Exploratory Models

### Event frequency distribution
  
- Non-homogenous Poisson Oriented Models; Hawkes Process
- Self-Exciting Point Process
- Regime Switching
- ...

### Dynamic Change

Step Detection

### Rate / Frequency smoothing

- Moving Average
- Leaky Integrator
- Other Sliding Window Techniques
