{% docs dim_data_doc %}


**Table: dim_data**

| Column Name   | Description                                               |
| ------------- | --------------------------------------------------------- |
| DATE_KEY      | Unique identifier or key for each date.                    |
| FULL_DATE     | The complete date in the format 'YYYY-MM-DD'.              |
| DAY_OF_WEEK   | Numeric representation of the day of the week.             |
| DAY_OF_MONTH  | The day of the month.                                     |
| DAY_OF_YEAR   | The day of the year.                                      |
| DAY_NAME      | The name of the day of the week.                           |
| WEEK_OF_MONTH | The week number within the month.                          |
| WEEK_OF_YEAR  | The week number within the year.                           |
| MONTH_OF_YEAR | Numeric representation of the month.                       |
| DAYS_IN_MONTH | The number of days in the month.                           |
| MONTH_NAME    | The name of the month.                                    |
| YEAR          | The year associated with the date.                         |

The `dim_data` table represents a dimension table containing date-related information. Each column provides specific attributes and metrics related to dates, including identifiers, calendar information, and temporal properties.


{% enddocs %}
