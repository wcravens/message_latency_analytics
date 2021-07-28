---
title: "MSFE-IE522 Statistical Methods Summer Project"
author: "Wes Cravens"
date: "7/12/2021"
---

## Project Synopsis

This project undertakes to analyze and parametarize the event process/es for messages arriving to a black box application and the corresponding impact on message latency on the outbound messages from the black box.  It's assumed that the primary influence on processing time/latency is the arrival frequency of inbound messages.

In the first instance we will simply be analyzing the event timing in both the time and frequency domains.  The goal will be to establish some parameteraization so that going forward we can identify patterns in the event timing.  E.g. Are the events 'random'? What is a normal residual 'random' arrival?  How can we parameterize / define a 'burst' of activity.  What constitutes an event frequence outlier (high rate, low rate, burst)?

We will need to establish methodologies for calculating 'rates'.  We can start with simply the timestamps of the message arrival time.  But we also have message size data so we could extend this to a 'bit rate' if required.  Appropriate methodoligies could include Moving Average / Sliding Window, Leaky Integrator, etc.

If we consider the black box as being capable of some constant measure of 'processing rate', and the inbound messages as a measure of incoming work to be processed, we could concievably model the system as a 'work engine' and establish the parameters such that the work rate in the model reflects the observed work rate as defined by latency data on message processing.

An other potential starting place would be to calculate the number of messages 'in queue' based on the arrival times and latency.


## Primary goals

Establish parameters to model the message latency (processing time) given a sequence of input messages over time with at least a 95% confidence.
 
## Secondary Goals

Establish some data science standard operating procedures and best practices.

## Reading List

## Tools and Methodologies

## Data Sourcing


## Possible Exploratory Models

### Event frequency distribution
  
- Poisson Oriented Models
- Self-Exciting Point Process
- Regime Switching
- ...

### Rate / Speed smoothing

- Moving Average
- Leaky Integrator
- Other Sliding Window Techniques

### Dynamic Change

Step Detection

## Proposed Hypothesis

- Incoming message arrival time is not random.

## Next Steps for this week

- Start outline of best practices, needs and methodologies
- Data Provenance
- Reference Managmement (Jabref, Mendeley, Zotero)
- Project Directory structure
- Model Development
- R Studio, R Markdown & Knitr
- Documentation and Reporting
- Reading List

