# Analysis of laptop processors

## Background

I have four laptop processors that I'm interested in comparing. They are Intel
processors from 2012 to 2025. From working with these laptops, I already know
that the newer ones tend to run things a bit faster, but I'd like to see actual
measurements. My main performance criterion is single-thread speed, but I'm also
interested in other technical properties and trends beyond those four
processors.

The primary goal is to satisfy my curiosity, but the insights gained from the
analysis can be useful to inform decisions for future hardware purchases.

Written in reproducible TAF format, the intention is to make it easy to run the
analysis with a different set of processors.

## Questions

**1. [benchmark_actual](benchmark_actual)**

- How fast are the four processors, based on actual measurements from running a
  stock assessment model?

- Is the speed (model iterations per second) very different between a short job
  that takes seconds to complete and a longer job that takes minutes?

**2. [benchmark_local](benchmark_local)**

- How fast are the four processors, based on local benchmark results?

- Is the difference between single-thread and multithread performance roughly
  proportional to the number of physical cores?

- Do newer memory modules get higher scores in the memory benchmark results?

**3. [benchmark_online](benchmark_online)**

- How quickly has single-thread performance increased over the last fifteen
  years?

- Have some processor generations provided massive performance improvements,
  while other generations provided negligible improvements?

- How do the trends vary between Intel, AMD, and Apple? Are some of them a year
  or more behind the others?

- Can low-powered processors provide decent single-thread performance compared
  to the high-powered processors?

- Did single-thread performance increase at a similar rate in the old days (from
  2000 to 2010) compared to the later period since 2010?

**4. [benchmark_summary](benchmark_summary)**

Comparing the results from **benchmark_actual**, **benchmark_local**, and
**benchmark_online**. The general question is how accurately do online reported
benchmark results transfer to actual performance running stock assessment
models.

- How different are the actual speed measurements from what we would expect
  based on the local synthetic benchmark results?

- How different are the local benchmark results from online averages for that
  processor?

**5. [monitor_cpumon](monitor_cpumon)**

- In idle conditions, what is the *frequency*, *temperature*, and *fan speed*
  for each processor?

- When running a stock assessment model, how does the processor *frequency*,
  *temperature*, and *fan speed* change over time?

- How different is the processor *frequency*, *temperature*, and *fan speed*
  when the sustained load is single-thread vs. multithread?

- Are some of the machines throttling, repeatedly varying the processor
  frequency up and down as it hits thermal limits?

- If there is an initial short-term peak in processor frequency followed by a
  lower stable condition, how different is the initial frequency from the
  sustained frequency, and how long does the initial boost last?

- How are the thermal and performance profiles different between the older and
  newer machines, or between high-powered and low-powered machines?

- How do the observed idle, single-thread, and multithread frequencies compare
  with the official manufacturer specifications for that processor?

- In idle and single-thread loads, are all the cores running at similar
  frequency or very different?

**6. [monitor_turbostat](monitor_turbostat)**

Similar to **monitor_cpumon** but using different processor monitoring software.
They give slightly different results and measure different variables: while
cpumon measures the frequency of each core and the fan speed, turbostat measures
processor wattage.

- In idle conditions, what is the *frequency*, *temperature*, and *wattage* for
  each processor?

- When running a stock assessment model, how does the processor *frequency*,
  *temperature*, and *wattage* change over time?

- How different is the processor *frequency*, *temperature*, and *wattage* when
  the sustained load is single-thread vs. multithread?

- Are some of the machines throttling, repeatedly varying the processor
  frequency up and down as it hits thermal limits?

- If there is an initial short-term peak in processor frequency followed by a
  lower stable condition, how different is the initial frequency from the
  sustained frequency, and how long does the initial boost last?

- How are the thermal and performance profiles different between the older and
  newer machines, or between high-powered and low-powered machines?

- How do the observed idle, single-thread, and multithread frequencies and
  wattage compare with the official manufacturer specifications for that
  processor?

**7. [my_laptops](my_laptops)**

Historical overview of ten laptops I have worked on between 2005 and 2026.

- How do processor properties vary between the machines: frequency, number of
  cores, cache size, watts, process nm, and synthetic benchmark results?

- How do other components vary between the machines: memory, storage, display,
  and laptop size?

- How are the trends different between high-powered and low-powered machines?

- What are the temporal trends and have the changes been relatively steady over
  time?

- Has performance per watt increased steadily over the years, and is the
  performance per watt similar between the high-powered and low-powered
  machines?

- Which variables are most closely related to single-thread performance?
