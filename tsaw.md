# TSAW
In early September 2023, a company named Kalshi visited our career fair looking for data scientists and developers. Of course, I was interested so I did my due diligence on the company.
I was instantly engaged by their product. Essentially, they offer markets to trade on outcomes of events. After scouring the markets they had listed I decided to take a shot at TSAW.  

For the sake of competition, the repository I did this research in is private and some parts of this writeup are a bit nondescript. 

## Market Structure
Kalshi's market structure is beautifully simple. For a given event, you can buy/sell "yes" and "no" contracts that the event will occur.
Each "yes" pays out $1 if the event happens, and similarly so does each "no" if the event doesn't.
It is worth noting that buying "yes" = selling "no" and selling "yes" = buying "no", so there is really only one kind of contract being traded.  

TSAW specifically is the event that the daily average number of TSA check-ins over the last week will be above a given strike. 
The market is structured as a set of 6 order books, one for each strike at 2.1m, 2.2m ... 2.6m. 

## Model Development
My aim was to try to emulate some of the strategies I had learned in my recent Quantitative Research Internship at XR Trading.
I'll provide a brief outline of the steps I took to arrive at my final model.
#### Data Collection
Thankfully, the data I needed was easy to access. [The TSA website](https://www.tsa.gov/travel/passenger-volumes) is kind enough to log daily check-in volumes, and Kalshi has a fantastic API.
After some API calls and a little web scraping, I had two pretty .csv's for the market history for TSAW and check-in data.
#### Variable Creation
As with last summer, there were some human-intuitive trends clearly at play in the market. 
I spent a few hours playing around with the data to see what parts of my intuition were accurate, then did some work in Pandas to create variables representing the trends I saw and tested.
#### Machine Learning!
Now I had a nicely formatted problem. From a few key variables, predict the average number of people that will check in to TSA each day that week. I tried a few models with two strategies.  

The first strategy was to predict the final value outright. For this, I used some of the standard out-of-box regressors (Random Forest, XGB, LGBM, NN).  

The second strategy was to predict tomorrow's value, update the predictor variables, and then predict again until we reached the end of the week.
Then our final value is just the simple average of the values for that week. Here I tried SARIMA as well as LGBM and XGB.
#### Modeling a Price
Once I settled on a predictor, I created a price estimation system. 
1. Take the difference between a given strike $y$ and the predicted final value $\hat{y}$ as $r$
2. For an approximated residual distribution $R$ with $P(R = r) = f(r)$, calculate the price as $1 - \int_r^{\infty}f(x)dx$
#### Testing Results
Time to apply our model to some market data! Our strategy is pretty simple. Buy a yes if it's cheaper than our predicted price, and sell one if it's more. (There is some extra spice here - but that's my secret).
After some time developing a backtesting system, I arrived at the moment of truth. And the result. For every dollar we bet, we have an expected value of...  


# 1.17!
