import urllib2
from bs4 import BeautifulSoup
from fake_useragent import UserAgent
import csv
import pandas as pd


#headers
ua = UserAgent()
headers = {'User-Agent':str(ua.chrome)}

#get reviews from a specific page
def getReview(pageNumber):

    amazonReviewArray = [];
    #page URLs
    chuck = "https://www.amazon.com/Converse-Unisex-Chuck-Taylor-Sneakers/product-reviews/B01G2N1WKU/ref=cm_cr_arp_d_paging_btm_2?ie=UTF8&reviewerType=avp_only_reviews&pageNumber="
    asics = "https://www.amazon.com/ASICS-Mens-Venture-Trail-Running/product-reviews/B00Q2JC290/ref=cm_cr_dp_d_show_all_top?ie=UTF8&reviewerType=avp_only_reviews&pageNumber="
    newBalance = "https://www.amazon.com/New-Balance-Mens-MX608V4-Training/product-reviews/B00IYAG7DW/ref=cm_cr_dp_d_show_all_top?ie=UTF8&reviewerType=avp_only_reviews&pageNumber="
    sketchers = "https://www.amazon.com/Skechers-Afterburn-Memory-Foam-Lace-up-Sneaker/product-reviews/B00DJSRER2/ref=cm_cr_dp_d_show_all_top?ie=UTF8&reviewerType=avp_only_reviews&pageNumber="
    nike = "https://www.amazon.com/Nike-Mens-Monarch-Training-Shoe/product-reviews/B004K4GNF8/ref=cm_cr_arp_d_paging_btm_2?ie=UTF8&reviewerType=avp_only_reviews&pageNumber="
    
    page = urllib2.urlopen(chuck + str(pageNumber))


    soup = BeautifulSoup(page)
    soupString = str(soup)
    beforeReview = soupString.split('review-body">',1)[1];

    #extract every review from the page
    for reviewNumber in range(10):

        theReview = beforeReview.split('</span>',1)[0]
        # print("\n\n" + theReview);
        amazonReviewArray.append(theReview);

        if(reviewNumber < 9):
            beforeReview = beforeReview.split('review-body">',1)[1];
        else:
            break;
    # print("This is the array : Amazon Review Array " + str(number) + "   " + str(amazonReviewArray))

    # print(amazonReviewArray);
    return amazonReviewArray;



#return list of reviews from the page
#then append that list to all reviews
#then return ALL reviews

def getAllReviews(howManyPages):

    allAmazonReviewsArray = []
    theCurrentPageNumber = 1;
    for pageNumber in range(howManyPages):

        try:
           theReviewsFromPage = getReview(theCurrentPageNumber)
           # print(theReviewsFromPage)
           allAmazonReviewsArray.extend(theReviewsFromPage);
           # print(allAmazonReviewsArray)
           theCurrentPageNumber = theCurrentPageNumber + 1;
           print("Getting page ## " + str(theCurrentPageNumber-1));
           if(theCurrentPageNumber == howManyPages + 1):
                return allAmazonReviewsArray;

        except urllib2.HTTPError as err:
           if err.code == 503:
                print("There's an error on page: " + str(theCurrentPageNumber))
                # getAllReviews(theCurrentPageNumber);
                # if(theCurrentPageNumber == 10):
                #     return;
    # print("It is none" + allAmazonReviewsArray);
    return allAmazonReviewsArray;


#get reviews of X amount of pages
theReviewsOutput = getAllReviews(200)

# print(theReviewsOutput);

# thefile = open('reviews.txt', 'w')

# for item in theReviewsOutput:
#   thefile.write("%s\n" % item)


#export to CSCV
df = pd.DataFrame(theReviewsOutput, columns=["review"])
df.to_csv('reviewsChuck200.csv', index=False)
print("All Done!");

