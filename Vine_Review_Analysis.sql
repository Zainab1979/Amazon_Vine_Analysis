
/* Filter the data and create a new DataFrame or table
to retrieve all the rows where the total_votes count is equal 
to or greater than 20 to pick reviews that are more likely to be helpful
and to avoid having division by zero errors later on. */

create table Vine_GreaterThan20 as 
select * 
from vine_table 
where total_votes >=20;



/* Filter the new DataFrame or table created in Step 1 and 
create a new DataFrame or table to retrieve all the rows
where the number of helpful_votes divided by total_votes is equal to or greater than 50%.

If you use the SQL option below, you’ll need to cast your columns as floats
using WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5.

*/

create table Vine_GreaterThan50Percent as 
select * 
from vine_greaterThan20 
where  CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

/* Filter the DataFrame or table created in Step 2, and create a new DataFrame or table that retrieves 
all the rows where a review was written as part of the Vine program (paid), vine == 'Y'. */

create table VineProgramPaid as 
select * 
from Vine_GreaterThan50Percent 
where vine = 'Y';




/* Repeat Step 3, but this time retrieve all the rows where the review was not part 
of the Vine program (unpaid), vine == 'N'. */

create table VineProgramNotPaid as 
select * 
from Vine_GreaterThan50Percent 
where vine = 'N';


/* Determine the total number of reviews, the number of 5-star reviews,
and the percentage of 5-star reviews for the two types of review (paid vs unpaid). */

select (select count(*) from VineProgramNotPaid) Totalreview_Unpaid,count(*)  No_of_5star_reviews_unpaid,
count(*)*100/(select count(*) from VineProgramNotPaid) as Percentageof5_star_unpaid
from vineProgramNotPaid 
where star_rating = 5 ;

select (select count(*) from VineProgramPaid) Totalreview_paid,count(*)  No_of_5star_reviews_paid,
count(*)*100/(select count(*) from VineProgramPaid) as Percentageof5_star_paid
from vineProgramPaid 
where star_rating = 5;















