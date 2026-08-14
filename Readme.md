## **Manufacturing Performance \& OEE Analytics Dashboard**



An end-to-end manufacturing analytics project using MySQL, SQL, and Power BI to analyze production performance, equipment efficiency, and downtime.



* ### Overview



The objective of this project is to analyze manufacturing production data and identify performance gaps across machines, shifts, and downtime categories.



The analysis focuses on four key manufacturing KPIs:



1. Overall Equipment Effectiveness (OEE)
2. Availability
3. Performance
4. Quality



SQL was used for data preparation, aggregation, KPI calculations, and analysis. Power BI was then used to build an interactive dashboard for visualizing the results.



* ### Tools Used



1. MySQL
2. SQL
3. Power BI
4. CSV



* ### Dataset



The project uses two main datasets.

##### 

##### Production Data

Contains production-level information including:



1. Production ID
2. Machine ID
3. Production Date
4. Shift
5. Product
6. Target Quantity
7. Actual Quantity
8. Production KPIs



##### Downtime Data

Contains information about downtime events including:



1. Downtime ID
2. Production ID
3. Downtime Reason
4. Downtime Duration in Minutes



* #### Project Workflow



Production \& Downtime Data

&#x20;           |

&#x20;           v

&#x20;         MySQL

&#x20;           |

&#x20;           v

&#x20;   SQL Data Analysis

&#x20;           |

&#x20;           v

&#x20;  KPI / OEE Calculations

&#x20;           |

&#x20;           v

&#x20;       Power BI

&#x20;           |

&#x20;           v

&#x20;   Interactive Dashboard

&#x20;           |

&#x20;           v

&#x20;    Business Insights



* #### Analysis



SQL was used to:



1. Explore and validate production and downtime data
2. Aggregate production records
3. Calculate OEE-related KPIs
4. Analyze machine-wise performance
5. Analyze downtime by reason
6. Compare target and actual production
7. Analyze production performance across shifts
8. Create the KPI view used for the Power BI dashboard
9. Power BI Dashboard



The dashboard includes:



1. KPI Cards
Overall OEE
Availability
Performance
Quality
2. Visualizations
OEE by Machine
Downtime by Reason
Target vs Actual Production by Shift
Daily OEE Trend
3. Filters
Machine
Shift



* ### Dashboard Analysis and Insights



The Power BI dashboard was developed to provide a consolidated view of manufacturing performance and identify areas that may require operational attention.



##### Overall Manufacturing Performance



The overall OEE was 82.67%, with:



1. Availability: \*\*89.94%\*\*
2. Performance: \*\*93.12%\*\*
3. Quality: \*\*98.76%\*\*



The relatively high quality score indicates that product quality remained strong, while the lower OEE compared with the individual component metrics suggests that availability and performance losses are contributing to the overall efficiency gap.



##### Machine-wise OEE



Machine-level analysis showed variation in equipment performance:



| Machine | Average OEE |

|---------|-------------|

|  M001   |   82.40%    |

|  M002   |   84.58%    |

|  M003   |   81.00%    |



**M002** recorded the highest average OEE at 84.58%, while **M003** recorded the lowest at 81.00%.



The 3.58 percentage-point difference between M002 and M003 indicates that machine-level performance is not uniform. M003 can therefore be considered a potential area for further investigation.



##### Downtime Analysis



Downtime was analyzed by reason to identify the major contributors to lost production time.



|  Downtime Reason | Total Downtime |

|------------------|----------------|

|  Operator Delay  |   413 min      |

|Material Shortage |   401 min      |

|Mechanical Failure|   391 min      |



**Operator Delay** was the largest contributor with 413 minutes of downtime, followed closely by Material Shortage and Mechanical Failure.



Since the difference between the three categories is relatively small, improvement efforts should not focus on operator delays alone. All three categories represent potential areas for reducing downtime.



##### Target vs Actual Production



Production targets were compared with actual output across shifts.



|  Shift  | Target | Actual |  Gap  |

\-------------------------------------

| Shift 1 | 76,880 | 70,880 | 6,000 |

| Shift 2 | 73,590 | 66,890 | 6,700 |

| Shift 3 | 65,370 | 61,500 | 3,870 |



**Shift 2** recorded the largest production gap of 6,700 units indicating the largest difference between planned and actual production among the three shifts.



Shift 3 had the smallest absolute gap at 3,870 units.



This suggests that Shift 2 may require further investigation into factors such as downtime, machine performance, or operating conditions.



##### Daily OEE Trend



The daily OEE trend showed noticeable fluctuations across production days rather than a consistent upward or downward pattern.



OEE reached approximately 84.4% at its highest point and dropped to around 81% at lower points in the period.



This indicates variation in equipment performance over time and suggests that lower-performing days could be investigated further to identify the operational factors contributing to these fluctuations.



* #### Key Takeaways



The dashboard highlights four main areas for further investigation:



1\. **M003** has the lowest machine-level OEE and may require performance analysis.

2\. **Operator Delay** contributes the highest downtime among the analyzed reasons.

3\. **Shift 2** has the largest target-to-actual production gap.

4\. **Daily OEE fluctuates**, indicating that equipment performance is not completely consistent across production days.



These findings demonstrate how the dashboard can be used not only to monitor KPIs but also to identify specific areas for operational investigation.

